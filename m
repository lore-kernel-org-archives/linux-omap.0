From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 1/2] OMAP: mailbox: add device tree support
Date: Tue,  1 May 2012 12:47:39 -0500
Message-ID: <1335894460-19941-2-git-send-email-omar.luna@linaro.org>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

Adapt driver to use DT if provided.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 .../devicetree/bindings/arm/omap/mailbox.txt       |    9 +++++++++
 arch/arm/mach-omap2/devices.c                      |    3 +++
 arch/arm/mach-omap2/mailbox.c                      |   12 ++++++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/mailbox.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/mailbox.txt b/Documentation/devicetree/bindings/arm/omap/mailbox.txt
new file mode 100644
index 0000000..c57c0d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/mailbox.txt
@@ -0,0 +1,9 @@
+OMAP Mailbox module
+
+Required properties:
+ compatible : should be "ti,omap2-mailbox" for OMAP2 mailbox
+ compatible : should be "ti,omap3-mailbox" for OMAP3 mailbox
+ compatible : should be "ti,omap4-mailbox" for OMAP4 mailbox
+
+Optional properties:
+ None
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e433603..7a78063 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -281,6 +281,9 @@ static inline void __init omap_init_mbox(void)
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 
+	if (of_have_populated_dt())
+		return;
+
 	oh = omap_hwmod_lookup("mailbox");
 	if (!oh) {
 		pr_err("%s: unable to find hwmod\n", __func__);
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 415a6f1..7cf12ca 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
@@ -402,11 +403,22 @@ static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_mailbox_of_match[] = {
+	{ .compatible = "ti,omap2-mailbox" },
+	{ .compatible = "ti,omap3-mailbox" },
+	{ .compatible = "ti,omap4-mailbox" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_mailbox_of_match);
+#endif
+
 static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
 	.remove = __devexit_p(omap2_mbox_remove),
 	.driver = {
 		.name = "omap-mailbox",
+		.of_match_table = of_match_ptr(omap_mailbox_of_match),
 	},
 };
 
-- 
1.7.4.1

