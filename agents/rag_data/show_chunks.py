import pickle

# ======================================
# LOAD CHUNKS FILE
# ======================================

with open(

    "chunks.pkl",

    "rb"

) as f:

    chunks = pickle.load(f)

# ======================================
# TOTAL CHUNKS
# ======================================

print("\n===================================")

print(f"✅ TOTAL CHUNKS: {len(chunks)}")

print("===================================")

# ======================================
# SHOW ALL CHUNKS
# ======================================

for idx, chunk in enumerate(chunks):

    print(f"\n📦 CHUNK {idx + 1}")

    print("\n-----------------------------------")

    print(chunk)

    print("\n===================================")