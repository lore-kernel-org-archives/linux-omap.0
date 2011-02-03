From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 1/2] omap3sdp: Fix regulator mapping for ads7846 TS controller
Date: Thu, 3 Feb 2011 17:34:40 +0530
Message-ID: <1dd409cd6dfe29ecf4459c6defc2bd8a@mail.gmail.com>
References: <1296732705-12818-1-git-send-email-rnayak@ti.com>
 <1296732705-12818-2-git-send-email-rnayak@ti.com> <20110203115613.GK23561@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50311 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756289Ab1BCMEm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 07:04:42 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so1135226fxm.30
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 04:04:41 -0800 (PST)
In-Reply-To: <20110203115613.GK23561@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Thursday, February 03, 2011 5:26 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; tony@atomide.com;
linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] omap3sdp: Fix regulator mapping for ads7846 TS
controller
>
> Hi,
>
> On Thu, Feb 03, 2011 at 05:01:44PM +0530, Rajendra Nayak wrote:
> > diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
> > index d4e41ef..dcdc718 100644
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -427,6 +427,10 @@ static struct twl4030_madc_platform_data
sdp3430_madc_data = {
> >  	.irq_line	= 1,
> >  };
> >
> > +/* ads7846 on SPI */
> > +static struct regulator_consumer_supply sdp3430_vaux3_supply =
> > +	REGULATOR_SUPPLY("vcc", "spi1.0");
> > +
> >  /*
> >   * Apply all the fixed voltages since most versions of U-Boot
> >   * don't bother with that initialization.
> > @@ -469,6 +473,8 @@ static struct regulator_init_data sdp3430_vaux3 =
{
> >  		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> >  					| REGULATOR_CHANGE_STATUS,
> >  	},
> > +	.num_consumer_supplies		= 1,
> > +	.consumer_supplies		= &sdp3430_vaux3_supply,
> >  };
>
> this is not the expected way of using the regulator framework, you
> should have:
>
> static struct regulator_consumer_supply sdp3430_vaux3_supplies[] =
> 	{ REGULATOR_SUPPLY("vcc", "spi1.0"), },
> };
>
> ...
>
> .num_consume_supplies	= ARRAY_SIZE(sdp3430_vaux3_supplies),
> .consumer_supplies	= sdp3430_vaux3_supplies,

Yup, makes sense. Will fix that and repost.

>
> or something similar. (completely untested though).
>
> --
> balbi
