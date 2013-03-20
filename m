From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Remove dmm device creation
Date: Tue, 19 Mar 2013 23:43:44 -0500
Message-ID: <1363754624-5209-3-git-send-email-andy.gross@ti.com>
References: <1363754624-5209-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46405 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329Ab3CTEoQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 00:44:16 -0400
In-Reply-To: <1363754624-5209-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <bicousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, devicetree-discuss@lists.ozlabs.org, Nishanth Menon <nm@ti.com>, Andy Gross <andy.gross@ti.com>

Remove DMM device creation via the hwmod entry.  The DMM device will
now be enumerated as part of the device tree information for the
processor.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/dmm.txt |   16 ++++++++++++++++
 arch/arm/mach-omap2/drm.c                          |   12 ------------
 2 files changed, 16 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Documentation/devicetree/bindings/arm/omap/dmm.txt
new file mode 100644
index 0000000..5fd1134
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
@@ -0,0 +1,16 @@
+OMAP Dynamic Memory Manager (DMM) bindings
+
+Required properties:
+- compatible:	Must be "ti,dmm" for OMAP processors containing DMM block
+- reg:		Contains timer register address range (base address and length)
+- interrupts:	Contains interrupt information (source, etc) for the DMM IRQ
+- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
+		"dmm"
+
+Example:
+
+dmm: dmm@4e000000 {
+	compatible = "ti,dmm";
+	reg = <0x4e000000 0x800>;
+	ti,hwmods = "dmm";
+};
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 59a4af7..1fd0487 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -44,18 +44,6 @@ static struct platform_device omap_drm_device = {
 
 static int __init omap_init_drm(void)
 {
-	struct omap_hwmod *oh = NULL;
-	struct platform_device *pdev;
-
-	/* lookup and populate the DMM information, if present - OMAP4+ */
-	oh = omap_hwmod_lookup("dmm");
-
-	if (oh) {
-		pdev = omap_device_build(oh->name, -1, oh, NULL, 0);
-		WARN(IS_ERR(pdev), "Could not build omap_device for %s\n",
-			oh->name);
-	}
-
 	platform_data.omaprev = GET_OMAP_TYPE;
 
 	return platform_device_register(&omap_drm_device);
-- 
1.7.5.4

