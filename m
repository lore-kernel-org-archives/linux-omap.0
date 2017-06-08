From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] ARM: OMAP2+: Remove unused legacy code for DMA
Date: Thu, 8 Jun 2017 02:56:19 -0700
Message-ID: <20170608095618.GJ3730@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-8-tony@atomide.com>
 <10f65a24-0459-5df7-378d-84933b83c070@ti.com>
 <20170608082432.GF3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170608082432.GF3730@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170608 01:28]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170607 23:29]:
> > 
> > This will conflict with the changes introduced by the tusb6010 DMAengine
> > conversion:
> > https://patchwork.kernel.org/patch/9734219/
> 
> Oops forgot about that one. I'll take a look if it makes sense
> to leave the braces for now to avoid a merge conflict.
> 
> > with this patch I think the omap24xx_sdma_map and omap3xxx_sdma_map can
> > also be removed, but we need to keep the omap24xx_sdma_dt_map for now
> > till we have proper DT support for tusb.
> 
> OK good point, will check.

Here's this one updated.

Regards,

Tony

8< ------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 31 May 2017 15:51:35 -0700
Subject: [PATCH] ARM: OMAP2+: Remove unused legacy code for DMA

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Let's leave the dummy omap2_system_dma_init_dev() check
in place for now to avoid a pointless merge conflict with
tusb6010 dmaengine conversion as pointed out by Peter
Ujfalusi <peter.ujfalusi@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dma.c | 125 +---------------------------------------------
 1 file changed, 2 insertions(+), 123 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -204,108 +204,6 @@ static unsigned configure_dma_errata(void)
 	return errata;
 }
 
