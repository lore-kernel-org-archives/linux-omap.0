From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/4] drivers: usb: start using the control module
 driver
Date: Fri, 1 Feb 2013 11:14:24 -0800
Message-ID: <20130201191424.GQ22517@atomide.com>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-5-git-send-email-kishon@ti.com>
 <20130125102700.GO15886@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130125102700.GO15886@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux@arm.linux.org.uk, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [130125 02:30]:
> Hi,
> 
> On Fri, Jan 25, 2013 at 03:54:00PM +0530, Kishon Vijay Abraham I wrote:
> > Start using the control module driver for powering on the PHY and for
> > writing to the mailbox instead of writing to the control module
> > registers on their own.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ++
> >  Documentation/devicetree/bindings/usb/usb-phy.txt  |    7 +-
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 ----
> 
> I'm taking this patch but I'm leaving out the omap_hwmod_44xx_data.c
> change just to kill dependency. Can you send that single change as a
> separate patch which Tony can queue ?

For the USB patches, please also leave out patches touching
arch/arm/mach-omap2/devices.c. Those are almost guaranteed to
cause pointless merge conflicts with other branches.

I suggest you set up few immutable branches:

1. Minimal platform_data changes for all your USB changes

This should contain include/linux/platform_data changes and
changes to arch/arm/*omap* so me and Paul can merge it in too
to avoid merge conflicts.

2. The rest of the driver/usb changes

This can then be based on #1 branch above.

3. Changes for the .dts files for Benoit

These can be queued separately from #1 and #2 above.

Regards,

Tony
