From: Paul Walmsley <paul@pwsan.com>
Subject: Re: MMC3 Overo
Date: Mon, 3 Aug 2009 05:11:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908030510420.17502@utopia.booyaka.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>  <bb2708720907301223h616eb215gb4aea1df8e1d578e@mail.gmail.com>  <alpine.DEB.2.00.0908021919320.19529@utopia.booyaka.com> <bb2708720908030333x1c9521b6ua76122b0f80e1fdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1283566761-1249297894=:17502"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46883 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574AbZHCLLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 07:11:34 -0400
In-Reply-To: <bb2708720908030333x1c9521b6ua76122b0f80e1fdc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1283566761-1249297894=:17502
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 3 Aug 2009, John Sarman wrote:

> On Sun, Aug 2, 2009 at 9:20 PM, Paul Walmsley<paul@pwsan.com> wrote:

> > From: Paul Walmsley <paul@pwsan.com>
> > Date: Mon, 3 Aug 2009 04:18:45 +0300
> > Subject: [PATCH] OMAP3 hwmod: fix MMC3 IRQ
> >
> > The MMC3 IRQ is incorrect in mach-omap2/omap_hwmod_34xx.h, which causes
> > MMC3 init to fail.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> > =A0arch/arm/mach-omap2/omap_hwmod_34xx.h | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap=
2/omap_hwmod_34xx.h
> > index 29a2d60..56215bd 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
> > +++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
> > @@ -470,7 +470,7 @@ static struct omap_hwmod omap34xx_mmc2_hwmod =3D {
> > =A0static struct mmc_dev_attr mmc3_dev_attr;
> >
> > =A0static u8 mmc3_mpu_irqs[] =3D {
> > - =A0 =A0 =A0 INT_24XX_MMC_IRQ,
> > + =A0 =A0 =A0 INT_34XX_MMC3_IRQ,
> > =A0};
> >
> > =A0static struct omap_hwmod_dma_info mmc3_sdma_chs[] =3D {
> > --
> > 1.6.3.GIT
> >
> Thanks for the patch, I will apply that and keep on testing.

I'm afraid that the patch will only be useful on a recent version of=20
Kevin's PM branch.

- Paul
--155748971-1283566761-1249297894=:17502--
