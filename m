From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 4/7] ARM: OMAP: N8x0: configure menelaus using DT
Date: Sat, 27 Dec 2014 19:52:56 +0200
Message-ID: <1419702779-16001-5-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1419702779-16001-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Configure Menelaus using DT.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi |  3 ++
 arch/arm/mach-omap2/board-n8x0.c            | 57 -----------------------------
 arch/arm/mach-omap2/pdata-quirks.c          |  1 -
 3 files changed, 3 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index c9f1e93..c19718c 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -32,6 +32,9 @@
 		compatible = "menelaus";
 		reg = <0x72>;
 		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+		ti,autosleep;
+		ti,vcore-min-microvolt = <1050000>;
+		ti,vcore-max-microvolt = <1400000>;
 	};
 };
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index b6443a4..0b511c0 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -516,63 +516,6 @@ void __init n8x0_mmc_init(void)
 }
 #endif	/* CONFIG_MMC_OMAP */
 
-#ifdef CONFIG_MENELAUS
-
-static int n8x0_auto_sleep_regulators(void)
-{
-	u32 val;
-	int ret;
-
-	val = EN_VPLL_SLEEP | EN_VMMC_SLEEP    \
-		| EN_VAUX_SLEEP | EN_VIO_SLEEP \
-		| EN_VMEM_SLEEP | EN_DC3_SLEEP \
-		| EN_VC_SLEEP | EN_DC2_SLEEP;
-
-	ret = menelaus_set_regulator_sleep(1, val);
-	if (ret < 0) {
-		pr_err("Could not set regulators to sleep on menelaus: %u\n",
-		       ret);
-		return ret;
-	}
-	return 0;
-}
-
-static int n8x0_auto_voltage_scale(void)
-{
-	int ret;
-
-	ret = menelaus_set_vcore_hw(1400, 1050);
-	if (ret < 0) {
-		pr_err("Could not set VCORE voltage on menelaus: %u\n", ret);
-		return ret;
-	}
-	return 0;
-}
-
-static int n8x0_menelaus_late_init(struct device *dev)
-{
-	int ret;
-
-	ret = n8x0_auto_voltage_scale();
-	if (ret < 0)
-		return ret;
-	ret = n8x0_auto_sleep_regulators();
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-#else
-static int n8x0_menelaus_late_init(struct device *dev)
-{
-	return 0;
-}
-#endif
-
-struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
-	.late_init = n8x0_menelaus_late_init,
-};
-
 struct aic3x_pdata n810_aic33_data __initdata = {
 	.gpio_reset = 118,
 };
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d7eee1..fca4650 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -369,7 +369,6 @@ static struct pdata_init auxdata_quirks[] __initdata = {
 struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
-	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
 	OF_DEV_AUXDATA("tlv320aic3x", 0x18, "2-0018", &n810_aic33_data),
 #endif
 #ifdef CONFIG_ARCH_OMAP3
-- 
2.2.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
