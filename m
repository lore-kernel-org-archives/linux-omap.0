From: Paul Walmsley <paul@pwsan.com>
Subject: Re: MMC3 Overo
Date: Sun, 2 Aug 2009 19:20:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908021919320.19529@utopia.booyaka.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com> <bb2708720907301223h616eb215gb4aea1df8e1d578e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-920215221-1249262445=:19529"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44683 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZHCBUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Aug 2009 21:20:45 -0400
In-Reply-To: <bb2708720907301223h616eb215gb4aea1df8e1d578e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-920215221-1249262445=:19529
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello John,

you are using the PM branch, correct?

On Thu, 30 Jul 2009, John Sarman wrote:

> On Thu, Jul 30, 2009 at 11:49 AM, John Sarman<johnsarman@gmail.com> wrote=
:
> > I am trying to use mmc3 on the Overo Gumstix board with no luck. =A0I
> > have patched the kernel with the latest changes and have yet to see a
> > clk pulse, both before and after the patches.
> After adding some debugging printks, I have determined the mmc3 fails
> getting IRQ
> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> REQUEST IRQ =3D 83 HOST =3D -812068416
> mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
> REQUEST IRQ =3D 86 HOST =3D -812067392
> mmci-omap-hs mmci-omap-hs.2: Failed to get debounce clock
> REQUEST IRQ =3D 83 HOST =3D -812066368
> mmci-omap-hs mmci-omap-hs.2: Unable to grab HSMMC IRQ
> mmci-omap-hs mmci-omap-hs.2: Probe Failed
> mmci-omap-hs: probe of mmci-omap-hs.2 failed with error -16
>=20
> For some reason mmc1 and mmc3 ask for the same interrupt 83 ???
>=20
> Why would this be assigned the same value?

Developer error.  Does this patch fix it for you?


- Paul


From=20baca68c40ec3b391cdbfc0fb20ac5092b4ab7025 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 3 Aug 2009 04:18:45 +0300
Subject: [PATCH] OMAP3 hwmod: fix MMC3 IRQ

The MMC3 IRQ is incorrect in mach-omap2/omap_hwmod_34xx.h, which causes
MMC3 init to fail.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/om=
ap_hwmod_34xx.h
index 29a2d60..56215bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -470,7 +470,7 @@ static struct omap_hwmod omap34xx_mmc2_hwmod =3D {
 static struct mmc_dev_attr mmc3_dev_attr;
=20
 static u8 mmc3_mpu_irqs[] =3D {
-=09INT_24XX_MMC_IRQ,
+=09INT_34XX_MMC3_IRQ,
 };
=20
 static struct omap_hwmod_dma_info mmc3_sdma_chs[] =3D {
--=20
1.6.3.GIT

--155748971-920215221-1249262445=:19529--
