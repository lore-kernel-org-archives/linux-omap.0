From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Sat, 24 Nov 2018 19:29:28 +0000
Message-ID: <20181124192928.GR6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
 <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
 <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
 <20181124001740.GI12912@darkstar.musicnaut.iki.fi>
 <20181124174823.GQ6920@n2100.armlinux.org.uk>
 <20181124190648.GB3416@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181124190648.GB3416@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Greg KH <greg@kroah.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 24, 2018 at 09:06:48PM +0200, Aaro Koskinen wrote:
> Hello,
> 
> On Sat, Nov 24, 2018 at 05:48:23PM +0000, Russell King - ARM Linux wrote:
> > Hmm, there's more questionable stuff in this driver, and the gadget
> > layer.
> 
> [...]
> 
> > So, whatever way I look at this, the code in the removal path both
> > in omap_udc and the gadget removal code higher up looks very wrong
> > and broken to me.
> 
> Yes, week ago I saw omap_udc crashing on both probe failure and
> module removal and sent some fixes for the most obvious failures (see
> https://marc.info/?l=linux-usb&m=154258778316932&w=2).

The effect of your patch is basically to replace the release function
with a no-op function.

> Is there any good driver that uses usb_add_gadget_udc_release() correctly?
> Looking at fsl_qe_udc.c and fsl_udc_core.c they should also crash if
> usb_add_gadget_udc_release() fails.

usb_add_gadget_udc_release() itself will call the release function
automatically on error.

The release function should _also_ be called when usb_del_gadget_udc()
is called (and would be guaranteed if the memset() is removed.)

So, moving the cleanup in the remove path into the release function
would solve the problem with omap_udc, and removing the memset()
would solve the problem with the core code.

It does leave a problem if the omap_udc module is removed - the
release function _could_ be called after the module has been removed
which would lead to an oops.  That's presumably why there's a
completion.  One solution to that would be to move the assignment
of udc->done before the call to usb_del_gadget_udc().

However, using a completion for something like this tends to be
frowned upon, but I don't see any other way to ensure correctness
here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
