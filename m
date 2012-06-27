From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod
 support
Date: Wed, 27 Jun 2012 15:19:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271518480.27496@utopia.booyaka.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com> <1337105642-22711-2-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35335 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab2F0VTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 17:19:47 -0400
In-Reply-To: <1337105642-22711-2-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

On Tue, 15 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Add hwmod support for the EMAC (and MDIO)
> ethernet controller that's on the am35x
> family of SoC's.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

I had to update this patch to apply on v3.5-rc4; updated patch below.


- Paul

From: "Mark A. Greer" <mgreer@animalcreek.com>
Date: Wed, 27 Jun 2012 14:59:57 -0600
Subject: [PATCH 1/2] ARM: OMAP AM35x: EMAC/MDIO integration: Add Davinci
 EMAC/MDIO hwmod support

Add hwmod support for the EMAC (and MDIO)
ethernet controller that's on the am35x
family of SoC's.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
[paul@pwsan.com: updated subject line; updated to apply on v3.5-rc4]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/am35xx-emac.c          |   90 ++++++++++++++--------------
 arch/arm/mach-omap2/clock3xxx_data.c       |    2 +-
 arch/arm/mach-omap2/include/mach/am35xx.h  |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   85 ++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 447682c..2c90ac6 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -15,27 +15,13 @@
  * General Public License for more details.
  */
 
-#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/davinci_emac.h>
-#include <linux/platform_device.h>
-#include <plat/irqs.h>
+#include <asm/system.h>
+#include <plat/omap_device.h>
 #include <mach/am35xx.h>
-
 #include "control.h"
