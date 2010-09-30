From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 30 Sep 2010 11:48:41 -0700
Message-ID: <20100930184841.GL3117@atomide.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
 <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
 <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
 <AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
 <20100924225254.GK4211@atomide.com>
 <AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53895 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab0I3Ssp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:48:45 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100930 11:34]:
> >
> > Looks like also board-sx1-mmc.c and board-h[23]-mmc.c have the
> > same spotty voltage range.
> >
> > Cory, care to do a patch that fixes it for all of them?
> >
>=20
> Yeah, I can do that.  I'll resubmit this patch too with the fixed up =
ranges.

Turns out I already did it :) Care to test/ack this one?

Tony

=46rom: Tony Lindgren <tony@atomide.com>
Date: Thu, 30 Sep 2010 11:40:56 -0700
Subject: [PATCH] omap: Fix spotty MMC voltages

As noted by Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>, the voltages =
should
cover the supported voltage range instead of missing some values
within the range.

Reported-by: Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/b=
oard-h2-mmc.c
index b30c499..50d9032 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -58,7 +58,8 @@ static struct omap_mmc_platform_data mmc1_data =3D {
 	.dma_mask			=3D 0xffffffff,
 	.slots[0]       =3D {
 		.set_power              =3D mmc_set_power,
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
+		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_29_30 |
+					  MMC_VDD_30_31 | MMC_VDD_31_32 |
 					  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 	},
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/b=
oard-h3-mmc.c
index 54b0f06..9f073bf 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -40,7 +40,8 @@ static struct omap_mmc_platform_data mmc1_data =3D {
 	.dma_mask			=3D 0xffffffff,
 	.slots[0]       =3D {
 		.set_power              =3D mmc_set_power,
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
+		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_29_30 |
+					  MMC_VDD_30_31 | MMC_VDD_31_32 |
 					  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 	},
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap=
1/board-htcherald.c
index 7ea75c1..909fdeb 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -410,7 +410,8 @@ static struct omap_mmc_platform_data htc_mmc1_data =
=3D {
 	.nr_slots                       =3D 1,
 	.switch_slot                    =3D NULL,
 	.slots[0]       =3D {
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
+		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_29_30 |
+					  MMC_VDD_30_31 | MMC_VDD_31_32 |
 					  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 		.nomux                  =3D 1,
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/=
board-sx1-mmc.c
index 5b33ae8..be5a365 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -44,7 +44,8 @@ static struct omap_mmc_platform_data mmc1_data =3D {
 	.nr_slots                       =3D 1,
 	.slots[0]       =3D {
 		.set_power              =3D mmc_set_power,
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
+		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_29_30 |
+					  MMC_VDD_30_31 | MMC_VDD_31_32 |
 					  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 	},
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/boa=
rd-n8x0.c
index 7a93bd5..abd7e77 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -493,7 +493,8 @@ static struct omap_mmc_platform_data mmc1_data =3D =
{
 		.set_bus_mode		=3D n8x0_mmc_set_bus_mode,
 		.get_cover_state	=3D n8x0_mmc_get_cover_state,
 		.ocr_mask		=3D MMC_VDD_165_195 | MMC_VDD_30_31 |
-						MMC_VDD_32_33   | MMC_VDD_33_34,
+						MMC_VDD_31_32 | MMC_VDD_32_33 |
+						MMC_VDD_33_34,
 		.name			=3D "internal",
 	},
 	.slots[1] =3D {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
