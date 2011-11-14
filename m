From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 2/3] ARM: omap4: Add omap4 pinmux devices for core and wkup
Date: Mon, 14 Nov 2011 18:10:08 +0530
Message-ID: <1321274409-24643-3-git-send-email-rnayak@ti.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43179 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab1KNMk0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 07:40:26 -0500
In-Reply-To: <1321274409-24643-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@stericsson.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Add omap4 pinmux platform devices for core-pinmux and wkup-pinmux.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/devices.c |   43 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c15cfad..bd9fff6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -671,6 +671,48 @@ static void omap_init_vout(void)
 static inline void omap_init_vout(void) {}
 #endif
 
+static struct resource pinmux_core_resources[] = {
+	{
+		.start = 0x4a100040,
+		.end   = 0x4a100040 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct resource pinmux_wkup_resources[] = {
+	{
+		.start = 0x4a31e040,
+		.end   = 0x4a31e040 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap4_pinmux_core_device = {
+	.name = "pinmux-omap",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(pinmux_core_resources),
+	.resource = pinmux_core_resources,
+};
+
+static struct platform_device omap4_pinmux_wkup_device = {
+	.name = "pinmux-omap",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(pinmux_wkup_resources),
+	.resource = pinmux_wkup_resources,
+};
+
+static struct platform_device *omap4_pinmux_devices[] = {
+	&omap4_pinmux_core_device,
+	&omap4_pinmux_wkup_device,
+};
+
+static inline void omap_init_pinmux(void)
+{
+	if (cpu_is_omap44xx())
+		platform_add_devices(omap4_pinmux_devices,
+					ARRAY_SIZE(omap4_pinmux_devices));
+}
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -690,6 +732,7 @@ static int __init omap2_init_devices(void)
 	omap_init_sham();
 	omap_init_aes();
 	omap_init_vout();
+	omap_init_pinmux();
 
 	return 0;
 }
-- 
1.7.1