-
-static struct mdio_platform_data am35xx_emac_mdio_pdata;
-
-static struct resource am35xx_emac_mdio_resources[] = {
-	DEFINE_RES_MEM(AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET, SZ_4K),
-};
-
-static struct platform_device am35xx_emac_mdio_device = {
-	.name		= "davinci_mdio",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(am35xx_emac_mdio_resources),
-	.resource	= am35xx_emac_mdio_resources,
-	.dev.platform_data = &am35xx_emac_mdio_pdata,
-};
+#include "am35xx-emac.h"
 
 static void am35xx_enable_emac_int(void)
 {
@@ -69,41 +55,57 @@ static struct emac_platform_data am35xx_emac_pdata = {
 	.interrupt_disable	= am35xx_disable_emac_int,
 };
 
-static struct resource am35xx_emac_resources[] = {
-	DEFINE_RES_MEM(AM35XX_IPSS_EMAC_BASE, 0x30000),
-	DEFINE_RES_IRQ(INT_35XX_EMAC_C0_RXTHRESH_IRQ),
-	DEFINE_RES_IRQ(INT_35XX_EMAC_C0_RX_PULSE_IRQ),
-	DEFINE_RES_IRQ(INT_35XX_EMAC_C0_TX_PULSE_IRQ),
-	DEFINE_RES_IRQ(INT_35XX_EMAC_C0_MISC_PULSE_IRQ),
-};
+static struct mdio_platform_data am35xx_mdio_pdata;
 
-static struct platform_device am35xx_emac_device = {
-	.name		= "davinci_emac",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(am35xx_emac_resources),
-	.resource	= am35xx_emac_resources,
-	.dev		= {
-		.platform_data	= &am35xx_emac_pdata,
-	},
-};
+static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
+		void *pdata, int pdata_len)
+{
+	struct platform_device *pdev;
+
+	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len,
+				 NULL, 0, false);
+	if (IS_ERR(pdev)) {
+		WARN(1, "Can't build omap_device for %s:%s.\n",
+		     oh->class->name, oh->name);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
 
 void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 {
+	struct omap_hwmod *oh;
 	u32 v;
-	int err;
+	int ret;
 
-	am35xx_emac_pdata.rmii_en = rmii_en;
-	am35xx_emac_mdio_pdata.bus_freq = mdio_bus_freq;
-	err = platform_device_register(&am35xx_emac_device);
-	if (err) {
-		pr_err("AM35x: failed registering EMAC device: %d\n", err);
+	oh = omap_hwmod_lookup("davinci_mdio");
+	if (!oh) {
+		pr_err("Could not find davinci_mdio hwmod\n");
+		return;
+	}
+
+	am35xx_mdio_pdata.bus_freq = mdio_bus_freq;
+
+	ret = omap_davinci_emac_dev_init(oh, &am35xx_mdio_pdata,
+					 sizeof(am35xx_mdio_pdata));
+	if (ret) {
+		pr_err("Could not build davinci_mdio hwmod device\n");
 		return;
 	}
 
-	err = platform_device_register(&am35xx_emac_mdio_device);
-	if (err) {
-		pr_err("AM35x: failed registering EMAC MDIO device: %d\n", err);
-		platform_device_unregister(&am35xx_emac_device);
+	oh = omap_hwmod_lookup("davinci_emac");
+	if (!oh) {
+		pr_err("Could not find davinci_emac hwmod\n");
+		return;
+	}
+
+	am35xx_emac_pdata.rmii_en = rmii_en;
+
+	ret = omap_davinci_emac_dev_init(oh, &am35xx_emac_pdata,
+					 sizeof(am35xx_emac_pdata));
+	if (ret) {
+		pr_err("Could not build davinci_emac hwmod device\n");
 		return;
 	}
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1efdec2..10c1395 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3474,7 +3474,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
 	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
-	CLK("davinci_emac",	NULL,	&emac_ick,	CK_AM35XX),
+	CLK("davinci_emac.0",	NULL,	&emac_ick,	CK_AM35XX),
 	CLK("davinci_mdio.0",	NULL,	&emac_fck,	CK_AM35XX),
 	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
 	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/include/mach/am35xx.h
index f1e13d1..9559449 100644
--- a/arch/arm/mach-omap2/include/mach/am35xx.h
+++ b/arch/arm/mach-omap2/include/mach/am35xx.h
@@ -36,6 +36,8 @@
 #define AM35XX_EMAC_CNTRL_MOD_OFFSET	(0x0)
 #define AM35XX_EMAC_CNTRL_RAM_OFFSET	(0x20000)
 #define AM35XX_EMAC_MDIO_OFFSET		(0x30000)
+#define AM35XX_IPSS_MDIO_BASE		(AM35XX_IPSS_EMAC_BASE + \
+						AM35XX_EMAC_MDIO_OFFSET)
 #define AM35XX_EMAC_CNTRL_RAM_SIZE	(0x2000)
 #define AM35XX_EMAC_RAM_ADDR		(AM3517_EMAC_BASE + \
 						AM3517_EMAC_CNTRL_RAM_OFFSET)
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b26d3c9..f33e8d5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3138,6 +3138,87 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__counter_32k = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* am35xx has Davinci MDIO & EMAC */
+static struct omap_hwmod_class am35xx_mdio_class = {
+	.name = "davinci_mdio",
+};
+
+static struct omap_hwmod am35xx_mdio_hwmod = {
+	.name		= "davinci_mdio",
+	.class		= &am35xx_mdio_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+static struct omap_hwmod_ocp_if am35xx_mdio__l3 = {
+	.master		= &am35xx_mdio_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "emac_fck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space am35xx_mdio_addrs[] = {
+	{
+		.pa_start	= AM35XX_IPSS_MDIO_BASE,
+		.pa_end		= AM35XX_IPSS_MDIO_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l4_core -> davinci mdio  */
+static struct omap_hwmod_ocp_if am35xx_l4_core__mdio = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &am35xx_mdio_hwmod,
+	.clk		= "emac_fck",
+	.addr		= am35xx_mdio_addrs,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_irq_info am35xx_emac_mpu_irqs[] = {
+	{ .name = "rxthresh",	.irq = INT_35XX_EMAC_C0_RXTHRESH_IRQ },
+	{ .name = "rx_pulse",	.irq = INT_35XX_EMAC_C0_RX_PULSE_IRQ },
+	{ .name = "tx_pulse",	.irq = INT_35XX_EMAC_C0_TX_PULSE_IRQ },
+	{ .name = "misc_pulse",	.irq = INT_35XX_EMAC_C0_MISC_PULSE_IRQ },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_class am35xx_emac_class = {
+	.name = "davinci_emac",
+};
+
+static struct omap_hwmod am35xx_emac_hwmod = {
+	.name		= "davinci_emac",
+	.mpu_irqs	= am35xx_emac_mpu_irqs,
+	.class		= &am35xx_emac_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* l3_core -> davinci emac interface */
+static struct omap_hwmod_ocp_if am35xx_emac__l3 = {
+	.master		= &am35xx_emac_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "emac_ick",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space am35xx_emac_addrs[] = {
+	{
+		.pa_start	= AM35XX_IPSS_EMAC_BASE,
+		.pa_end		= AM35XX_IPSS_EMAC_BASE + 0x30000 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l4_core -> davinci emac  */
+static struct omap_hwmod_ocp_if am35xx_l4_core__emac = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &am35xx_emac_hwmod,
+	.clk		= "emac_ick",
+	.addr		= am35xx_emac_addrs,
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
@@ -3266,6 +3347,10 @@ static struct omap_hwmod_ocp_if *am35xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__usb_tll_hs,
 	&omap3xxx_l4_core__es3plus_mmc1,
 	&omap3xxx_l4_core__es3plus_mmc2,
+	&am35xx_mdio__l3,
+	&am35xx_l4_core__mdio,
+	&am35xx_emac__l3,
+	&am35xx_l4_core__emac,
 	NULL
 };
 
-- 
1.7.10

