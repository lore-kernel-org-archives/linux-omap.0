From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: enable Bluetooth on the PandaBoard
Date: Thu, 23 Feb 2012 11:00:26 -0800
Message-ID: <20120223190026.GA18185@atomide.com>
References: <1329990318-4575-1-git-send-email-mgherzan@gmail.com>
 <201202231512.57684.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61896 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2BWTA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 14:00:29 -0500
Content-Disposition: inline
In-Reply-To: <201202231512.57684.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mircea Gherzan <mgherzan@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120223 06:41]:
> On Thursday 23 February 2012, Mircea Gherzan wrote:
> > The PandaBoard features a Texas Instruments WiLink7 Bluetooth
> > chip, supported by the "btwilink" driver.
> > 
> > Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> 
> No objections to the patch, but please send it to the maintainer,
> not to me. You also misspelled the address of the linux-omap
> list, so Tony probably didn't get it there either.

Thanks, seeing the repost now. Will queue it.

Tony
 
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > index 28fc271..b1d74d6 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -91,9 +91,15 @@ static struct platform_device leds_gpio = {
> >  	},
> >  };
> >  
> > +static struct platform_device btwilink_device = {
> > +	.name	= "btwilink",
> > +	.id	= -1,
> > +};
> > +
> >  static struct platform_device *panda_devices[] __initdata = {
> >  	&leds_gpio,
> >  	&wl1271_device,
> > +	&btwilink_device,
> >  };
> >  
> >  static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
> > -- 
> > 1.7.9.1
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
