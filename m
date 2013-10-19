From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v10 01/10] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Sat, 19 Oct 2013 14:14:05 +0530
Message-ID: <1382172254-12448-2-git-send-email-pekon@ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36398 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262Ab3JSIpU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Oct 2013 04:45:20 -0400
In-Reply-To: <1382172254-12448-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

OMAP NAND driver support multiple ECC scheme, which can used in different
flavours, depending on in-build Hardware engines present on SoC.

This patch updates following in DT bindings related to sectionion of ecc-schemes
- ti,elm-id: replaces elm_id (maintains backward compatibility)
- ti,nand-ecc-opts: selection of h/w or s/w implementation of an ecc-scheme
	depends on ti,elm-id. (supported values ham1, bch4, and bch8)
- maintain backward compatibility to deprecated DT bindings (sw, hw, hw-romcode)

Below table shows different flavours of ecc-schemes supported by OMAP devices
+---------------------------------------+---------------+---------------+
| ECC scheme                            |ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
|(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
|(requires CONFIG_MTD_NAND_OMAP_BCH &&  |               |               |
| ti,elm-id in DT)                      |               |               |
+---------------------------------------+---------------+---------------+

To optimize footprint of omap2-nand driver, selection of some ECC schemes
also require enabling following Kconfigs, in addition to setting appropriate
DT bindings
- Kconfig:CONFIG_MTD_NAND_ECC_BCH        error detection done in software
- Kconfig:CONFIG_MTD_NAND_OMAP_BCH       error detection done by h/w engine

Signed-off-by: Pekon Gupta <pekon@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  8 +++-
 arch/arm/mach-omap2/gpmc.c                         | 48 +++++++++++++++-------
 include/linux/platform_data/mtd-nand-omap2.h       | 13 +++++-
 3 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index df338cb..bfe07e1 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -36,8 +36,12 @@ Optional properties:
 		"prefetch-dma"		Prefetch enabled sDMA mode
 		"prefetch-irq"		Prefetch enabled irq mode
 
- - elm_id:	Specifies elm device node. This is required to support BCH
- 		error correction using ELM module.
+ - elm_id:	<deprecated> use "ti,elm-id" instead
+ - ti,elm-id:	Specifies phandle of the ELM devicetree node.
+		ELM is an on-chip hardware engine on TI SoC which is used for
+		locating ECC errors for BCHx algorithms. SoC devices which have
+		ELM hardware engines should specify this device node in .dtsi
+		Using ELM for ECC error correction frees some CPU cycles.
 
 For inline partiton table parsing (optional):
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 579697a..c877129 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1341,14 +1341,6 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 
 #ifdef CONFIG_MTD_NAND
 
-static const char * const nand_ecc_opts[] = {
-	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
-	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
-	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-romcode",
-	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
-	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
-};
-
 static const char * const nand_xfer_types[] = {
 	[NAND_OMAP_PREFETCH_POLLED]		= "prefetch-polled",
 	[NAND_OMAP_POLLED]			= "polled",
@@ -1378,13 +1370,41 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 	gpmc_nand_data->cs = val;
 	gpmc_nand_data->of_node = child;
 
-	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s))
-		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
-			if (!strcasecmp(s, nand_ecc_opts[val])) {
-				gpmc_nand_data->ecc_opt = val;
-				break;
-			}
+	/* Detect availability of ELM module */
+	gpmc_nand_data->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
+	if (gpmc_nand_data->elm_of_node == NULL)
+		gpmc_nand_data->elm_of_node =
+					of_parse_phandle(child, "elm_id", 0);
+	if (gpmc_nand_data->elm_of_node == NULL)
+		pr_warn("%s: ti,elm-id property not found\n", __func__);
+
+	/* select ecc-scheme for NAND */
+	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
+		pr_err("%s: ti,nand-ecc-opt not found\n", __func__);
+		return -ENODEV;
+	}
+	if (!strcmp(s, "ham1") || !strcmp(s, "sw") ||
+		!strcmp(s, "hw") || !strcmp(s, "hw-romcode"))
+		gpmc_nand_data->ecc_opt =
+				OMAP_ECC_HAM1_CODE_HW;
+	else if (!strcmp(s, "bch4"))
+		if (gpmc_nand_data->elm_of_node)
+			gpmc_nand_data->ecc_opt =
+				OMAP_ECC_BCH4_CODE_HW;
+		else
+			gpmc_nand_data->ecc_opt =
+				OMAP_ECC_BCH4_CODE_HW_DETECTION_SW;
+	else if (!strcmp(s, "bch8"))
+		if (gpmc_nand_data->elm_of_node)
+			gpmc_nand_data->ecc_opt =
+				OMAP_ECC_BCH8_CODE_HW;
+		else
+			gpmc_nand_data->ecc_opt =
+				OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
+	else
+		pr_err("%s: ti,nand-ecc-opt invalid value\n", __func__);
 
+	/* select data transfer mode for NAND controller */
 	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
 		for (val = 0; val < ARRAY_SIZE(nand_xfer_types); val++)
 			if (!strcasecmp(s, nand_xfer_types[val])) {
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 6bf9ef4..e4128f1 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -28,8 +28,16 @@ enum omap_ecc {
 	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
 		/* 1-bit ecc: stored at beginning of spare area as romcode */
 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
-	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
-	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
+	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_HAM1_CODE_HW,
+	/* 4-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW,
+	/* 4-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH4_CODE_HW,
+	/* 8-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW,
+	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH8_CODE_HW,
 };
 
 struct gpmc_nand_regs {
@@ -63,5 +71,6 @@ struct omap_nand_platform_data {
 
 	/* for passing the partitions */
 	struct device_node	*of_node;
+	struct device_node	*elm_of_node;
 };
 #endif
-- 
1.8.1

