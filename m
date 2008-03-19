From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: OMAP MMC multiport support
Date: Wed, 19 Mar 2008 16:11:25 -0500
Message-ID: <20080319211124.GB31019@ubuntu-workstation>
References: <814dfab70803180547i37859e48o5bdf33212ff7cd51@mail.gmail.com> <20080318115247.GE7843@atomide.com> <7EAD1AEEA7621C45899FE99123E124A0017B21ED@dbde01.ent.ti.com> <20080318134637.GA24660@ubuntu-workstation> <7EAD1AEEA7621C45899FE99123E124A0017B2202@dbde01.ent.ti.com> <309201e0803191153j600503eflbf6dc8845bc4205b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:3031 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936561AbYCSVMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 17:12:55 -0400
Received: by py-out-1112.google.com with SMTP id u52so782633pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 14:12:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <309201e0803191153j600503eflbf6dc8845bc4205b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keppler Alecrim <alecrim@gmail.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, Remith Ravi <remithmailinglist@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, Mar 19, 2008 at 08:53:48PM +0200, Keppler Alecrim wrote:
> What about DMA channel? Isn't it necessary?
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 3d4a7d1..262d846 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -514,10 +514,18 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host
> *host, struct mmc_request *req)
> 
>  	if (!(data->flags & MMC_DATA_WRITE)) {
>  		host->dma_dir = DMA_FROM_DEVICE;
> -		sync_dev = OMAP24XX_DMA_MMC1_RX;
> +		if (host->id == OMAP_MMC1_DEVID)
> +			sync_dev = OMAP24XX_DMA_MMC1_RX;
> +		else
> +			sync_dev = OMAP24XX_DMA_MMC2_RX;
> +
>  	} else {
>  		host->dma_dir = DMA_TO_DEVICE;
> -		sync_dev = OMAP24XX_DMA_MMC1_TX;
> +		if (host->id == OMAP_MMC1_DEVID)
> +			sync_dev = OMAP24XX_DMA_MMC1_TX;
> +		else
> +			sync_dev = OMAP24XX_DMA_MMC2_TX;
> +
>  	}

Indeed.  The kernel I'm working with already had this though.

Okay, I checked other differences between in the omap_hsmmc.c that I'm working
with and didn't find anything necessary for MMC2.  I've incorporated this into
the patch below, which I think is everything needed to get MMC2 working.  This
should emphasize the point that someone needs to test with this patch, as I am
unable to test it myself.

I would also like someone familiar with both OMAP 2430 and 2420 to look at the
pin-muxing changes in the patch.  I found that some pins were being set up in
the MMC1 configuration with the same configuration register offsets as those
for MMC2.  I assumed that those were for the 2420 and modified the MMC1
initialization accordingly.  If these changes are correct I will break them
out into a separate patch before I submit.

Cheers,
Seth


diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index fb639f5..48704b2 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -210,6 +210,14 @@ MUX_CFG_24XX("AC10_2430_MCBSP2_FSX_OFF",0x012E,	0,	0,	0,	1)
 MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
 MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
 MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
+
+/* MMC2 */
+MUX_CFG_24XX("V26_2430_MMC2_CLKO",	0x0f9,	0,	0,	0,	1)
+MUX_CFG_24XX("V24_2430_MMC2_DAT3",	0x0fa,	0,	0,	0,	1)
+MUX_CFG_24XX("W20_2430_MMC2_CMD",	0x0fb,	0,	0,	0,	1)
+MUX_CFG_24XX("V23_2430_MMC2_DAT0",	0x0fc,	0,	0,	0,	1)
+MUX_CFG_24XX("V25_2430_MMC2_DAT2",	0x0fd,	0,	0,	0,	1)
+MUX_CFG_24XX("Y24_2430_MMC2_DAT1",	0x0fe,	0,	0,	0,	1)
 };
 
 #define OMAP24XX_PINS_SZ	ARRAY_SIZE(omap24xx_pins)
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ec9a999..1859ed4 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -161,7 +161,17 @@ static inline void omap_init_kp(void) {}
 #define	OMAP_MMC1_BASE		0xfffb7800
 #define OMAP_MMC1_INT		INT_MMC
 #endif
