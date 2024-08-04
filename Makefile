# コンパイラ
FC = gfortran
FFLAGS = -Wall -g -fbounds-check -O3

# ターゲット実行ファイル名
TARGET = DecisionTree

# ディレクトリ
MOD_DIR = modules
OBJ_DIR = build

# ソースファイル
MOD_SRC = $(MOD_DIR)/decision_tree_types.f90 $(MOD_DIR)/decision_tree_utils.f90 $(MOD_DIR)/decision_tree_split.f90 $(MOD_DIR)/decision_tree_metrics.f90 $(MOD_DIR)/decision_tree_build.f90 $(MOD_DIR)/decision_tree_io.f90
MAIN_SRC = main.f90

# オブジェクトファイル
MOD_OBJ = $(addprefix $(OBJ_DIR)/,$(notdir $(MOD_SRC:.f90=.o)))
MAIN_OBJ = $(OBJ_DIR)/main.o

# ルール定義
all: clean $(TARGET)

# ターゲットファイルの生成
$(TARGET): $(MOD_OBJ) $(MAIN_OBJ)
	$(FC) $(FFLAGS) -o $@ $(MOD_OBJ) $(MAIN_OBJ)

# モジュールファイルのコンパイル
$(OBJ_DIR)/%.o: $(MOD_DIR)/%.f90 | $(OBJ_DIR)
	$(FC) $(FFLAGS) -c $< -o $@ -J$(OBJ_DIR)

# メインファイルのコンパイル
$(OBJ_DIR)/main.o: main.f90 $(MOD_OBJ) | $(OBJ_DIR)
	$(FC) $(FFLAGS) -c main.f90 -o $(OBJ_DIR)/main.o -J$(OBJ_DIR)

# ビルドディレクトリの作成
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# クリーンアップ
clean:
	rm -f $(OBJ_OBJ) $(MAIN_OBJ) $(TARGET)
	rm -rf $(OBJ_DIR)

# 実行
run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run