-static const struct dma_slave_map omap24xx_sdma_map[] = {
-	{ "omap-gpmc", "rxtx", SDMA_FILTER_PARAM(4) },
-	{ "omap-aes", "tx", SDMA_FILTER_PARAM(9) },
-	{ "omap-aes", "rx", SDMA_FILTER_PARAM(10) },
-	{ "omap-sham", "rx", SDMA_FILTER_PARAM(13) },
-	{ "omap2_mcspi.2", "tx0", SDMA_FILTER_PARAM(15) },
-	{ "omap2_mcspi.2", "rx0", SDMA_FILTER_PARAM(16) },
-	{ "omap-mcbsp.3", "tx", SDMA_FILTER_PARAM(17) },
-	{ "omap-mcbsp.3", "rx", SDMA_FILTER_PARAM(18) },
-	{ "omap-mcbsp.4", "tx", SDMA_FILTER_PARAM(19) },
-	{ "omap-mcbsp.4", "rx", SDMA_FILTER_PARAM(20) },
-	{ "omap-mcbsp.5", "tx", SDMA_FILTER_PARAM(21) },
-	{ "omap-mcbsp.5", "rx", SDMA_FILTER_PARAM(22) },
-	{ "omap2_mcspi.2", "tx1", SDMA_FILTER_PARAM(23) },
-	{ "omap2_mcspi.2", "rx1", SDMA_FILTER_PARAM(24) },
-	{ "omap_i2c.1", "tx", SDMA_FILTER_PARAM(27) },
-	{ "omap_i2c.1", "rx", SDMA_FILTER_PARAM(28) },
-	{ "omap_i2c.2", "tx", SDMA_FILTER_PARAM(29) },
-	{ "omap_i2c.2", "rx", SDMA_FILTER_PARAM(30) },
-	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(31) },
-	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(32) },
-	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(33) },
-	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(34) },
-	{ "omap2_mcspi.0", "tx0", SDMA_FILTER_PARAM(35) },
-	{ "omap2_mcspi.0", "rx0", SDMA_FILTER_PARAM(36) },
-	{ "omap2_mcspi.0", "tx1", SDMA_FILTER_PARAM(37) },
-	{ "omap2_mcspi.0", "rx1", SDMA_FILTER_PARAM(38) },
-	{ "omap2_mcspi.0", "tx2", SDMA_FILTER_PARAM(39) },
-	{ "omap2_mcspi.0", "rx2", SDMA_FILTER_PARAM(40) },
-	{ "omap2_mcspi.0", "tx3", SDMA_FILTER_PARAM(41) },
-	{ "omap2_mcspi.0", "rx3", SDMA_FILTER_PARAM(42) },
-	{ "omap2_mcspi.1", "tx0", SDMA_FILTER_PARAM(43) },
-	{ "omap2_mcspi.1", "rx0", SDMA_FILTER_PARAM(44) },
-	{ "omap2_mcspi.1", "tx1", SDMA_FILTER_PARAM(45) },
-	{ "omap2_mcspi.1", "rx1", SDMA_FILTER_PARAM(46) },
-	{ "omap_hsmmc.1", "tx", SDMA_FILTER_PARAM(47) },
-	{ "omap_hsmmc.1", "rx", SDMA_FILTER_PARAM(48) },
-	{ "omap_uart.0", "tx", SDMA_FILTER_PARAM(49) },
-	{ "omap_uart.0", "rx", SDMA_FILTER_PARAM(50) },
-	{ "omap_uart.1", "tx", SDMA_FILTER_PARAM(51) },
-	{ "omap_uart.1", "rx", SDMA_FILTER_PARAM(52) },
-	{ "omap_uart.2", "tx", SDMA_FILTER_PARAM(53) },
-	{ "omap_uart.2", "rx", SDMA_FILTER_PARAM(54) },
-	{ "omap_hsmmc.0", "tx", SDMA_FILTER_PARAM(61) },
-	{ "omap_hsmmc.0", "rx", SDMA_FILTER_PARAM(62) },
-};
-
-static const struct dma_slave_map omap3xxx_sdma_map[] = {
-	{ "omap-gpmc", "rxtx", SDMA_FILTER_PARAM(4) },
-	{ "omap2_mcspi.2", "tx0", SDMA_FILTER_PARAM(15) },
-	{ "omap2_mcspi.2", "rx0", SDMA_FILTER_PARAM(16) },
-	{ "omap-mcbsp.3", "tx", SDMA_FILTER_PARAM(17) },
-	{ "omap-mcbsp.3", "rx", SDMA_FILTER_PARAM(18) },
-	{ "omap-mcbsp.4", "tx", SDMA_FILTER_PARAM(19) },
-	{ "omap-mcbsp.4", "rx", SDMA_FILTER_PARAM(20) },
-	{ "omap-mcbsp.5", "tx", SDMA_FILTER_PARAM(21) },
-	{ "omap-mcbsp.5", "rx", SDMA_FILTER_PARAM(22) },
-	{ "omap2_mcspi.2", "tx1", SDMA_FILTER_PARAM(23) },
-	{ "omap2_mcspi.2", "rx1", SDMA_FILTER_PARAM(24) },
-	{ "omap_i2c.3", "tx", SDMA_FILTER_PARAM(25) },
-	{ "omap_i2c.3", "rx", SDMA_FILTER_PARAM(26) },
-	{ "omap_i2c.1", "tx", SDMA_FILTER_PARAM(27) },
-	{ "omap_i2c.1", "rx", SDMA_FILTER_PARAM(28) },
-	{ "omap_i2c.2", "tx", SDMA_FILTER_PARAM(29) },
-	{ "omap_i2c.2", "rx", SDMA_FILTER_PARAM(30) },
-	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(31) },
-	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(32) },
-	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(33) },
-	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(34) },
-	{ "omap2_mcspi.0", "tx0", SDMA_FILTER_PARAM(35) },
-	{ "omap2_mcspi.0", "rx0", SDMA_FILTER_PARAM(36) },
-	{ "omap2_mcspi.0", "tx1", SDMA_FILTER_PARAM(37) },
-	{ "omap2_mcspi.0", "rx1", SDMA_FILTER_PARAM(38) },
-	{ "omap2_mcspi.0", "tx2", SDMA_FILTER_PARAM(39) },
-	{ "omap2_mcspi.0", "rx2", SDMA_FILTER_PARAM(40) },
-	{ "omap2_mcspi.0", "tx3", SDMA_FILTER_PARAM(41) },
-	{ "omap2_mcspi.0", "rx3", SDMA_FILTER_PARAM(42) },
-	{ "omap2_mcspi.1", "tx0", SDMA_FILTER_PARAM(43) },
-	{ "omap2_mcspi.1", "rx0", SDMA_FILTER_PARAM(44) },
-	{ "omap2_mcspi.1", "tx1", SDMA_FILTER_PARAM(45) },
-	{ "omap2_mcspi.1", "rx1", SDMA_FILTER_PARAM(46) },
-	{ "omap_hsmmc.1", "tx", SDMA_FILTER_PARAM(47) },
-	{ "omap_hsmmc.1", "rx", SDMA_FILTER_PARAM(48) },
-	{ "omap_uart.0", "tx", SDMA_FILTER_PARAM(49) },
-	{ "omap_uart.0", "rx", SDMA_FILTER_PARAM(50) },
-	{ "omap_uart.1", "tx", SDMA_FILTER_PARAM(51) },
-	{ "omap_uart.1", "rx", SDMA_FILTER_PARAM(52) },
-	{ "omap_uart.2", "tx", SDMA_FILTER_PARAM(53) },
-	{ "omap_uart.2", "rx", SDMA_FILTER_PARAM(54) },
-	{ "omap_hsmmc.0", "tx", SDMA_FILTER_PARAM(61) },
-	{ "omap_hsmmc.0", "rx", SDMA_FILTER_PARAM(62) },
-	{ "omap-aes", "tx", SDMA_FILTER_PARAM(65) },
-	{ "omap-aes", "rx", SDMA_FILTER_PARAM(66) },
-	{ "omap-sham", "rx", SDMA_FILTER_PARAM(69) },
-	{ "omap2_mcspi.3", "tx0", SDMA_FILTER_PARAM(70) },
-	{ "omap2_mcspi.3", "rx0", SDMA_FILTER_PARAM(71) },
-	{ "omap_hsmmc.2", "tx", SDMA_FILTER_PARAM(77) },
-	{ "omap_hsmmc.2", "rx", SDMA_FILTER_PARAM(78) },
-	{ "omap_uart.3", "tx", SDMA_FILTER_PARAM(81) },
-	{ "omap_uart.3", "rx", SDMA_FILTER_PARAM(82) },
-};
-
 static struct omap_system_dma_plat_info dma_plat_info __initdata = {
 	.reg_map	= reg_map,
 	.channel_stride	= 0x60,
@@ -334,14 +232,9 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	p.dma_attr = (struct omap_dma_dev_attr *)oh->dev_attr;
 	p.errata = configure_dma_errata();
 
+	/* REVISIT: Remove after v4.13 with a follow-up patch */
 	if (!of_have_populated_dt()) {
 		if (soc_is_omap24xx()) {
-			p.slave_map = omap24xx_sdma_map;
-			p.slavecnt = ARRAY_SIZE(omap24xx_sdma_map);
-		} else if (soc_is_omap34xx() || soc_is_omap3630()) {
-			p.slave_map = omap3xxx_sdma_map;
-			p.slavecnt = ARRAY_SIZE(omap3xxx_sdma_map);
-		} else {
 			pr_err("%s: The legacy DMA map is not provided!\n",
 			       __func__);
 			return -ENODEV;
@@ -389,21 +282,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 static int __init omap2_system_dma_init(void)
 {
-	struct platform_device *pdev;
-	int res;
-
-	res = omap_hwmod_for_each_by_class("dma",
+	return omap_hwmod_for_each_by_class("dma",
 			omap2_system_dma_init_dev, NULL);
-	if (res)
-		return res;
-
-	if (of_have_populated_dt())
-		return res;
-
-	pdev = platform_device_register_full(&omap_dma_dev_info);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	return res;
 }
 omap_arch_initcall(omap2_system_dma_init);
-- 
2.13.0
