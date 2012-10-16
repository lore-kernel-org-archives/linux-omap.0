From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: UART: fix console UART mismatched runtime
 PM status
Date: Tue, 16 Oct 2012 14:18:29 -0700
Message-ID: <20121016211828.GL15569@atomide.com>
References: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
 <20121016102517.GD21801@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52860 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753939Ab2JPVSf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 17:18:35 -0400
Content-Disposition: inline
In-Reply-To: <20121016102517.GD21801@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Sourav Poddar <sourav.poddar@ti.com>

* Felipe Balbi <balbi@ti.com> [121016 03:32]:
> Hi,
> 
> On Mon, Oct 15, 2012 at 04:49:58PM -0700, Kevin Hilman wrote:
> > From: Kevin Hilman <khilman@ti.com>
> > 
> > The runtime PM framework assumes that the hardware state of devices
> > when initialized is disabled.  For all omap_devices, we idle/disable
> > device by default.  However, the console uart uses a "no idle" option
> > during omap_device init in order to allow earlyprintk usage to work
> > seamlessly during boot.
> > 
> > Because the hardware is left partially enabled after init (whatever
> > the bootloader settings were), the omap_device should later be fully
> > initialized (including mux) and the runtime PM framework should be
> > told that the device is active, and not disabled so that the hardware
> > state is in sync with runtime PM state.
> > 
> > To fix, after the device has been created/registered, call
> > omap_device_enable() to finialize init and use pm_runtime_set_active()
> > to tell the runtime PM core the device is enabled.
> > 
> > Tested on 2420/n810, 3530/Overo, 3530/Beagle, 3730/OveroSTORM,
> > 3730/Beagle-xM, 4460/PandaES.
> > 
> > Reported-by: Paul Walmsley <paul@pwsan.com>
> > Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Sourav Poddar <sourav.poddar@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> > Applies against v3.7-rc1.
> > Fix targetted for v3.7.
> > 
> > I'm still not entirely sure why this has worked up to now on OMAP3/4
> > but not on OMAP2.  Even so, this fix is needed for all platforms to
> > ensure matching hardware state and runtime PM state.
> > 
> >  arch/arm/mach-omap2/serial.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index 0405c81..37b5dbe 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -327,6 +327,11 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
> >  	if ((console_uart_id == bdata->id) && no_console_suspend)
> >  		omap_device_disable_idle_on_suspend(pdev);
> >  
> > +	if (console_uart_id == bdata->id) {
> > +		omap_device_enable(pdev);
> > +		pm_runtime_set_active(&pdev->dev);
> > +	}
> > +
> >  	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
> >  
> >  	oh->dev_attr = uart;
> 
> looks good to me. Even took care of doing that only for the console
> UART.

Applying into omap-for-v3.7-rc1/fixes-take3.

Regards,

Tony
