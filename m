From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: OMAP MMC multiport support
Date: Tue, 18 Mar 2008 08:46:41 -0500
Message-ID: <20080318134637.GA24660@ubuntu-workstation>
References: <814dfab70803180547i37859e48o5bdf33212ff7cd51@mail.gmail.com> <20080318115247.GE7843@atomide.com> <7EAD1AEEA7621C45899FE99123E124A0017B21ED@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:35383 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYCRNsB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 09:48:01 -0400
Received: by py-out-1112.google.com with SMTP id u52so8435689pyb.10
        for <linux-omap@vger.kernel.org>; Tue, 18 Mar 2008 06:48:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0017B21ED@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>, Remith Ravi <remithmailinglist@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, Mar 18, 2008 at 06:50:39PM +0530, Syed Mohammed, Khasim wrote:
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Tuesday, March 18, 2008 5:23 PM
> > To: Remith Ravi
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: OMAP MMC multiport support
> > 
> > * Remith Ravi <remithmailinglist@gmail.com> [080318 14:47]:
> > > Hi,
> > >
> > > Is there any OMAP MMC driver implementation exist which support multi
> > > port implementation?
> > > I am working on OMAP-2530 EVM and want to have support for both MMC
> > > port 1 and port 2.
> > >
> > > Please let me know if you have any input.
> > 
> > Well if 2530 has same controller as 2420, then yes, it should be
> > supported by configuring it in board-*.c files.
> >
> 
> 2530 is same as 2430, and the 3430 MMC driver is best fit for that and it supports Multi MMC controllers (and not slots). One controller can be connected to only one slot on 2530/2430/3530/3430.

The current code needs a little bit of updating to support the second
MMC controller on the 2430.  Below is a rough patch with the changes
that get it working for me (on a custom board), but it is not based
off of the git repo so it's not likely to apply directly.  Hopefully
it will be helpful as a reference though.

Cheers,
Seth


diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -230,7 +230,17 @@ static inline void omap_init_kp(void) {}
 #define	OMAP_MMC1_BASE		0xfffb7800
 #define OMAP_MMC1_INT		INT_MMC
 #endif
+
+#if defined(CONFIG_ARCH_OMAP16XX)
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+#define OMAP_MMC2_INT		INT_1610_MMC2
+#elif defined CONFIG_ARCH_OMAP2430
+#define OMAP_MMC2_BASE		0x480b4000
+#define OMAP_MMC2_INT		INT_24XX_MMC2_IRQ
+#endif
+
+#define OMAP_MMC2_SUPPORT \
+	(defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430))
 
 #if	defined(CONFIG_ARCH_OMAP2430)
 static struct omap_mmc_platform_data mmc1_conf;
@@ -263,9 +273,13 @@ static struct platform_device mmc_omap_d
 	.resource	= mmc1_resources,
 };
 
-#ifdef	CONFIG_ARCH_OMAP16XX
-
+#if	OMAP_MMC2_SUPPORT
+
+#if	defined(CONFIG_ARCH_OMAP2430)
+static struct omap_mmc_platform_data mmc2_conf;
+#else
 static struct omap_mmc_conf mmc2_conf;
+#endif
 
 static u64 mmc2_dmamask = 0xffffffff;
 
@@ -277,7 +291,7 @@ static struct resource mmc2_resources[] 
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= INT_1610_MMC2,
+		.start		= OMAP_MMC2_INT,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -304,6 +318,9 @@ static void __init omap_init_mmc(void)
 	if (cpu_is_omap243x()) {
 		if (mmc1_conf.enabled){
 			(void) platform_device_register(&mmc_omap_device1);
+		}
+		if (mmc2_conf.enabled){
+			(void) platform_device_register(&mmc_omap_device2);
 		}
 		return;
 	}
@@ -405,7 +422,7 @@ void omap_set_mmc_info(int host, const s
 	case 1:
 		mmc1_conf = *info;
 		break;
-#ifdef	CONFIG_ARCH_OMAP16XX
+#ifdef	OMAP_MMC2_SUPPORT
 	case 2:
 		mmc2_conf = *info;
 		break;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -409,7 +409,10 @@ static int omap_mmc_switch_opcond(struct
 			OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
 	reg_val = OMAP_HSMMC_READ(host->base, HCTL);
 
-	if (((1 << vdd) == MMC_VDD_33_34) || ((1 << vdd) == MMC_VDD_33_34)) {
+	/* Only MMC1 supports 3.0V */
+	if (host->id == OMAP_MMC1_DEVID &&
+			(((1 << vdd) == MMC_VDD_33_34) ||
+			 ((1 << vdd) == MMC_VDD_33_34))) {
 		host->initstr = 0;
 		reg_val |= SDVS30;
 	}
@@ -713,6 +716,7 @@ static int omap_mmc_probe(struct platfor
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	int ret = 0, irq;
+	u32 hctl, capa;
 
 	printk("\n MMC probe entered \n");
 	if (pdata == NULL) {
@@ -800,11 +804,20 @@ static int omap_mmc_probe(struct platfor
 	if (pdata->wire4)
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
-
-	OMAP_HSMMC_WRITE(host->base, CAPA,OMAP_HSMMC_READ(host->base,
-							CAPA) | VS30 | VS18);
+			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
+
+	OMAP_HSMMC_WRITE(host->base, CAPA,
+			OMAP_HSMMC_READ(host->base, CAPA) | capa);
 
 	/* Set the controller to AUTO IDLE mode */
 	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
