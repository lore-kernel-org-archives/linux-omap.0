From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 01/15] scripts/dtc: fix most memory leaks in dtc
Date: Tue, 24 Sep 2013 18:52:07 +0200
Message-ID: <1380041541-17529-2-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:39259 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311Ab3IXQws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:52:48 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so4915932wes.15
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:52:46 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

There are a few memory leaks in dtc which until now were not that important
since they were all in the parser and only one instance of the parser was run
per instance of dtc. The following commits will add a validation of dts through
schema which have the same syntax as dts, i.e. the parser of dts will be reused
to parse schema. The consequence is that instead of having the parser running
only one time for an instance of the dtc process, the parser will run
many many times and thus the leak that were not important until now becomes
urgent to fix.

dtc-lexer: Do not duplicate the string which contains literals because the
string is directly converted afterward to an integer and is never used again.
livetree: Add a bunch of free helper functions to clean properly the dt.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 scripts/dtc/dtc-lexer.l             |   2 +-
 scripts/dtc/dtc-lexer.lex.c_shipped |   2 +-
 scripts/dtc/dtc.c                   |   1 +
 scripts/dtc/dtc.h                   |   1 +
 scripts/dtc/livetree.c              | 108 +++++++++++++++++++++++++++++++++---
 5 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index 3b41bfc..4f63fbf 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -146,7 +146,7 @@ static int pop_input_file(void);
 		}
 
 <V1>([0-9]+|0[xX][0-9a-fA-F]+)(U|L|UL|LL|ULL)? {
-			yylval.literal = xstrdup(yytext);
+			yylval.literal = yytext;
 			DPRINT("Literal: '%s'\n", yylval.literal);
 			return DT_LITERAL;
 		}
diff --git a/scripts/dtc/dtc-lexer.lex.c_shipped b/scripts/dtc/dtc-lexer.lex.c_shipped
index 2d30f41..5c0d27c 100644
--- a/scripts/dtc/dtc-lexer.lex.c_shipped
+++ b/scripts/dtc/dtc-lexer.lex.c_shipped
@@ -1054,7 +1054,7 @@ case 10:
 YY_RULE_SETUP
 #line 148 "dtc-lexer.l"
 {
-			yylval.literal = xstrdup(yytext);
+			yylval.literal = yytext;
 			DPRINT("Literal: '%s'\n", yylval.literal);
 			return DT_LITERAL;
 		}
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index a375683..215ae92 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -256,5 +256,6 @@ int main(int argc, char *argv[])
 		die("Unknown output format \"%s\"\n", outform);
 	}
 
+	free_dt(bi);
 	exit(0);
 }
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 3e42a07..9c45fd2 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -245,6 +245,7 @@ struct boot_info {
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
 				  struct node *tree, uint32_t boot_cpuid_phys);
 void sort_tree(struct boot_info *bi);
+void free_dt(struct boot_info *bi);
 
 /* Checks */
 
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index b61465f..5c8692c 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -20,6 +20,10 @@
 
 #include "dtc.h"
 
+static void free_node_list(struct node *n);
+static void free_node(struct node *n);
+static void free_property(struct property *p);
+
 /*
  * Tree building functions
  */
@@ -144,7 +148,7 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 
 	/* Add new node labels to old node */
 	for_each_label_withdel(new_node->labels, l)
-		add_label(&old_node->labels, l->label);
+		add_label(&old_node->labels, xstrdup(l->label));
 
 	/* Move properties from the new node to the old node.  If there
 	 * is a collision, replace the old value with the new */
@@ -156,7 +160,7 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 
 		if (new_prop->deleted) {
 			delete_property_by_name(old_node, new_prop->name);
-			free(new_prop);
+			free_property(new_prop);
 			continue;
 		}
 
@@ -165,7 +169,7 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 			if (streq(old_prop->name, new_prop->name)) {
 				/* Add new labels to old property */
 				for_each_label_withdel(new_prop->labels, l)
-					add_label(&old_prop->labels, l->label);
+					add_label(&old_prop->labels, xstrdup(l->label));
 
 				old_prop->val = new_prop->val;
 				old_prop->deleted = 0;
@@ -191,7 +195,7 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 
 		if (new_child->deleted) {
 			delete_node_by_name(old_node, new_child->name);
-			free(new_child);
+			free_node(new_child);
 			continue;
 		}
 
@@ -211,7 +215,7 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 
 	/* The new node contents are now merged into the old node.  Free
 	 * the new node. */
-	free(new_node);
+	free_node(new_node);
 
 	return old_node;
 }
@@ -532,13 +536,13 @@ cell_t get_node_phandle(struct node *root, struct node *node)
 	if (!get_property(node, "linux,phandle")
 	    && (phandle_format & PHANDLE_LEGACY))
 		add_property(node,
-			     build_property("linux,phandle",
+			     build_property(xstrdup("linux,phandle"),
 					    data_append_cell(empty_data, phandle)));
 
 	if (!get_property(node, "phandle")
 	    && (phandle_format & PHANDLE_EPAPR))
 		add_property(node,
-			     build_property("phandle",
+			     build_property(xstrdup("phandle"),
 					    data_append_cell(empty_data, phandle)));
 
 	/* If the node *does* have a phandle property, we must
@@ -707,3 +711,93 @@ void sort_tree(struct boot_info *bi)
 	sort_reserve_entries(bi);
 	sort_node(bi->dt);
 }
+
+static void free_marker_list(struct marker *m)
+{
+	struct marker *marker, *marker_next;
+
+	if (!m)
+		return;
+
+	for (marker = m, marker_next = marker ? marker->next : NULL;
+	     marker;
+	     marker = marker_next, marker_next = marker ? marker->next : NULL) {
+		free(marker->ref);
+		free(marker);
+	}
+}
+
+static void free_label_list(struct label *l)
+{
+	struct label *label, *label_next;
+
+	if (!l)
+		return;
+
+	for (label = l, label_next = label ? label->next : NULL;
+	     label;
+	     label = label_next, label_next = label ? label->next : NULL) {
+		free(label->label);
+		free(label);
+	}
+}
+
+static void free_property(struct property *p)
+{
+	if (!p)
+		return;
+
+	free_label_list(p->labels);
+	free_marker_list(p->val.markers);
+	free(p->val.val);
+	free(p->name);
+	free(p);
+}
+
+static void free_property_list(struct property *p)
+{
+	struct property *next;
+
+	if (!p)
+		return;
+
+	for (next = p->next; p; p = next, next = p ? p->next : NULL)
+		free_property(p);
+}
+
+static void free_node(struct node *n)
+{
+	if (!n)
+		return;
+
+	free_node_list(n->children);
+	free_label_list(n->labels);
+	free_property_list(n->proplist);
+	free(n->fullpath);
+	if (n->name && *n->name)
+		free(n->name);
+	free(n);
+}
+
+static void free_node_list(struct node *n)
+{
+	struct node *next;
+
+	if (!n)
+		return;
+
+	for (next = n->next_sibling;
+	     n;
+	     n = next, next = n ? n->next_sibling : NULL) {
+		free_node(n);
+	}
+}
+
+void free_dt(struct boot_info *bi)
+{
+	if (!bi)
+		return;
+
+	free_node_list(bi->dt);
+	free(bi);
+}
-- 
1.8.1.2

