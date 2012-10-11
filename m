From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: phy: add a new driver for usb3 phy
Date: Wed, 10 Oct 2012 17:59:44 -0700
Message-ID: <20121011005944.GX12552@atomide.com>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348054229-27362-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [120919 04:32]:
> Added a driver for usb3 phy that handles the interaction between usb phy
> device and dwc3 controller.
> 
> This also includes device tree support for usb3 phy driver and
> the documentation with device tree binding information is updated.
> 
> Currently writing to control module register is taken care in this
> driver which will be removed once the control module driver is in place.

You may be able to set up the control module register with one
of the following Linux standard frameworks:

1. Fixed regulator defined in mach-omap2/control.c

   In this case the PHY driver can pick up the regulator by name.

2. A mux mapped with pinctrl framework using pinctrl-single,bits
   binding

   And in this case the PHY driver can request the named pinctrl
   states like "enabled" and "disabled".

> --- a/Documentation/devicetree/bindings/usb/usb-phy.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-phy.txt
> @@ -15,3 +15,21 @@ usb2phy@4a0ad080 {
>  	reg = <0x4a0ad080 0x58>,
>  	      <0x4a002300 0x4>;
>  };

The comments also apply to the omap_usb2.c driver for
0x4a002300 above.

> +
> +OMAP USB3 PHY
> +
> +Required properties:
> + - compatible: Should be "ti,omap-usb3"
> + - reg : Address and length of the register set for the device. Also
> +add the address of control module phy power register until a driver for
> +control module is added
> +
> +This is usually a subnode of ocp2scp to which it is connected.
> +
> +usb3phy@4a084400 {
> +	compatible = "ti,omap-usb3";
> +	reg = <0x0x4a084400 0x80>,
> +	      <0x4a084800 0x64>,
> +	      <0x4a084c00 0x40>,
> +	      <0x4a002370 0x4>;
> +};

And register 0x4a002370 here. Care to post some info what the
0x4a002370 register bits do? Is that same as CONTROL_DEV_CONF
on omap4, or does it have other bits there too?

The advantage for using regulator fwk and pinctrl fwk is
that the regulator and mux can be children of the SCM
core driver when we have it. And no direct register tinkering
or omap specific custom exported functions are needed ;)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
