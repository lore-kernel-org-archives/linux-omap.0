From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci
 EMAC
Date: Tue, 17 Jul 2012 21:54:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207171814100.28834@utopia.booyaka.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com> <1336770778-23044-3-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57396 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2GRDyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 23:54:54 -0400
In-Reply-To: <1336770778-23044-3-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

just a quick comment on this one.

On Fri, 11 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs has a Davinci EMAC ethernet
> controller on-chip.  Unfortunately, the EMAC is unable
> to wake the PRCM when there is network activity which
> leads to a hung or extremely slow system when the MPU
> has executed a 'wfi' instruction (because of pm_idle
> or CPUidle).  To prevent this, add hooks to the EMAC
> pm_runtime suspend/resume calls so that hlt is disabled
> whenever the EMAC is in use.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

...

> --- a/arch/arm/mach-omap2/am35xx-emac.c
> +++ b/arch/arm/mach-omap2/am35xx-emac.c
> @@ -23,6 +23,37 @@
>  #include "control.h"
>  #include "am35xx-emac.h"
>  
> +/*
> + * Default pm_lats for the am35x.
> + * The net effect of using am35xx_emac_pm_lats[] is that
> + * pm_idle or CPUidle won't be called while the emac
> + * interface is open.  This is required because the
> + * EMAC can't wake up PRCM so if the MPU is executing
> + * a 'wfi' instruction (e.g., from pm_idle or CPUidle),
> + * it won't break out of it due to emac activity.
> + */
> +static int am35xx_emac_deactivate_func(struct omap_device *od)
> +{
> +	enable_hlt();
> +	return omap_device_idle_hwmods(od);
> +}
> +
> +static int am35xx_emac_activate_func(struct omap_device *od)
> +{
> +	disable_hlt();
> +	return omap_device_enable_hwmods(od);
> +}

>From the patch description, it doesn't sound like it's WFI entry that's 
the problem.  The EMAC can assert its interrupt lines to the INTC, since 
the EMAC is active.  If the MPU and CORE powerdomains are ON, then the ARM 
core should wake up out of WFI.  (Unless there's some weird bug; always 
possible.)

Probably the MPU DPLL has to stay running for it all to work, since I 
think that is activated and deactivated by the PRCM.  Maybe the CORE DPLL 
has to stay running too (but I doubt it).  But I'll bet that all the 
clocks downstream of the DPLLs can be gated.  If it works, that would save 
a lot of energy over the disable_hlt() approach.  With disable_hlt(), the 
ARM & interconnect is just going to be burning power waiting for the 
interrupt to come in.

Want to try something like this?  It's your patch but modified to not use 
disable/enable_hlt().  If it doesn't work in your test case, maybe 
try uncommenting that second set of deny_idle / allow_idle ...


- Paul

---
 arch/arm/mach-omap2/am35xx-emac.c |   54 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 2c90ac6..d09ccd2 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -23,6 +23,41 @@
 #include "control.h"
 #include "am35xx-emac.h"
 
+static struct clk *mpu_dpll_ck, *core_dpll_ck;
+
+/*
+ * Default pm_lats for the am35x.
+ * The net effect of using am35xx_emac_pm_lats[] is that
+ * pm_idle or CPUidle won't be called while the emac
+ * interface is open.  This is required because the
+ * EMAC can't wake up PRCM so if the MPU is executing
+ * a 'wfi' instruction (e.g., from pm_idle or CPUidle),
+ * it won't break out of it due to emac activity.
+ */
+static int am35xx_emac_deactivate_func(struct omap_device *od)
+{
+	mpu_dpll_ck->ops->deny_idle(mpu_dpll_ck);
+	/* core_dpll_ck->ops->deny_idle(core_dpll_ck); */
+	return omap_device_idle_hwmods(od);
+}
+
+static int am35xx_emac_activate_func(struct omap_device *od)
+{
+	mpu_dpll_ck->ops->allow_idle(mpu_dpll_ck);
+	/* core_dpll_ck->ops->allow_idle(core_dpll_ck); */
+	return omap_device_enable_hwmods(od);
+}
+
+struct omap_device_pm_latency am35xx_emac_pm_lats[] = {
+	{
+		.deactivate_func	= am35xx_emac_deactivate_func,
+		.activate_func		= am35xx_emac_activate_func,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int am35xx_emac_pm_lats_size = ARRAY_SIZE(am35xx_emac_pm_lats);
+
 static void am35xx_enable_emac_int(void)
 {
 	u32 v;
@@ -58,12 +93,14 @@ static struct emac_platform_data am35xx_emac_pdata = {
 static struct mdio_platform_data am35xx_mdio_pdata;
 
 static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
-		void *pdata, int pdata_len)
+					     void *pdata, int pdata_len,
+					     struct omap_device_pm_latency *pm_lats,
+					     int pm_lats_size)
 {
 	struct platform_device *pdev;
 
 	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len,
-				 NULL, 0, false);
+				 pm_lats, pm_lats_size, false);
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 		     oh->class->name, oh->name);
@@ -73,7 +110,8 @@ static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
 	return 0;
 }
 
-void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
+void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en,
+		struct omap_device_pm_latency *pm_lats, int pm_lats_size)
 {
 	struct omap_hwmod *oh;
 	u32 v;
@@ -88,7 +126,7 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 	am35xx_mdio_pdata.bus_freq = mdio_bus_freq;
 
 	ret = omap_davinci_emac_dev_init(oh, &am35xx_mdio_pdata,
-					 sizeof(am35xx_mdio_pdata));
+					 sizeof(am35xx_mdio_pdata), NULL, 0);
 	if (ret) {
 		pr_err("Could not build davinci_mdio hwmod device\n");
 		return;
@@ -103,12 +141,18 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 	am35xx_emac_pdata.rmii_en = rmii_en;
 
 	ret = omap_davinci_emac_dev_init(oh, &am35xx_emac_pdata,
-					 sizeof(am35xx_emac_pdata));
+					 sizeof(am35xx_emac_pdata),
+					 pm_lats, pm_lats_size);
 	if (ret) {
 		pr_err("Could not build davinci_emac hwmod device\n");
 		return;
 	}
 
+	mpu_dpll_ck = clk_get(NULL, "dpll1_ck");
+	WARN(!mpu_dpll_ck);
+	core_dpll_ck = clk_get(NULL, "dpll3_ck");
+	WARN(!core_dpll_ck);
+
 	v = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 	v &= ~AM35XX_CPGMACSS_SW_RST;
 	omap_ctrl_writel(v, AM35XX_CONTROL_IP_SW_RESET);
-- 
1.7.10.4

