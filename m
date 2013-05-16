From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+
 boards
Date: Thu, 16 May 2013 10:46:08 -0700
Message-ID: <20130516174608.GC5600@atomide.com>
References: <20130511023557.GB28602@atomide.com>
 <5193296D.5040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5193296D.5040001-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [130514 23:27]:
> On Saturday 11 May 2013 08:05 AM, Tony Lindgren wrote:
> >Commit ad871c10 (ARM: dts: OMAP: Add usb_otg and glue data to
> >OMAP3+ boards) added support for MUSB on omap3 for device tree,
> >but added the interrupts the wrong way probably as they were
> >copied from the omap4.dtsi file. On omap3 we have TI specific
> >interrupt controller, not GIC.
> >
> >Fix this by specifying the interrupt following the TI INTC
> >binding.
> >
> >Without this fix MUSB won't work as it is trying to use
> >irq0 instead of irq92.
> >
> >Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Tested in beagleboard-xm
> 
> Tested-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

Oops thanks, sorry I already pushed it out into omap-for-v3.10/dt-fixes
before noticing your tested-by.

Regards,

Tony

> >--- a/arch/arm/boot/dts/omap3.dtsi
> >+++ b/arch/arm/boot/dts/omap3.dtsi
> >@@ -516,7 +516,7 @@
> >  		usb_otg_hs: usb_otg_hs@480ab000 {
> >  			compatible = "ti,omap3-musb";
> >  			reg = <0x480ab000 0x1000>;
> >-			interrupts = <0 92 0x4>, <0 93 0x4>;
> >+			interrupts = <92>, <93>;
> >  			interrupt-names = "mc", "dma";
> >  			ti,hwmods = "usb_otg_hs";
> >  			multipoint = <1>;
> >
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
