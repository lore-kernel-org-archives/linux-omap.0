From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
Date: Thu, 31 Dec 2015 09:38:45 -0800
Message-ID: <20151231173844.GD11863@localhost.localdomain>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451086345-3340-1-git-send-email-pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Sat, Dec 26, 2015 at 12:32:25AM +0100, Pali Roh=E1r wrote:
> Driver for omap3 with documentation is there since v4.4-rc1.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


> ---
>  arch/arm/boot/dts/omap34xx.dtsi |    5 +++++
>  arch/arm/boot/dts/omap36xx.dtsi |    5 +++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap=
34xx.dtsi
> index 4f6b2d5..c3f488f 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -54,6 +54,11 @@
>  				#size-cells =3D <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg =3D <0x48002524 0x4>;
> +			compatible =3D "ti,omap34xx-bandgap";
> +		};
>  	};
>  };
> =20
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap=
36xx.dtsi
> index 86253de..00f98c1 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -86,6 +86,11 @@
>  				#size-cells =3D <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg =3D <0x48002524 0x4>;
> +			compatible =3D "ti,omap36xx-bandgap";

Can you please already add on both cases

#thermal-sensor-cells =3D <0>;
?

This way we can already use them to define thermal zones. Of course,
that alone won't add the thermal zones. A separated patch would be
needed to add the thermal zone for OMAP3.

> +		};
>  	};
>  };
> =20
> --=20
> 1.7.9.5
>=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
