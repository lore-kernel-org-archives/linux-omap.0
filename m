From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/18] OMAP2/3: Add V4L2 DSS driver support in device.c
Date: Wed, 05 May 2010 12:32:32 -0700
Message-ID: <20100505193232.21568.81543.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65357 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143Ab0EETch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:32:37 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2271b9b..10f3a3c 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -786,6 +786,33 @@ static inline void omap_hdq_init(void)
 static inline void omap_hdq_init(void) {}
 #endif
 
+/*---------------------------------------------------------------------------*/
+
+#if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
+	defined(CONFIG_VIDEO_OMAP2_VOUT_MODULE)
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+static struct resource omap_vout_resource[3 - CONFIG_FB_OMAP2_NUM_FBS] = {
+};
+#else
+static struct resource omap_vout_resource[2] = {
+};
+#endif
+
+static struct platform_device omap_vout_device = {
+	.name		= "omap_vout",
+	.num_resources	= ARRAY_SIZE(omap_vout_resource),
+	.resource 	= &omap_vout_resource[0],
+	.id		= -1,
+};
+static void omap_init_vout(void)
+{
+	if (platform_device_register(&omap_vout_device) < 0)
+		printk(KERN_ERR "Unable to register OMAP-VOUT device\n");
+}
+#else
+static inline void omap_init_vout(void) {}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -800,6 +827,7 @@ static int __init omap2_init_devices(void)
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sha1_md5();
+	omap_init_vout();
 
 	return 0;
 }

