From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 7/7] dts: dra7-evm: add USB support
Date: Tue, 13 May 2014 10:18:02 -0700
Message-ID: <20140513171802.GG16837@atomide.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com>
 <1399283686-6127-8-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48050 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753612AbaEMRSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 13:18:08 -0400
Content-Disposition: inline
In-Reply-To: <1399283686-6127-8-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, balbi@ti.com, bcousson@baylibre.com, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140505 02:55]:
> Add USB pinmux information and USB modes
> for the USB controllers.
>=20
> CC: Beno=C3=AEt Cousson <bcousson@baylibre.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-=
evm.dts
> index 5babba0..1d77815 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -93,6 +93,18 @@
>  			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
>  		>;
>  	};
> +
> +	usb1_pins: pinmux_usb1_pins {
> +                pinctrl-single,pins =3D <
> +			0x280	0xc0000	/* usb1_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
> +                >;
> +        };
> +
> +	usb2_pins: pinmux_usb2_pins {
> +                pinctrl-single,pins =3D <
> +			0x284	0xc0000 /* usb2_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
> +                >;
> +        };
>  };

Looks like these should use the existing defins PIN_INPUT_SLEW etc?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
