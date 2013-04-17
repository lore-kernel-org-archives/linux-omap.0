From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH] ARM: OMAP2+: only search for GPMC DT child nodes on probe
Date: Wed, 17 Apr 2013 18:37:31 +0200
Message-ID: <1366216651-11164-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:37674 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3DQQhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 12:37:39 -0400
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

Also, if any of the GPMC child nodes fails, this shouldn't make
the whole gpmc_probe_dt() function to fail. It is better to just
WARN and allow other devices probe function to succeed.

Reported-by: Lars Poeschel <poeschel@lemonage.de>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc.c |   41 +++++++++++++++++------------------------
 1 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ed946df..f10d735 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1520,35 +1520,28 @@ static int gpmc_probe_dt(struct platform_device *pdev)
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
+
+		if (!child->name)
+			continue;
 
-	for_each_node_by_name(child, "onenand") {
-		ret = gpmc_probe_onenand_child(pdev, child);
-		if (ret < 0) {
-			of_node_put(child);
-			return ret;
+		if (of_node_cmp(child->name, "nand") == 0) {
+			ret = gpmc_probe_nand_child(pdev, child);
+			if (WARN_ON(ret < 0))
+				of_node_put(child);
 		}
-	}
 
-	for_each_node_by_name(child, "nor") {
-		ret = gpmc_probe_generic_child(pdev, child);
-		if (ret < 0) {
-			of_node_put(child);
-			return ret;
+		if (of_node_cmp(child->name, "onenand") == 0) {
+			ret = gpmc_probe_onenand_child(pdev, child);
+			if (WARN_ON(ret < 0))
+				of_node_put(child);
 		}
-	}
 
-	for_each_node_by_name(child, "ethernet") {
-		ret = gpmc_probe_generic_child(pdev, child);
-		if (ret < 0) {
-			of_node_put(child);
-			return ret;
+		if (of_node_cmp(child->name, "ethernet") == 0 ||
+		    of_node_cmp(child->name, "nor") == 0) {
+			ret = gpmc_probe_generic_child(pdev, child);
+			if (WARN_ON(ret < 0))
+				of_node_put(child);
 		}
 	}
 
-- 
1.7.7.6