-#define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+
+#if defined(CONFIG_ARCH_OMAP16XX)
+#define	OMAP_MMC2_BASE		0xfffb7c00
+#define	OMAP_MMC2_INT		INT_1610_MMC2
+#elif defined(CONFIG_ARCH_OMAP2430)
+#define	OMAP_MMC2_BASE		0x480b4000
+#define	OMAP_MMC2_INT		INT_24XX_MMC2_IRQ
+#endif
+
+#define OMAP_MMC2_SUPPORT \
+	(defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430))
 
 static struct omap_mmc_platform_data mmc1_data;
 
@@ -190,7 +200,7 @@ static struct platform_device mmc_omap_device1 = {
 	.resource	= mmc1_resources,
 };
 
-#ifdef	CONFIG_ARCH_OMAP16XX
+#if OMAP_MMC2_SUPPORT
 
 static struct omap_mmc_platform_data mmc2_data;
 
@@ -204,7 +214,7 @@ static struct resource mmc2_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= INT_1610_MMC2,
+		.start		= OMAP_MMC2_INT,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -243,11 +253,13 @@ static void __init omap_init_mmc(void)
 	if (mmc->enabled) {
 		if (cpu_is_omap24xx()) {
 			omap_cfg_reg(H18_24XX_MMC_CMD);
-			omap_cfg_reg(H15_24XX_MMC_CLKI);
 			omap_cfg_reg(G19_24XX_MMC_CLKO);
 			omap_cfg_reg(F20_24XX_MMC_DAT0);
-			omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
-			omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
+			if (cpu_is_omap242x()) {
+				omap_cfg_reg(H15_24XX_MMC_CLKI);
+				omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
+				omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
+			}
 		} else {
 			omap_cfg_reg(MMC_CMD);
 			omap_cfg_reg(MMC_CLK);
@@ -263,9 +275,11 @@ static void __init omap_init_mmc(void)
 				omap_cfg_reg(H14_24XX_MMC_DAT1);
 				omap_cfg_reg(E19_24XX_MMC_DAT2);
 				omap_cfg_reg(D19_24XX_MMC_DAT3);
-				omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
-				omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
-				omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
+				if (cpu_is_omap242x()) {
+					omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
+					omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
+					omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
+				}
 			} else {
 				omap_cfg_reg(MMC_DAT1);
 				/* NOTE:  DAT2 can be on W10 (here) or M15 */
@@ -291,25 +305,39 @@ static void __init omap_init_mmc(void)
 		(void) platform_device_register(&mmc_omap_device1);
 	}
 
-#ifdef	CONFIG_ARCH_OMAP16XX
+#if OMAP_MMC2_SUPPORT
 	/* block 2 is on newer chips, and has many pinout options */
 	mmc = &mmc_conf->mmc[1];
 	if (mmc->enabled) {
 		if (!mmc->nomux) {
-			omap_cfg_reg(Y8_1610_MMC2_CMD);
-			omap_cfg_reg(Y10_1610_MMC2_CLK);
-			omap_cfg_reg(R18_1610_MMC2_CLKIN);
-			omap_cfg_reg(W8_1610_MMC2_DAT0);
+			if (cpu_is_omap243x()) {
+				omap_cfg_reg(V26_2430_MMC2_CLKO);
+				omap_cfg_reg(W20_2430_MMC2_CMD);
+				omap_cfg_reg(V23_2430_MMC2_DAT0);
+			} else {
+				omap_cfg_reg(Y8_1610_MMC2_CMD);
+				omap_cfg_reg(Y10_1610_MMC2_CLK);
+				omap_cfg_reg(R18_1610_MMC2_CLKIN);
+				omap_cfg_reg(W8_1610_MMC2_DAT0);
+			}
 			if (mmc->wire4) {
-				omap_cfg_reg(V8_1610_MMC2_DAT1);
-				omap_cfg_reg(W15_1610_MMC2_DAT2);
-				omap_cfg_reg(R10_1610_MMC2_DAT3);
+				if (cpu_is_omap243x()) {
+					omap_cfg_reg(Y24_2430_MMC2_DAT1);
+					omap_cfg_reg(V25_2430_MMC2_DAT2);
+					omap_cfg_reg(V24_2430_MMC2_DAT3);
+				} else {
+					omap_cfg_reg(V8_1610_MMC2_DAT1);
+					omap_cfg_reg(W15_1610_MMC2_DAT2);
+					omap_cfg_reg(R10_1610_MMC2_DAT3);
+				}
 			}
 
 			/* These are needed for the level shifter */
-			omap_cfg_reg(V9_1610_MMC2_CMDDIR);
-			omap_cfg_reg(V5_1610_MMC2_DATDIR0);
-			omap_cfg_reg(W19_1610_MMC2_DATDIR1);
+			if (cpu_is_omap16xx()) {
+				omap_cfg_reg(V9_1610_MMC2_CMDDIR);
+				omap_cfg_reg(V5_1610_MMC2_DATDIR0);
+				omap_cfg_reg(W19_1610_MMC2_DATDIR1);
+			}
 		}
 
 		/* Feedback clock must be set on OMAP-1710 MMC2 */
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3d4a7d1..0f1bb9c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -388,8 +388,12 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 	 * If a MMC dual voltage card is detected, the set_ios fn calls
 	 * this fn with VDD bit set for 1.8V. Upon card removal from the
 	 * slot, mmc_omap_detect fn sets the VDD back to 3V.
+	 *
+	 * Only MMC1 supports 3.0V.  MMC2 will not function if SDVS30 is
+	 * set in HCTL.
 	 */
-	if (((1 << vdd) == MMC_VDD_32_33) || ((1 << vdd) == MMC_VDD_33_34))
+	if (host->id == OMAP_MMC1_DEVID && (((1 << vdd) == MMC_VDD_32_33) ||
+				((1 << vdd) == MMC_VDD_33_34)))
 		reg_val |= SDVS30;
 	if ((1 << vdd) == MMC_VDD_165_195)
 		reg_val |= SDVS18;
@@ -514,10 +518,16 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
 
 	if (!(data->flags & MMC_DATA_WRITE)) {
 		host->dma_dir = DMA_FROM_DEVICE;
-		sync_dev = OMAP24XX_DMA_MMC1_RX;
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_RX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_RX;
 	} else {
 		host->dma_dir = DMA_TO_DEVICE;
-		sync_dev = OMAP24XX_DMA_MMC1_TX;
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_TX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_TX;
 	}
 
 	ret = omap_request_dma(sync_dev, "MMC/SD", mmc_omap_dma_cb,
@@ -689,6 +699,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	int ret = 0, irq;
+	u32 hctl, capa;
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform Data is missing\n");
@@ -775,11 +786,20 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	if (pdata->conf.wire4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
+	/* Only MMC1 supports 3.0V */
+	if (host->id == OMAP_MMC1_DEVID) {
+		hctl = SDVS30;
+		capa = VS30 | VS18;
+	} else {
+		hctl = SDVS18;
+		capa = VS18;
+	}
+
 	OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | SDVS30);
+			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
 
-	OMAP_HSMMC_WRITE(host->base, CAPA, OMAP_HSMMC_READ(host->base,
-							CAPA) | VS30 | VS18);
+	OMAP_HSMMC_WRITE(host->base, CAPA,
+			OMAP_HSMMC_READ(host->base, CAPA) | capa);
 
 	/* Set the controller to AUTO IDLE mode */
 	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index f216b4d..c58db03 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -641,6 +641,14 @@ enum omap24xx_index {
 	AE13_2430_MCBSP2_DX_OFF,
 	AD13_2430_MCBSP2_DR_OFF,
 
+	/* 2430 MMC2 */
+	V26_2430_MMC2_CLKO,
+	V24_2430_MMC2_DAT3,
+	W20_2430_MMC2_CMD,
+	V23_2430_MMC2_DAT0,
+	V25_2430_MMC2_DAT2,
+	Y24_2430_MMC2_DAT1,
+
 };
 
 enum omap34xx_index {
