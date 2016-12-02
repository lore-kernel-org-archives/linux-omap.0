From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the device tree
Date: Fri, 02 Dec 2016 20:39:54 +0200
Message-ID: <2173679.ibqUs8Vreg@avalon>
References: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com> <4245212.aFfvVGINdT@avalon> <20161202165323.GC4705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161202165323.GC4705-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Friday 02 Dec 2016 08:53:24 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161202 05:38]:
> > On Thursday 01 Dec 2016 17:18:08 Tony Lindgren wrote:
> >> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161130 09:58]:
> >>>  &usbhsehci {
> >>>  
> >>>  	phys = <0 &hsusb2_phy>;
> >>> 
> >>> +
> >>> +	#address-cells = <1>;
> >>> +	#size-cells = <0>;
> >>> +
> >>> +	usb2@2 {
> >> 
> >> I think this should be usb1@2 instead of usb2@2? That's because it's
> >> at /sys/bus/usb/devices/1-2 and not at /sys/bus/usb/devices/2-2?
> >> 
> >> Or what's the naming standard here?
> > 
> > Good question. As far as I know, the node name is irrelevant, only the reg
> > value is important. Maybe we should call it hub@2 ?
> 
> Yeah hub sounds good to me, Rob?
> 
> Sohow does the kernel know which instance it is if there
> are multiple devices? For example, below is a patch for
> igepv5 (not yet using "hub" naming), note how it has things
> at 3-2 and 3-2.3. So if it also had something at 1-2 and
> 1-2.1, how would we name them?

Every time I have to deal with USB device names I need to look the naming 
scheme up. The explanation here might not be 100% accurate.

The first number is the bus number, which more or less identifies a host 
controller (and its root hub). That's a dynamically allocated ID that thus 
can't be used by DT, but given that DT USB bindings create node as children of 
a host controller, we don't need the bus number anyway.

The numbers following the dash identify ports on hubs. 3-2 is thus the device 
connected on port 2 of the root hub of bus 3 (which is a hub), and 3-2.3 is 
the device connected on port 3 of the hub connected on port 2 of the root hub 
of bus 3.

If you had 1-2 and 1-2.1 it would mean that device on port 2 of the root hub 
of bus 1 (1-2) is a hub that has device connected on its first port (1-2.1).

> 8< ------------------------
> 
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Thu, 1 Dec 2016 17:04:50 -0800
> Subject: [PATCH] ARM: dts: omap5-igep0050: Allow bootloader to configure
>  USB Ethernet MAC
> 
> This is slightly different wiring compared to omap5-uevm or pandaboard:
> 
> /sys/bus/usb/devices/3-2	hub
> /sys/bus/usb/devices/3-2.3	7500
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap5-igep0050.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-igep0050.dts
> b/arch/arm/boot/dts/omap5-igep0050.dts ---
> a/arch/arm/boot/dts/omap5-igep0050.dts
> +++ b/arch/arm/boot/dts/omap5-igep0050.dts
> @@ -19,6 +19,10 @@
>  		reg = <0x0 0x80000000 0 0x7f000000>;	/* 2032 MB */
>  	};
> 
> +	aliases {
> +		ethernet = &ethernet;
> +	};
> +
>  	gpio_keys {
>  		compatible = "gpio-keys";
>  		pinctrl-0 = <&power_button_pin>;
> @@ -116,3 +120,20 @@
>  		OMAP5_IOPAD(0x1ca, PIN_OUTPUT | MUX_MODE6)	/* 
perslimbus2_clock.gpio5_145
> */
>  	>;
> 
>  };
> +
> +&usbhsehci {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	usb3@2 {
> +		compatible = "usb424,3503";
> +		reg = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethernet: usbether@3 {
> +			compatible = "usb424,7500";
> +			reg = <3>;
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
