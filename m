From: Nikhil Devshatwar <nikhil.nd@ti.com>
Subject: [PATCH] dtc: parser: Add label while overriding nodes
Date: Wed, 28 Jan 2015 20:20:11 +0530
Message-ID: <1422456611-15447-1-git-send-email-nikhil.nd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48363 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909AbbA1Ubs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2015 15:31:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david@gibson.dropbear.id.au, jdl@jdl.com
Cc: devicetree-compiler@vger.kernel.org, linux-omap@vger.kernel.org, Nikhil Devshatwar <nikhil.nd@ti.com>

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

Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
---
 dtc-parser.y |   12 ++++++++++++
 1 file changed, 12 insertions(+)

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
-- 
1.7.9.5

