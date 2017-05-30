From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 2/3] misc: Add w2sg0004 (gps receiver) power control driver
Date: Tue, 30 May 2017 18:09:03 -0500
Message-ID: <20170530230903.jrg6ui5xiqfhqyfg@rob-hp-laptop>
References: <cover.1495363443.git.hns@goldelico.com>
 <24579fa76fbf454526fddabe0b20070e46d488ba.1495363443.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24579fa76fbf454526fddabe0b20070e46d488ba.1495363443.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, May 21, 2017 at 12:44:03PM +0200, H. Nikolaus Schaller wrote:
> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
> 
> Use serdev API hooks to monitor and forward the UART traffic to /dev/BTn
> and turn on/off the module. It also detects if the module is turned on (sends data)
> but should be off, e.g. if it was already turned on during boot or power-on-reset.
> 
> Additionally, rfkill block/unblock can be used to control an external LNA
> (and power down the module if not needed).
> 
> The driver concept is based on code developed by NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> but simplified and adapted to use the new serdev API introduced in 4.11.
> 
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  20 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +

Please split binding patches.

>  drivers/misc/Kconfig                               |  16 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/w2sg0004.c                            | 646 +++++++++++++++++++++
>  include/linux/w2sg0004.h                           |  27 +
>  6 files changed, 711 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>  create mode 100644 drivers/misc/w2sg0004.c
>  create mode 100644 include/linux/w2sg0004.h
> 
> diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> new file mode 100644
> index 000000000000..b7125c7a598c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> @@ -0,0 +1,20 @@
> +Wi2Wi GPS module connected through UART
> +
> +Should be a subnode of the SoC UART it is connected to (serdev).
> +
> +Required properties:
> +- compatible:	wi2wi,w2sg0004 or wi2wi,w2sg0084

Reformat to one per line.

> +- on-off-gpio:	the GPIO that controls the module's on-off toggle input

Does enable-gpios or powerdown-gpios work as those are semi-standard 
names. Also, need to state the active state.

> +
> +Optional properties:
> +- lna-suppy:	an (optional) LNA regulator that is enabled together with the GPS receiver

typo

> +
> +Example:
> +
> +&uart2 {
> +	gps: w2sg0004 {

w2sg0004: gps {

The node name should be generic. The label can be whatever you like.

> +		compatible = "wi2wi,w2sg0004";
> +		lna-supply = <&vsim>;   /* LNA regulator */
> +		on-off-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* GPIO_145: trigger for turning on/off w2sg0004 */
> +        };
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index c03d20140366..c56b3181b266 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -345,6 +345,7 @@ voipac	Voipac Technologies s.r.o.
>  wd	Western Digital Corp.
>  wetek	WeTek Electronics, limited.
>  wexler	Wexler
> +wi2wi	Wi2Wi, Inc.
>  winbond Winbond Electronics corp.
>  winstar	Winstar Display Corp.
>  wlf	Wolfson Microelectronics
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
