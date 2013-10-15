From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v9 2/9] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Tue, 15 Oct 2013 11:19:50 +0530
Message-ID: <1381816197-20477-3-git-send-email-pekon@ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35571 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932512Ab3JOFvQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 01:51:16 -0400
In-Reply-To: <1381816197-20477-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

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
 arch/arm/mach-omap2/gpmc.c                         | 45 ++++++++++++++++------
 include/linux/platform_data/mtd-nand-omap2.h       | 14 +++++--
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index 25ee232..5e1f31b 100644
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
index c9fb353..9473c9f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1341,12 +1341,6 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 
 #ifdef CONFIG_MTD_NAND
 
-static const char * const nand_ecc_opts[] = {
-	[OMAP_ECC_HAM1_CODE_HW]			= "ham1",
-	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
-	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
-};
-
 static const char * const nand_xfer_types[] = {
 	[NAND_OMAP_PREFETCH_POLLED]		= "prefetch-polled",
 	[NAND_OMAP_POLLED]			= "polled",
@@ -1376,12 +1370,39 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
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
+	/* select NAND ecc-opt */
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
 
 	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
 		for (val = 0; val < ARRAY_SIZE(nand_xfer_types); val++)
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index cb5a54a..4da5bfa 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -23,9 +23,16 @@ enum nand_io {
 };
 
 enum omap_ecc {
-	OMAP_ECC_HAM1_CODE_HW = 0, /* 1-bit Hamming ecc code */
-	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
-	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
+	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_HAM1_CODE_HW = 0,
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
@@ -59,5 +66,6 @@ struct omap_nand_platform_data {
 
 	/* for passing the partitions */
 	struct device_node	*of_node;
+	struct device_node	*elm_of_node;
 };
 #endif
-- 
1.8.1

