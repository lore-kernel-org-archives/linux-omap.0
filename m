From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 17/17] ARM: dts: omap4: Use "syscon-otghs" instead of
 "ctrl-module" in USB node
Date: Wed, 24 Jun 2015 04:46:03 -0700
Message-ID: <20150624114602.GE4156@atomide.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-18-git-send-email-kishon@ti.com>
 <20150624104116.GC4156@atomide.com>
 <558A92A5.5070506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <558A92A5.5070506-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150624 04:23]:
> On Wednesday 24 June 2015 04:11 PM, Tony Lindgren wrote:
> >* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150623 05:02]:
> >>--- a/arch/arm/boot/dts/omap4.dtsi
> >>+++ b/arch/arm/boot/dts/omap4.dtsi
> >>@@ -852,12 +852,6 @@
> >>  			};
> >>  		};
> >>
> >>-		omap_control_usbotg: control-phy@4a00233c {
> >>-			compatible = "ti,control-phy-otghs";
> >>-			reg = <0x4a00233c 0x4>;
> >>-			reg-names = "otghs_control";
> >>-		};
> >>-
> >>  		usb_otg_hs: usb_otg_hs@4a0ab000 {
> >>  			compatible = "ti,omap4-musb";
> >>  			reg = <0x4a0ab000 0x7ff>;
> >>@@ -870,7 +864,7 @@
> >>  			multipoint = <1>;
> >>  			num-eps = <16>;
> >>  			ram-bits = <12>;
> >>-			ctrl-module = <&omap_control_usbotg>;
> >>+			syscon-otghs = <&scm_conf 0x33c>;
> >>  		};
> >>
> >>  		aes: aes@4b501000 {
> >
> >We should still keep a separate entry for the phy in the dtsi
> >files. And the phy should be a child of the scm_conf area in the
> >dtsi file.
> >
> >This is because the scm and usb_otg_hs are separate devices and
> >can be clocked separately. So the phy driver needs to be a
> >separate driver to avoid spaghetti code and issues with clocking.
> 
> AFAIK SCM is clocked by L4CFG_L4_GICLK which is either free running or is
> managed automatically by the HW i.e gated when there is no access to the
> CTRL_MODULE_CORE registers.

The point is they are separate devices on the interconnect. And we
don't want to add dependencies between separate devices. And there
is nothing stopping us from starting to idle the SCM module.
 
> Having a separate control-PHY driver only to do a regmap update to SCM is
> unnecessary IMHO.

Not true. The phy driver can be generic and used by multiple platforms.

And the phy driver should be capable of idling the phy separately
independent of the USB module. And the phy driver should be able to
tell the system things like ID pin status, VBUS status and so on.

So to summarize, we are _not_ going to start tinkering with the sycon
registers directly from random device drivers in a separate IO space.

Anything using the syscon registers must implement a driver for some
Linux generic framework such as phy, clock, or regulator framework.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
