From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
Date: Wed, 12 Nov 2014 14:53:49 +0200
Message-ID: <5463585D.9070209@ti.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com> <1415051968-4878-5-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="c0Kkcpg1fR1vkmcOxR1vKclD6JMrWcbsQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415051968-4878-5-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--c0Kkcpg1fR1vkmcOxR1vKclD6JMrWcbsQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/11/14 23:59, Marek Belisko wrote:
> gta04 board need for tvout enabled 2 bits in devconf1 register (tvbypas=
s and acbias).
> Add single pinmux entry and enable it.
>=20
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/oma=
p3-gta04.dtsi
> index e4d05f0..a456d37 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -118,6 +118,17 @@
>  			};
>  		};
>  	};
> +
> +	/* pinmux for devconf1 */
> +	control_devconf1: pinmux@480022d8 {
> +		compatible =3D "pinctrl-single";
> +		reg =3D <0x480022d8 4>;	/* single register */
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		pinctrl-single,bit-per-mux;
> +		pinctrl-single,register-width =3D <32>;
> +		pinctrl-single,function-mask =3D <0xfc0bd5>;
> +	};
>  };
> =20
>  &omap3_pmx_core {
> @@ -497,3 +508,14 @@
>  		};
>  	};
>  };
> +
> +&control_devconf1 {
> +	pinctrl-name =3D "default";
> +	pinctrl-0 =3D < &tv_acbias_pins>;
> +
> +	tv_acbias_pins: pinmux_tv_acbias_pins {
> +		pinctrl-single,bits =3D <
> +			0 0x40800 0x40800

I think it would be good to have a comment in the .dts above, mentioning
that TVOUTBYPASS and TVACEN bits are being set.

> +		>;
> +	};
> +};
>=20

OMAP3630 seems to have CONTROL_AVDAC1 and CONTROL_AVDAC2 registers. Did
you check if the SoC you use have those? It looks like they need
configuration also, if the exist.

So, I don't think tvbypass and acbias are really pinmux stuff, but it
does seem like an easy way to handle the devconf1 register, and I don't
see any issues with the setting being fixed.

However, devconf1 register seems to have bits for many devices,
including mcbsp, mmc, and even some "Force MPU writes to be nonposted" bi=
t.

And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
places in the kernel. I wonder if adding a pinmux entry for it could
cause some rather odd problems.

Tony, any idea about this? How should CONTROL_DEVCONFx registers be
accessed?

 Tomi



--c0Kkcpg1fR1vkmcOxR1vKclD6JMrWcbsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY1hdAAoJEPo9qoy8lh71hlcQAJ6gfPqz/bOlLRyx0YacJy6f
KZhOx50DHtm8v5Ft0U2nxaJJ8QfEn1gP1HgQ8lZVkLbU0rLCaeQdoBU2pcCbiFph
BJZUP4G68VVdgcY8x6hd6PEx/eTcYWd33mOAKjf54rRwcTgWj/a1EOK4L9eCcUXn
zNj9lRU2+uueg9SR19//aH18dZNpcDP+fyJFjjxEEwc6IAdCkLile4sa7Noio5S9
RMhrbp3FW+43gzwlYRAWFPBfJkSyo/fG8/STJ9tUq0sb3xCSm56yqk/tXtxVj24p
w35yTxPj9QF7xbrLEZPf91ZNGi/J+lZDYBnUb4LeUPuksILwjmrg93e6M8Xw20w7
p9krJFYDWcmcezIr4a353ajqvHzNd5I3rorln8ehCJCYNpz87d2OzX0SkRUscFM0
oQZKEcPO0lXIIOqP2PV6af8yI9Yt9v+g7amO9B13BKuYJn84NLTMe2jUnDfwRWtB
d7J2bmKrjy4bZpq8SERs9ZESMn2rmqBD6sOyWYrr9PdcPAhDKtRwzniLSRApihWQ
ZSsY2TjBtrQsdlRM6TbMAkCv/pflf2O62MZ4PHi9sulULFSyA0usSKlgWMLssdgo
vDqwGAvtVT4HGpteZbJzCnVYqXSueSoDz4XFOml4rXRVmiM9WkJr3wxlRKHGpvBV
FfgJH4Lmqp2IUXSFd8rU
=48Bv
-----END PGP SIGNATURE-----

--c0Kkcpg1fR1vkmcOxR1vKclD6JMrWcbsQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
