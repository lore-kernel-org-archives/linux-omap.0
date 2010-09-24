From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/11] omap: crypto: updates to enable omap aes
Date: Thu, 23 Sep 2010 18:51:02 -0700
Message-ID: <20100924015102.10325.51712.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49887 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0IXBvC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:51:02 -0400
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, linux-omap@vger.kernel.org

From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

Updates to enable omap aes

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
[tony@atomide.com: updated to use CONFIG_ARCH_OMAP2/3 instead of old 24XX/34XX]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    2 -
 arch/arm/mach-omap2/clock2430_data.c |    2 -
 arch/arm/mach-omap2/clock3xxx_data.c |    2 -
 arch/arm/mach-omap2/devices.c        |   71 ++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 37d65d6..5f2066a 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1838,7 +1838,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
 	CLK("omap-sham",	"ick",	&sha_ick,	CK_242X),
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),
-	CLK(NULL,	"aes_ick",	&aes_ick,	CK_242X),
+	CLK("omap-aes",	"ick",	&aes_ick,	CK_242X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb_hdrc",	"fck",	&osc_ck,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index b33118f..701a171 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1926,7 +1926,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"des_ick",	&des_ick,	CK_243X),
 	CLK("omap-sham",	"ick",	&sha_ick,	CK_243X),
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X),
-	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X),
+	CLK("omap-aes",	"ick",	&aes_ick,	CK_243X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X),
 	CLK("musb_hdrc",	"ick",	&usbhs_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index dfdce2d..c73906d 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3288,7 +3288,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2 | CK_AM35XX),
 	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
-	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_343X),
+	CLK("omap-aes",	"ick",	&aes2_ick,	CK_343X),
 	CLK("omap-sham",	"ick",	&sha12_ick,	CK_343X),
 	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
 	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..dc49c07 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -498,6 +498,76 @@ static void omap_init_sham(void)
 static inline void omap_init_sham(void) { }
 #endif
 
+#if defined(CONFIG_CRYPTO_DEV_OMAP_AES) || defined(CONFIG_CRYPTO_DEV_OMAP_AES_MODULE)
+
+#ifdef CONFIG_ARCH_OMAP2
+static struct resource omap2_aes_resources[] = {
+	{
+		.start	= OMAP24XX_SEC_AES_BASE,
+		.end	= OMAP24XX_SEC_AES_BASE + 0x4C,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP24XX_DMA_AES_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.start	= OMAP24XX_DMA_AES_RX,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+static int omap2_aes_resources_sz = ARRAY_SIZE(omap2_aes_resources);
+#else
+#define omap2_aes_resources		NULL
+#define omap2_aes_resources_sz		0
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static struct resource omap3_aes_resources[] = {
+	{
+		.start	= OMAP34XX_SEC_AES_BASE,
+		.end	= OMAP34XX_SEC_AES_BASE + 0x4C,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP34XX_DMA_AES2_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.start	= OMAP34XX_DMA_AES2_RX,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+static int omap3_aes_resources_sz = ARRAY_SIZE(omap3_aes_resources);
+#else
+#define omap3_aes_resources		NULL
+#define omap3_aes_resources_sz		0
+#endif
+
+static struct platform_device aes_device = {
+	.name		= "omap-aes",
+	.id		= -1,
+};
+
+static void omap_init_aes(void)
+{
+	if (cpu_is_omap24xx()) {
+		aes_device.resource = omap2_aes_resources;
+		aes_device.num_resources = omap2_aes_resources_sz;
+	} else if (cpu_is_omap34xx()) {
+		aes_device.resource = omap3_aes_resources;
+		aes_device.num_resources = omap3_aes_resources_sz;
+	} else {
+		pr_err("%s: platform not supported\n", __func__);
+		return;
+	}
+	platform_device_register(&aes_device);
+}
+
+#else
+static inline void omap_init_aes(void) { }
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
@@ -854,6 +924,7 @@ static int __init omap2_init_devices(void)
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sham();
+	omap_init_aes();
 	omap_init_vout();
 
 	return 0;

