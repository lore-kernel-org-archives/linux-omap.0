From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Tue, 19 Oct 2010 09:23:48 -0700
Message-ID: <20101019162348.GA28899@kroah.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
 <1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
 <20101019155219.GI4589@kroah.com>
 <4CBDC361.70507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CBDC361.70507-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 09:42:17PM +0530, Anand Gadiyar wrote:
> On 10/19/2010 9:22 PM, Greg KH wrote:
> >On Tue, Oct 19, 2010 at 01:03:28PM +0300, Felipe Contreras wrote:
> >>Add missing dependencies, and remove redundant ones, and select sensible
> >>defaults.
> >>
> >>Signed-off-by: Felipe Contreras<felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>---
> >>  drivers/mfd/Kconfig        |    3 ++-
> >>  drivers/regulator/Kconfig  |    1 +
> >>  drivers/usb/gadget/Kconfig |    3 +--
> >>  drivers/usb/musb/Kconfig   |    6 ++----
> >>  drivers/usb/otg/Kconfig    |    2 ++
> >>  5 files changed, 8 insertions(+), 7 deletions(-)
> >>
> >>diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >>index db51ea1..0bbaf01 100644
> >>--- a/drivers/mfd/Kconfig
> >>+++ b/drivers/mfd/Kconfig
> >>@@ -156,6 +156,7 @@ config MENELAUS
> >>  config TWL4030_CORE
> >>  	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> >>  	depends on I2C=y&&  GENERIC_HARDIRQS
> >>+	default y if ARCH_OMAP3 || ARCH_OMAP4
> >
> >Sorry, but unless the driver is somehow required to keep the board from
> >going up in a puff of smoke, a default should NEVER be y.
> >
> >Because of that, I can't take this patch.
> >
> 
> This is the driver for the Power-management IC on the board. Without
> this IC being correctly configured, I'm guessing a lot of things
> will fail. Not so sure if anything will go up in smoke (sounds
> unlikely), or if the kernel will fail to boot - I'll check quickly -
> but for this one specific instance, I think it's reasonable to
> accept a default y.

Sorry, but no, I'm not going to take it for the reasons stated above.

> Kevin/Tony can probably confirm.
> 
> Greg,
> 
> For other instances of unnecessary "default y", do you think they
> should be removed?

I wouldn't worry about trivial things like that, the damage is already
done.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
