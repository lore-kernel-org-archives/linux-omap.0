From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] ASoC: omap-mcpdm: Add device tree bindings
Date: Fri,  2 Dec 2011 11:52:57 +0200
Message-ID: <1322819580-7424-3-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36303 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218Ab1LBJxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 04:53:20 -0500
Received: by mail-ww0-f51.google.com with SMTP id dr1so528035wgb.20
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 01:53:19 -0800 (PST)
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/soc/omap/omap-mcpdm.txt         |   13 +++++++++++++
 sound/soc/omap/omap-mcpdm.c                        |    8 ++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt

diff --git a/Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt
new file mode 100644
index 0000000..e94bb96
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt
@@ -0,0 +1,13 @@
+* Texas Instruments OMAP4 McPDM
+
+Required properties:
+  - compatible : "ti,omap4-mcpdm"
+  - ti,hwmods  : List of hwmod names associated with McPDM, in most case
+                 it is "mcpdm".
+
+Example:
+
+mcpdm_dai: mcpdm@40132000 {
+	compatible = "ti,omap4-mcpdm";
+	ti,hwmods = "mcpdm";
+};
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index b50ac60..c95fc70 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -510,10 +511,17 @@ static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id omap_mcpdm_of_match[] = {
+	{ .compatible = "ti,omap4-mcpdm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, omap_mcpdm_of_match);
+
 static struct platform_driver asoc_mcpdm_driver = {
 	.driver = {
 		.name	= "omap-mcpdm",
 		.owner	= THIS_MODULE,
+		.of_match_table = omap_mcpdm_of_match,
 	},
 
 	.probe	= asoc_mcpdm_probe,
-- 
1.7.8.rc4

