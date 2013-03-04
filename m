From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Clear GPMC bits when applying new setting
Date: Mon, 4 Mar 2013 09:37:06 -0800
Message-ID: <20130304173706.GL11806@atomide.com>
References: <51126586.9030308@mimc.co.uk>
 <51126B2C.6080009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:25880 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757390Ab3CDRhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 12:37:11 -0500
Content-Disposition: inline
In-Reply-To: <51126B2C.6080009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Jon Hunter <jon-hunter@ti.com> [130206 06:43]:
> 
> On 02/06/2013 08:15 AM, Mark Jackson wrote:
> > When setting the GPMC device type, make sure any previous
> > bits are cleared down, before applying the new setting.
> > 
> > Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> > ---
> >  arch/arm/mach-omap2/gpmc.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > index 1adb2d4..026e786 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -613,6 +613,10 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
> > 
> >  	case GPMC_CONFIG_DEV_TYPE:
> >  		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> > +		/* clear 3 target bits */
> > +		regval &= ~(GPMC_CONFIG1_DEVICETYPE(3) |
> > +			    GPMC_CONFIG1_MUXADDDATA);
> 
> MUXADDDATA is actually a 2-bit field on current devices (OMAP4+ and
> AM335x). For OMAP2/3 devices it was only a one bit field. So it may be
> worth clearing both bits for all devices. For OMAP2 devices bit 8 is
> reserved but the TRM says to writes a 0, so clearing bit 8 on OMAP2/3
> devices should not be a problem. In fact bit 8 should read as 0 on OMAP2/3.
> 
> > +		/* set the proper value */
> >  		regval |= GPMC_CONFIG1_DEVICETYPE(wval);
> >  		if (wval == GPMC_DEVICETYPE_NOR)
> >  			regval |= GPMC_CONFIG1_MUXADDDATA;
> > 
> 
> Otherwise ...
> 
> Acked-by: Jon Hunter <jon-hunter@ti.com>

Mark, can you please repost this patch with Jon's comment addressed?

Thanks,

Tony
