From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 1/2] ARM: OMAP2+: only search for GPMC DT child nodes on probe
Date: Wed, 17 Apr 2013 22:34:11 +0200
Message-ID: <1366230852-2440-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:37952 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965493Ab3DQUed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 16:34:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Lars Poeschel <poeschel@lemonage.de>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The GPMC DT probe function use for_each_node_by_name() to search
child device nodes of the GPMC controller. But this function does
not use the GPMC device node as the root of the search and instead
search across the complete Device Tree.

This means that any device node on the DT that is using any of the
GPMC child nodes names searched for will be returned even if they
are not connected to the GPMC, making the gpmc_probe_xxx_child()
function to fail.

Fix this by using the GPMC device node as the search root so the
search will be restricted to its children.

Reported-by: Lars Poeschel <poeschel@lemonage.de>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1 (suggested by Jon Hunter):
  - Split the search for GPMC child nodes and only warn if a
    child probe fails on two different patches
  - Don't probe all childs unnecesary if a previous matched

 arch/arm/mach-omap2/gpmc.c |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ed946df..6166847 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1520,32 +1520,19 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		return ret;
 	}
 
-	for_each_node_by_name(child, "nand") {
-		ret = gpmc_probe_nand_child(pdev, child);
-		if (ret < 0) {
-			of_node_put(child);
-			return ret;
-		}
-	}
+	for_each_child_of_node(pdev->dev.of_node, child) {
 
-	for_each_node_by_name(child, "onenand") {
-		ret = gpmc_probe_onenand_child(pdev, child);
-		if (ret < 0) {
-			of_node_put(child);
-			return ret;
-		}
-	}
+		if (!child->name)
+			continue;
 
-	for_each_node_by_name(child, "nor") {
-		ret = gpmc_probe_generic_child(pdev, child);
-		if (ret < 0) {
-			of_node_put(child);
-			return ret;
-		}
-	}
+		if (of_node_cmp(child->name, "nand") == 0)
+			ret = gpmc_probe_nand_child(pdev, child);
+		else if (of_node_cmp(child->name, "onenand") == 0)
+			ret = gpmc_probe_onenand_child(pdev, child);
+		else if (of_node_cmp(child->name, "ethernet") == 0 ||
+			 of_node_cmp(child->name, "nor") == 0)
+			ret = gpmc_probe_generic_child(pdev, child);
 
-	for_each_node_by_name(child, "ethernet") {
-		ret = gpmc_probe_generic_child(pdev, child);
 		if (ret < 0) {
 			of_node_put(child);
 			return ret;
-- 
1.7.7.6

