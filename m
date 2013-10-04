From: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 2/6] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Sat, 5 Oct 2013 01:19:44 +0530
Message-ID: <1380916188-24206-3-git-send-email-pekon@ti.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380916188-24206-1-git-send-email-pekon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Pawel.Moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP NAND driver support multiple ECC scheme, which can used in following
different flavours, depending on in-build Hardware engines supported by SoC.

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

DT binding updates in this patch are:
- ti,elm-id: replaces elm_id
- ti,nand-ecc-opts: supported values ham1, bch4, and bch8
	selection of h/w or s/w implementation depends on ti,elm-id

Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  8 +++-
 arch/arm/mach-omap2/gpmc.c                         | 47 ++++++++++++++++------
 include/linux/platform_data/mtd-nand-omap2.h       | 14 +++++--
 3 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index 25ee232..7785666 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -36,8 +36,12 @@ Optional properties:
 		"prefetch-dma"		Prefetch enabled sDMA mode
 		"prefetch-irq"		Prefetch enabled irq mode
 
- - elm_id:	Specifies elm device node. This is required to support BCH
- 		error correction using ELM module.
+ - elm_id:	<deprecated> use "ti,elm-id" instead
+ - ti,elm-id:	Specifies pHandle of the ELM devicetree node.
+		ELM is an on-chip hardware engine on TI SoC which is used for
+		locating ECC errors for BCHx algorithms. SoC devices which have
+		ELM hardware engines should specify this device node in .dtsi
+		Using ELM for ECC error correction frees some CPU cycles.
 
 For inline partiton table parsing (optional):
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1c45b72..5a607fa 100644
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
@@ -1361,6 +1355,8 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 	const char *s;
 	struct gpmc_timings gpmc_t;
 	struct omap_nand_platform_data *gpmc_nand_data;
+	const __be32 *phandle;
+	int lenp;
 
 	if (of_property_read_u32(child, "reg", &val) < 0) {
 		dev_err(&pdev->dev, "%s has no 'reg' property\n",
@@ -1376,12 +1372,39 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 	gpmc_nand_data->cs = val;
 	gpmc_nand_data->of_node = child;
 
-	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s))
-		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
-			if (!strcasecmp(s, nand_ecc_opts[val])) {
-				gpmc_nand_data->ecc_opt = val;
-				break;
-			}
+	/* Detect availability of ELM module */
+	phandle = of_get_property(child, "ti,elm-id", &lenp);
+	if ((phandle == NULL) || (lenp != sizeof(void *))) {
+		pr_warn("%s: ti,elm-id property not found\n", __func__);
+		gpmc_nand_data->elm_of_node = NULL;
+	} else {
+		gpmc_nand_data->elm_of_node =
+				of_find_node_by_phandle(be32_to_cpup(phandle));
+	}
+	/* select NAND ecc-opt */
+	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
+		pr_err("%s: ti,nand-ecc-opt not found\n", __func__);
+		return -ENODEV;
+	}
+	if (!strcmp(s, "ham1"))
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
