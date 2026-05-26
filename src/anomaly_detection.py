import pandas as pd

from sklearn.ensemble import IsolationForest

# ======================================
# LOAD DATASET
# ======================================

df = pd.read_csv(

    "../data/processed/cleaned_walmart_dataset.csv"
)

# ======================================
# ANOMALY DETECTION FUNCTION
# ======================================

def detect_sales_anomalies():

    try:

        # ======================================
        # SELECT FEATURES
        # ======================================

        features = df[[

            "Weekly_Sales"
        ]]

        # ======================================
        # TRAIN ISOLATION FOREST MODEL
        # ======================================

        model = IsolationForest(

            contamination=0.005,

            random_state=42
        )

        model.fit(features)

        # ======================================
        # PREDICT ANOMALIES
        # ======================================

        df["Anomaly"] = model.predict(
            features
        )

        # ======================================
        # FILTER ANOMALIES
        # ======================================

        anomalies = df[

            df["Anomaly"] == -1
        ]

        # ======================================
        # SELECT IMPORTANT COLUMNS
        # ======================================

        results = anomalies[

            [
                "Store",
                "Dept",
                "Weekly_Sales"
            ]

        ].head(20)

        # ======================================
        # RETURN JSON
        # ======================================

        return {

            "total_anomalies":

            len(anomalies),

            "anomalies":

            results.to_dict(
                orient="records"
            )
        }

    except Exception as e:

        return {

            "error":
            str(e)
        }

# ======================================
# TEST
# ======================================

if __name__ == "__main__":

    output = detect_sales_anomalies()

    # ======================================
    # CLEAN OUTPUT FORMAT
    # ======================================

    print("\n====================================")

    print("🚨 SALES ANOMALY DETECTION RESULTS")

    print("====================================")

    print(

        f"\n✅ Total Anomalies Found: {output['total_anomalies']}"
    )

    print("\n📊 Top Detected Anomalies:\n")

    for idx, anomaly in enumerate(

        output["anomalies"],

        start=1
    ):

        print(

            f"""
Anomaly #{idx}

Store ID       : {anomaly['Store']}

Department ID  : {anomaly['Dept']}

Weekly Sales   : {anomaly['Weekly_Sales']}
"""
        )

    print("\n====================================")