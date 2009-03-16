From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/12] ARM: OMAP3: mmc-twl4030 add MMC3 support, v2
Date: Mon, 16 Mar 2009 10:56:23 -0700
Message-ID: <20090316175622.GE19229@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211000.16425.62205.stgit@localhost> <20090315160426.GE10786@n2100.arm.linux.org.uk> <6ed0b2680903151027q10a0717fvf73234b2836b0064@mail.gmail.com> <20090315174039.GB13220@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J+eNKFoVC4T1DV3f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64994 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603AbZCPR40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 13:56:26 -0400
Content-Disposition: inline
In-Reply-To: <20090315174039.GB13220@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090315 10:40]:
> On Sun, Mar 15, 2009 at 07:27:32PM +0200, Grazvydas Ignotas wrote:
> > On Sun, Mar 15, 2009 at 6:04 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Tue, Mar 10, 2009 at 02:10:00PM -0700, Tony Lindgren wrote:
> > >> ... Array size for hsmmc[] is specified
> > >> because hsmmc[2].name is needed for MMC3 name.
> > >
> > > I see nothing in this patch which requires that.
> > 
> > Right, but there is already some code in twl4030_mmc_init() of mmc-twl4030.c:
> > 
> >   struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
> > <snip>
> >   sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
> > 
> > .. which basically writes to hsmmc[2].name for MMC3.
> 
> So, it's nothing really to do with hsmmc[2].name being required, it's
> more a case of needing to have the 3rd MMC interface included.  The
> comment in the commit is *really* misleading.

Here's this one updated for the comments.

Tony

--J+eNKFoVC4T1DV3f
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="hsmmc-add-mmc3-v2.patch"

>From 9c51c8f60fe2e33989f2c87ff9829a7eea89240e Mon Sep 17 00:00:00 2001
From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 16 Mar 2009 10:43:06 -0700
Subject: [PATCH] ARM: OMAP3: mmc-twl4030 add MMC3 support, v2

Device connected to MMC3 is assumed to be self-powered, so
set_power() function is empty. It can't be omited because
host driver requires it.

Array size for hsmmc[] is specified to allocate to allocate
an instance for the third MMC controller.

Also fix a leak which happens if invalid controller id
is passed.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7a46a65..6e17180 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -55,6 +55,12 @@ static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
 		.ext_clock	= 1,
 		.transceiver	= true,
 	},
+	{
+		.mmc		= 3,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
 	{}	/* Terminator */
 };
 
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index c67078d..d9fad8d 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -62,7 +62,7 @@ static struct twl_mmc_controller {
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
 	char		name[HSMMC_NAME_LEN + 1];
-} hsmmc[] = {
+} hsmmc[OMAP34XX_NR_MMC] = {
 	{
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
 		.twl_mmc_dedicated		= VMMC1_DEDICATED,
@@ -347,6 +347,16 @@ static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vd
 	return ret;
 }
 
+static int twl_mmc3_set_power(struct device *dev, int slot, int power_on,
+		int vdd)
+{
+	/*
+	 * Assume MMC3 has self-powered device connected, for example on-board
+	 * chip with external power source.
+	 */
+	return 0;
+}
+
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
 
 void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
@@ -415,7 +425,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 
 		/* NOTE:  we assume OMAP's MMC1 and MMC2 use
 		 * the TWL4030's VMMC1 and VMMC2, respectively;
-		 * and that OMAP's MMC3 isn't used.
+		 * and that MMC3 device has it's own power source.
 		 */
 
 		switch (c->mmc) {
@@ -430,8 +440,13 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			else
 				mmc->slots[0].ocr_mask = MMC_VDD_165_195;
 			break;
+		case 3:
+			mmc->slots[0].set_power = twl_mmc3_set_power;
+			mmc->slots[0].ocr_mask = MMC_VDD_165_195;
+			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
+			kfree(mmc);
 			continue;
 		}
 		hsmmc_data[c->mmc - 1] = mmc;

--J+eNKFoVC4T1DV3f--
