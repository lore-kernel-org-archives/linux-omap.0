From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] ARM: OMAP2+: omap3-pandora: add wifi support
Date: Tue, 21 Jul 2015 04:12:01 +0300
Message-ID: <1437441121-31658-4-git-send-email-notasas@gmail.com>
References: <1437441121-31658-1-git-send-email-notasas@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437441121-31658-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add wl1251 support via pdata-quirks as it's driver lacks DT
support. MMC3 is marked disabled in DT so that MMC3 instance of
hsmmc driver is probed using platform data with special card init
callback.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi |   5 ++
 arch/arm/mach-omap2/pdata-quirks.c          | 101 ++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 6e82c4a..f2084e6 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -514,6 +514,11 @@
 	/*wp-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;*/	/* GPIO_127 */
 };
 
+/* mmc3 is probed using pdata-quirks to pass wl1251 card data */
+&mmc3 {
+	status = "disabled";
+};
+
 /* bluetooth*/
 &uart1 {
 };
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3c97aa49..95f6724 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -14,6 +14,11 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/ti_wilink_st.h>
+#include <linux/wl12xx.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
@@ -25,6 +30,7 @@
 #include "omap_device.h"
 #include "omap-secure.h"
 #include "soc.h"
+#include "hsmmc.h"
 
 struct pdata_init {
 	const char *compatible;
@@ -269,14 +275,109 @@ static void __init omap3_tao3530_legacy_init(void)
 	hsmmc2_internal_input_clk();
 }
 
+/* omap3pandora legacy devices */
+#define PANDORA_WIFI_IRQ_GPIO		21
+#define PANDORA_WIFI_NRESET_GPIO	23
+
 static struct platform_device pandora_backlight = {
 	.name	= "pandora-backlight",
 	.id	= -1,
 };
 
+static struct regulator_consumer_supply pandora_vmmc3_supply[] = {
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.2"),
+};
+
+static struct regulator_init_data pandora_vmmc3 = {
+	.constraints = {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(pandora_vmmc3_supply),
+	.consumer_supplies	= pandora_vmmc3_supply,
+};
+
+static struct fixed_voltage_config pandora_vwlan = {
+	.supply_name		= "vwlan",
+	.microvolts		= 1800000, /* 1.8V */
+	.gpio			= PANDORA_WIFI_NRESET_GPIO,
+	.startup_delay		= 50000, /* 50ms */
+	.enable_high		= 1,
+	.init_data		= &pandora_vmmc3,
+};
+
+static struct platform_device pandora_vwlan_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data = &pandora_vwlan,
+	},
+};
+
+static void pandora_wl1251_init_card(struct mmc_card *card)
+{
+	/*
+	 * We have TI wl1251 attached to MMC3. Pass this information to
+	 * SDIO core because it can't be probed by normal methods.
+	 */
+	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
+		card->quirks |= MMC_QUIRK_NONSTD_SDIO;
+		card->cccr.wide_bus = 1;
+		card->cis.vendor = 0x104c;
+		card->cis.device = 0x9066;
+		card->cis.blksize = 512;
+		card->cis.max_dtr = 24000000;
+		card->ocr = 0x80;
+	}
+}
+
+static struct omap2_hsmmc_info pandora_mmc3[] = {
+	{
+		.mmc		= 3,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+		.init_card	= pandora_wl1251_init_card,
+	},
+	{}	/* Terminator */
+};
+
+static void __init pandora_wl1251_init(void)
+{
+	struct wl1251_platform_data pandora_wl1251_pdata;
+	int ret;
+
+	memset(&pandora_wl1251_pdata, 0, sizeof(pandora_wl1251_pdata));
+
+	pandora_wl1251_pdata.power_gpio = -1;
+
+	ret = gpio_request_one(PANDORA_WIFI_IRQ_GPIO, GPIOF_IN, "wl1251 irq");
+	if (ret < 0)
+		goto fail;
+
+	pandora_wl1251_pdata.irq = gpio_to_irq(PANDORA_WIFI_IRQ_GPIO);
+	if (pandora_wl1251_pdata.irq < 0)
+		goto fail_irq;
+
+	pandora_wl1251_pdata.use_eeprom = true;
+	ret = wl1251_set_platform_data(&pandora_wl1251_pdata);
+	if (ret < 0)
+		goto fail_irq;
+
+	return;
+
+fail_irq:
+	gpio_free(PANDORA_WIFI_IRQ_GPIO);
+fail:
+	pr_err("wl1251 board initialisation failed\n");
+}
+
 static void __init omap3_pandora_legacy_init(void)
 {
 	platform_device_register(&pandora_backlight);
+	platform_device_register(&pandora_vwlan_device);
+	omap_hsmmc_init(pandora_mmc3);
+	omap_hsmmc_late_init(pandora_mmc3);
+	pandora_wl1251_init();
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
