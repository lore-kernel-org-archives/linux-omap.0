From: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] dtc: parser: Add label while overriding nodes
Date: Fri, 20 Feb 2015 02:11:02 +0530
Message-ID: <1424378462-22105-1-git-send-email-nikhil.nd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, jdl-CYoMK+44s/E@public.gmane.org
Cc: devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch changes the dtc grammar to allow following syntax

i2cexp: &i2c2 {
    ...
};

Current device tree compiler allows to define multiple labels when defining
the device node the first time. Typically device nodes are defined in
DTSI files. Now these nodes can be overwritten for updating some of the
properties. Typically, device nodes are overridden in DTS files.

When working with adapter boards, most of the time adapter board can fit to
multiple base boards. But depending on which base board it is connected to,
the devices on the adapter board would be children of different devices.

e.g. On dra7-evm.dts, i2c2 is exported for expansion connector whereas
on dra72-evm.dts, i2c5 is exported for expansion connector.
This causes a problem when writing a generic device tree file for
the adapter board. Because, you cannot know whether all the devices on
adapter board are present on i2c or i2c5.

The problem can be solved by adding a common label (e.g. i2cexp) in both
of the DTS files when overriding the device nodes for i2c2 or i2c5.
This way, generic adapter board file would override the i2cexp. And
depending on which base board you use the adapter board, all the devices
are automatically added for correct device nodes.

Signed-off-by: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
---
 dtc-parser.y                       |   12 ++++++++
 tests/run_tests.sh                 |    2 ++
 tests/test_tree1_label_noderef.dts |   55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 tests/test_tree1_label_noderef.dts

diff --git a/dtc-parser.y b/dtc-parser.y
index ea57e0a..5a897e3 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -140,6 +140,18 @@ devicetree:
 		{
 			$$ = merge_nodes($1, $3);
 		}
+
+	| devicetree DT_LABEL DT_REF nodedef
+		{
+			struct node *target = get_node_by_ref($1, $3);
+
+			add_label(&target->labels, $2);
+			if (target)
+				merge_nodes(target, $4);
+			else
+				ERROR(&@3, "Label or path %s not found", $3);
+			$$ = $1;
+		}
 	| devicetree DT_REF nodedef
 		{
 			struct node *target = get_node_by_ref($1, $2);
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index c5856d9..7c5f6ac 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -399,6 +399,8 @@ dtc_tests () {
     tree1_tests dtc_tree1_merge.test.dtb test_tree1.dtb
     run_dtc_test -I dts -O dtb -o dtc_tree1_merge_labelled.test.dtb test_tree1_merge_labelled.dts
     tree1_tests dtc_tree1_merge_labelled.test.dtb test_tree1.dtb
+    run_dtc_test -I dts -O dtb -o dtc_tree1_label_noderef.test.dtb test_tree1_label_noderef.dts
+    tree1_tests dtc_tree1_label_noderef.test.dtb test_tree1.dtb
     run_dtc_test -I dts -O dtb -o multilabel_merge.test.dtb multilabel_merge.dts
     run_test references multilabel.test.dtb
     run_test dtbs_equal_ordered multilabel.test.dtb multilabel_merge.test.dtb
diff --git a/tests/test_tree1_label_noderef.dts b/tests/test_tree1_label_noderef.dts
new file mode 100644
index 0000000..b2b194c
--- /dev/null
+++ b/tests/test_tree1_label_noderef.dts
@@ -0,0 +1,55 @@
+/dts-v1/;
+
+/memreserve/ 0xdeadbeef00000000 0x100000;
+/memreserve/ 123456789 010000;
+
+/ {
+	compatible = "test_tree1";
+	prop-int = <0xdeadbeef>;
+	prop-int64 = /bits/ 64 <0xdeadbeef01abcdef>;
+	prop-str = "hello world";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	subnode@1 {
+		compatible = "subnode1";
+		reg = <1>;
+		prop-int = [deadbeef];
+
+		subsubnode {
+			compatible = "subsubnode1", "subsubnode";
+			prop-int = <0xdeadbeef>;
+		};
+
+		ss1 {
+		};
+	};
+
+	subnode@2 {
+		reg = <2>;
+		linux,phandle = <0x2000>;
+		prop-int = <123456789>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ssn0: subsubnode@0 {
+			phandle = <0x2001>;
+			prop-int = <0xbad>;
+		};
+
+		ss2 {
+		};
+	};
+};
+
+/* Add label to a noderef */
+ssn1: &ssn0 {
+	reg = <0>;
+	prop-int = <123456789>;
+};
+
+/* Use the new label for merging */
+&ssn1 {
+	prop-int = <0726746425>;
+	compatible = "subsubnode2", "subsubnode";
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree-compiler" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
