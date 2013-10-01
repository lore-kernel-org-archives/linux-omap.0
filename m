From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/10] ARM: SAMSUNG: Initialize PWM backlight enable_gpio
 field
Date: Tue, 1 Oct 2013 22:43:35 +0200
Message-ID: <20131001204335.GB9201@ulmo.nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-6-git-send-email-treding@nvidia.com>
 <524B14E8.5040302@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <524B14E8.5040302-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 12:31:04PM -0600, Stephen Warren wrote:
> On 09/23/2013 03:41 PM, Thierry Reding wrote:
> > The GPIO API defines 0 as being a valid GPIO number, so this field needs
> > to be initialized explicitly.
>=20
> >  static void __init smdkv210_map_io(void)
>=20
> > @@ -70,6 +70,7 @@ static struct samsung_bl_drvdata samsung_dfl_bl_data =
__initdata =3D {
> >  		.max_brightness =3D 255,
> >  		.dft_brightness =3D 255,
> >  		.pwm_period_ns  =3D 78770,
> > +		.enable_gpio    =3D -1,
> >  		.init           =3D samsung_bl_init,
> >  		.exit           =3D samsung_bl_exit,
> >  	},
> > @@ -121,6 +122,10 @@ void __init samsung_bl_set(struct samsung_bl_gpio_=
info *gpio_info,
> >  		samsung_bl_data->lth_brightness =3D bl_data->lth_brightness;
> >  	if (bl_data->pwm_period_ns)
> >  		samsung_bl_data->pwm_period_ns =3D bl_data->pwm_period_ns;
> > +	if (bl_data->enable_gpio)
> > +		samsung_bl_data->enable_gpio =3D bl_data->enable_gpio;
> > +	if (bl_data->enable_gpio_flags)
> > +		samsung_bl_data->enable_gpio_flags =3D bl_data->enable_gpio_flags;
>=20
> Won't this cause the core pwm_bl driver to request/manipulate the GPIO,
> whereas this driver already does that inside the samsung_bl_init/exit
> callbacks? I think you either need to adjust those callbacks, or not set
> the new standard GPIO property in samsung_bl_data.

I don't think so. The samsung_bl_data is a copy of samsung_dfl_bl_data
augmented by board-specific settings. So in fact copying these values
here is essential to allow boards to override the enable_gpio and flags
fields. Currently no board sets the enable_gpio to a valid GPIO so it's
all still handled by the callbacks only.

Thierry

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSzP3AAoJEN0jrNd/PrOhSFQP/11jJjdDbYPbijEhOmc3lpw/
rIKIpmH82cNyEmc6RU+8+JgsSYDUeoQveP2K+8JRerWKbKrFkQTZbPXmoKTnTFT7
wsf8EpAglvvwsW8gJjUJAuMwxr2b2eefG4JCRo2v/pKzLz6F2MOoubKWG1u34suE
XWZTH6UwnjlSr7z9ryBft9zUsJuLDvPtPtpwb8yrS4fOe2JS1YY/E+1lAUc28MpQ
y7/hgldsKmz6dlyW3DxIaaMISjQoklVMKPmZDGuSwsgNu4WpiTp/IAQNwrCQMDfm
XFwJDtgDvL3PGcHOQxYvE7pSEYuOpnrs0JJE+2X8hV2mzgiD1n+X/8HodaQeVoge
EffVGqOcW6j52V1zZC7etZGTZfV8FnkhR/xKcJKQkao5+gb2GTmFTjnp8u63VO1n
VRmk5dBqWr9r2iTele6d0dj2wl9o8mQ5y/emfH69ISmoUotcMFdHrqe6R1YjzKw+
Xs/pOceHk/9S8b9Mjdxjwf9xvDPVOiWq750OovzH935AkQWYeCDybBAd2+9xWpEk
XbSib2tgy0eGAftZl6YHsE/QadbXSKOR3923Kk665HSf5R4lVucLaOq7htW16MF2
65VIrKas0BgQNTA4joqZU0dc+A9qwsxUCIruCvdIkjqrmZhqMzU/JxR1EM0UAZpb
Rlw+3BSSYUcniScTN0+v
=DDMb
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
