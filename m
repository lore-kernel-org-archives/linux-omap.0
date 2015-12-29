From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ti-st: use device handles and add device tree binding
Date: Tue, 29 Dec 2015 12:35:34 -0600
Message-ID: <20151229183534.GM12450@rob-hp-laptop>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
 <8665E2433BC68541A24DFFCA87B70F5B23759A5B@DFRE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8665E2433BC68541A24DFFCA87B70F5B23759A5B-1tpBd5JUCm6IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 23, 2015 at 11:38:29AM +0000, Reizer, Eyal wrote:
> - Add support for getting the platform data which includes the uart
>   used and gpio pin used for enable from device tree.
>=20
> - Fix the implementation for using device handle for the uart and
>   gpiod for the enable pin, instead of device name (as string) used
>   for the uart and pio number which are both bad practice.
>=20
> Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/misc/ti-st.txt |   42 ++++++
>  arch/arm/mach-omap2/pdata-quirks.c               |   16 ++-
>  drivers/misc/ti-st/st_kim.c                      |  159 ++++++++++++=
++++------
>  drivers/misc/ti-st/st_ll.c                       |   16 ++-
>  include/linux/ti_wilink_st.h                     |   13 +-

I'd suggest you look at commit c0bd1b9e58959c5 (Revert "ti-st: add=20
device tree support") first.

>  5 files changed, 190 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/ti-st.txt
>=20
> diff --git a/Documentation/devicetree/bindings/misc/ti-st.txt b/Docum=
entation/devicetree/bindings/misc/ti-st.txt
> new file mode 100644
> index 0000000..4490da6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/ti-st.txt
> @@ -0,0 +1,42 @@
> +TI Wilink 6/7/8 (wl12xx/wl18xx) Shared transport driver

Bindings shouldn't be describing drivers...

> +
> +TI=E2=80=99s Wireless Connectivity chips support Bluetooth (BT), WiF=
i, and GPS
> +technology cores in a single die.
> +
> +Such a multi-core combo chip will be interfaced to the application p=
rocessor
> +using a single physical port (like UART).
> +
> +Shared Transport (ST) software enables BT and GPS protocols or softw=
are
> +components to interact with their respective cores over single physi=
cal port.
> +ST uses logical channels, over physical transport, to communicate wi=
th
> +individual cores.
> +
> +Logical channels 1, 2, 3, and 4 are used for BT packets, channel 8 f=
or FM,
> +channel 9 for GPS and channels 30, 31, 32, and 33 are used for Chip =
Power
> +Management (PM).

All this is irrelevant for a binding.=20

> +
> +This node provides properties for passing parameters to the ti share=
d
> +transport driver.
> +
> +Required properties:
> + - compatible: should be the following:
> +    * "kim" - ti-st parameters

Who is kim? Certainly not a description of a h/w block.

> +
> +Optional properties:
> + - nshutdown-gpios : specifies attributes for gpio ping used for ena=
bling
> +	the bluetooth,gps and FM sub systems
> + - serial-device : the phandle for the phisical uart used for intera=
cting
> + 	with the wilink device

There have been multiple discussions on serial slave devices recently.=20
I'm not going to accept any device binding without a common uart slave=20
device binding first.

> + - flow_cntrl : Indicates if uart flow control is used
> + - flow_cntrl : uart baud rate in BPS

Typo here, but these should be part of a common serial slave binding.

Don't use '_' in property names.

> +
> +Example:
> +
> +kim {
> +	compatible =3D "kim";
> +	nshutdown-gpios =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +	serial-device =3D <&uart1>;
> +	flow_cntrl =3D <1>;
> +	flow_cntrl =3D <3000000>;
> +};
> +
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
