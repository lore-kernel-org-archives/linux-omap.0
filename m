From: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] dtc: parser: Add label while overriding nodes
Date: Thu, 8 Jan 2015 19:42:42 +0530
Message-ID: <1420726362-22555-1-git-send-email-nikhil.nd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Current device tree compiler allows to define multiple labels when defining
the device node the first time. Typically device nodes are defined in
DTSI files. Now these nodes can be overriden for updating some of the
properties. Typically, device nodes are overridden in DTS files.

When working with adapter boards, most of the time adapter board can fit to
multiple base boards. But depending on which base board it is connected to,
the devices on the adapter board would be children of different devices.

e.g. On dra7-evm.dts, i2c2 is exported for expansion connector whereas
on dra72-evm.dts, i2c5 is exported for expansion connector.
This causes a problem when writing a generic device tree file for
the adapter board. Because, you cannot know wheather all the devices on
adpter board are present on i2c or i2c5.

The problem can be solved by adding a common label (e.g. i2cexp) in both
of the DTS files when overriding the device nodes for i2c2 or i2c5.
This way, generic adapter board file would override the i2cexp. And
depending on which base board you use the adpter board, all the devices
are automatically added for correct device nodes.

Change-Id: I3ad7247a79baed7268a91fc691360aece73d6d1b
Signed-off-by: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
---
 scripts/dtc/dtc-parser.y |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index f412460..d9ed3b7 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -145,6 +145,18 @@ devicetree:
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
+				print_error("label or path, '%s', not found", $2);
+			$$ = $1;
+		}
 	| devicetree DT_REF nodedef
 		{
 			struct node *target = get_node_by_ref($1, $2);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree-spec" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
