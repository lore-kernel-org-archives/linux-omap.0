From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Sat, 10 Mar 2012 07:07:17 +0200
Message-ID: <1331356037.3164.31.camel@cumari>
References: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
	 <20120309183150.GH12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50105 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750718Ab2CJFHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Mar 2012 00:07:21 -0500
Received: by mail-lpp01m010-f48.google.com with SMTP id u2so2374862lag.7
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 21:07:20 -0800 (PST)
In-Reply-To: <20120309183150.GH12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mircea Gherzan <mgherzan@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2012-03-09 at 10:31 -0800, Tony Lindgren wrote: 
> Hi Luca,

Hi Tony,


> * Mircea Gherzan <mgherzan@gmail.com> [120306 14:23]:
> > The "uim" deamon requires sysfs entries that are filled in using
> > this platform data.
> > 
> > Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> > ---
> >  arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
> >  include/linux/ti_wilink_st.h           |    2 ++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > index b1d74d6..339e781 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/i2c/twl.h>
> >  #include <linux/regulator/machine.h>
> >  #include <linux/regulator/fixed.h>
> > +#include <linux/ti_wilink_st.h>
> >  #include <linux/wl12xx.h>
> >  
> >  #include <mach/hardware.h>
> > @@ -56,12 +57,21 @@
> >  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
> >  
> >  /* wl127x BT, FM, GPS connectivity chip */
> > -static int wl1271_gpios[] = {46, -1, -1};
> > +static struct ti_st_plat_data wilink_platform_data = {
> > +	.nshutdown_gpio	= 46,
> > +	.dev_name	= "/dev/ttyO1",
> > +	.flow_cntrl	= 1,
> > +	.baud_rate	= 3000000,
> > +	.chip_enable	= NULL,
> > +	.suspend	= NULL,
> > +	.resume		= NULL,
> > +};
> > +
> >  static struct platform_device wl1271_device = {
> >  	.name	= "kim",
> >  	.id	= -1,
> >  	.dev	= {
> > -		.platform_data	= &wl1271_gpios,
> > +		.platform_data	= &wilink_platform_data,
> >  	},
> >  };
> >  
> > diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
> > index 2ef4385..3ca0269 100644
> > --- a/include/linux/ti_wilink_st.h
> > +++ b/include/linux/ti_wilink_st.h
> > @@ -25,6 +25,8 @@
> >  #ifndef TI_WILINK_ST_H
> >  #define TI_WILINK_ST_H
> >  
> > +#include <linux/skbuff.h>
> > +
> >  /**
> >   * enum proto-type - The protocol on WiLink chips which share a
> >   *	common physical interface like UART.
> > -- 
> 
> Just checking.. Can you please take a look at this patch
> and confirm that this is how things are supposed to be done?
> 
> To me passing some third driver's dev_name in pdata seems
> pretty weird.. But then again maybe I just don't know how
> this is supposed to work.

This looks pretty weird to me too.  The "/dev/ttyO1" thing doesn't look
right.  But I don't really know how this works either, because this is
the BT/FM/GPS part of the wl12xx chip.  And, to be honest, I don't know
anything about it.  I only know about the wifi part of it. :\

-- 
Cheers,
Luca.

