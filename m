From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 4/5] arm:omap1/2/3/4: Add platform hookup code for counter-32k driver
Date: Wed, 18 Jan 2012 16:58:05 +0530
Message-ID: <1326886086-27313-5-git-send-email-hvaibhav@ti.com>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50694 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228Ab2ARL2j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 06:28:39 -0500
In-Reply-To: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: johnstul@us.ibm.com, tglx@linutronix.de, balbi@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, b-cousson@ti.com, khilman@ti.com, paul@pwsan.com, Vaibhav Hiremath <hvaibhav@ti.com>

omap 32k counter/timer driver has been migrated to the
standard platform_driver, so platform hookup is required
to bind the driver,
   - omap1: Register platform_device for cpu_is_omap16xx()
   - omap2/3/4: Use hwmod database lookup mechanism to build the
     platform_device

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/devices.c |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c |   25 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 1d76a63..c7e99b3 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -34,6 +34,29 @@

 /*-------------------------------------------------------------------------*/

+#define OMAP16XX_TIMER_32K_BASE                0xfffbc400
+
+static struct resource omap_32k_resources[] = {
+	{
+		.start		= OMAP16XX_TIMER_32K_BASE,
+		.end		= SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_32k_device = {
+	.name			= "omap-counter-32k",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(omap_32k_resources),
+	.resource		= omap_32k_resources,
+};
+
+static void omap_init_32k(void)
+{
+	if (cpu_is_omap16xx())
+		(void) platform_device_register(&omap_32k_device);
+};
+
 #if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)

 #define	OMAP_RTC_BASE		0xfffb4800
@@ -301,6 +324,7 @@ static int __init omap1_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */

+	omap_init_32k();
 	omap_init_mbox();
 	omap_init_rtc();
 	omap_init_spi100k();
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 35d5dff..fee14d6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -105,6 +105,30 @@ static int __init omap4_l3_init(void)
 }
 postcore_initcall(omap4_l3_init);

+static int __init omap_init_32k(void)
+{
+	int id = -1;
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	const char *oh_name = "counter_32k";
+	const char *dev_name = "omap-counter-32k";
+
+	if (!cpu_class_is_omap2())
+		return -ENODEV;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not lookup %s hwmod\n", oh_name);
+		return -ENODEV;
+	}
+
+	od = omap_device_build(dev_name, id, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(od), "Can't build omap device for %s:%s.\n",
+			dev_name, oh->name);
+
+	return 0;
+};
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)

 static struct resource omap2cam_resources[] = {
@@ -700,6 +724,7 @@ static int __init omap2_init_devices(void)
 	 * please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_init_32k();
 	omap_init_audio();
 	omap_init_mcpdm();
 	omap_init_dmic();
--
1.7.0.4

