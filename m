From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Sun, 16 Nov 2014 11:09:51 +0100
Message-ID: <546877EF.8010906@suse.de>
References: <20141116075928.GA9763@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141116075928.GA9763@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

Am 16.11.2014 um 08:59 schrieb Pavel Machek:
> For device tree people: Yes, I know I'll have to create file in
> documentation, but does the binding below look acceptable?
[...]
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/oma=
p3-n900.dts
> index 739fcf2..ed0bfc1 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -553,6 +561,18 @@
> =20
>  		ti,usb-charger-detection =3D <&isp1704>;
>  	};
> +
> +	adp1653: adp1653@30 {

This should probably be led-controller@30 (a generic description not
specific to the model). The label name is fine.

> +		compatible =3D "ad,adp1653";
> +		reg =3D <0x30>;
> +
> +		max-flash-timeout-usec =3D <500000>;
> +		max-flash-intensity-uA    =3D <320000>;
> +		max-torch-intensity-uA     =3D <50000>;
> +		max-indicator-intensity-uA =3D <17500>;
> +
> +		gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>; /* Want 88 */

At least to me, the meaning of "Want 88" is not clear - drop or clarify=
?

> +	};
>  };
> =20
>  &i2c3 {
[snip]

Regards,
Andreas

--=20
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 21284 AG N=FCrn=
berg
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
