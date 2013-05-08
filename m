From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4+: omap2plus_defconfig: Enable audio via
 TWL6040 as module
Date: Wed, 8 May 2013 15:08:42 -0700
Message-ID: <20130508220841.GI32546@atomide.com>
References: <1365584880-25810-1-git-send-email-peter.ujfalusi@ti.com>
 <acf32629312b1315da0d04598a757673@mail.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36201 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab3EHWIp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 18:08:45 -0400
Content-Disposition: inline
In-Reply-To: <acf32629312b1315da0d04598a757673@mail.kapsi.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <oku@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Jyri Sarha <jsarha@ti.com>

* Jyri Sarha <oku@iki.fi> [130412 05:19]:
> On Wed, 10 Apr 2013 11:08:00 +0200, Peter Ujfalusi <peter.ujfalusi@ti.com>
> wrote:
> > Boards supported upstream all use TWL6040 as audio codec, enable the
> common
> > ASoC machine driver by default for them.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Jyri Sarha <jsarha@ti.com>
> 
> Brings a working PCM for TWL6040 trough McPDM legacy port on top of
> 8.3-rc3 for my Blaze and Panda.

Thanks applying into omap-for-v3.10/fixes.

Regards,

Tony

> > ---
> >  arch/arm/configs/omap2plus_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/configs/omap2plus_defconfig
> > b/arch/arm/configs/omap2plus_defconfig
> > index bd07864..eea501c 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -152,6 +152,7 @@ CONFIG_OMAP_WATCHDOG=y
> >  CONFIG_TWL4030_WATCHDOG=y
> >  CONFIG_MFD_TPS65217=y
> >  CONFIG_MFD_TPS65910=y
> > +CONFIG_TWL6040_CORE=y
> >  CONFIG_REGULATOR_TWL4030=y
> >  CONFIG_REGULATOR_TPS65023=y
> >  CONFIG_REGULATOR_TPS6507X=y
> > @@ -194,6 +195,7 @@ CONFIG_SND_USB_AUDIO=m
> >  CONFIG_SND_SOC=m
> >  CONFIG_SND_OMAP_SOC=m
> >  CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
> > +CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
> >  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
> >  CONFIG_USB=y
> >  CONFIG_USB_DEBUG=y
