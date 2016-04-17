From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3-n900: Specify peripherals LDO regulators
 initial mode
Date: Sun, 17 Apr 2016 14:29:33 +0200
Message-ID: <20160417122933.GA8093@earth>
References: <1460788643-18590-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160417000536.GA1124@earth>
 <571329B0.9060503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571329B0.9060503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 17, 2016 at 09:14:08AM +0300, Ivaylo Dimitrov wrote:
> On 17.04.2016 03:05, Sebastian Reichel wrote:
> >On Sat, Apr 16, 2016 at 09:37:23AM +0300, Ivaylo Dimitrov wrote:
> >>Without that, regulators are left in the mode last set by the bootloade=
r or
> >>by the kernel the device was rebooted from. This leads to various probl=
ems
> >>like non-working peripherals.
> >>
> >>Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>---
> >>  arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >>diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
> >>index b3c26a9..1bb36e2 100644
> >>--- a/arch/arm/boot/dts/omap3-n900.dts
> >>+++ b/arch/arm/boot/dts/omap3-n900.dts
> >>@@ -329,6 +329,7 @@
> >>  	regulator-name =3D "V28";
> >>  	regulator-min-microvolt =3D <2800000>;
> >>  	regulator-max-microvolt =3D <2800000>;
> >>+	regulator-initial-mode =3D <0x0e>;
> >>  	regulator-always-on; /* due to battery cover sensor */
> >>  };
> >
> >I think this should either get an additional
> >comment like /* MODE_NORMAL */ or implemented
>=20
> According to the TRM, this is 'ACTIVE state', but that does not fit in the
> regulator framework terminology.

No problem with using STATE_ACTIVE or any other fitting description. IMHO
that "active" is misleading for regulators without "always-on/boot-on" tag,
but that was TI's decision.

> >using a define and a TWL4030_REGULATOR_MODE_NORMAL
> >constant to keep the *.dts easily readable.
>=20
> We already have RES_STATE_ACTIVE defined in linux/i2c/twl.h, is there a w=
ay
> to include that in a dts?

Not in its current state. During kernel build the C preprocessor is
applied on the *.dts files. So the header may only contain
preprocessor macros (e.g. #define). For that solution something like
~/src/linux/include/dt-bindings/regulator/maxim,max77802.h should
be created for the twl regulator.

-- Sebastian

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXE4GqAAoJENju1/PIO/qac/0QAJjwkTcJ+wdkaq+lUQVZtJo9
i5mwA2DcOFiGwt8/VpUyFYloDUyJjY2bx84FYKfJQaoQBKuOuPqpyYB/nl/RoMwb
PCOKS/JL7Q5707vOKWPgkYFLGOHxdVc4YUa2GN6TaTbklOZXp4t6VoX6mHoDXkRT
URlC2imytAMJVWzxvpVBwZjKPxhmmVntuzcr88p6+5qei8ogLFUS0IsKguLkVZ8z
PM2RXT5kSE/Q88KUEyjtdmJC6WSdbgIyWfTYRQwSoLg054L94soTCMXZuwESDqkM
AAyNXlfZfD6gJ/pamWR4rJm3AKen81UaUvc2gw257Rq91JK/NyXA9Xbd+htpEM3x
tMf4RSnc3ERYHAe7q0l38j57kJZyTNWi0/NaJ1LPVfIj6dg0IJHX01q8W7m9B7D7
2Q40FY/NncbqjL423OXbaZybnP8rLpMQ9GpUFctsH+oLvQoIt5Y/EL7xHplG4QVH
JW19oPB1OITiSXSSSqGub6Cb3UlP2itllEz0l6Ucs0w1q4V4SWCS0gNCtg7mZGXJ
GRMz8LcviiDhA6wdad9NVSVIkX4nRQSk13H59vnTpHeb3FIIsw10K1FzUkPDJWy1
wTnx0DU+gJatGw3LozeEme6uYZs7NhiUVtsWgK1xlTWT7qylhiMKs/yZHm0QjX/M
BAPogWHFL49MK5rPXZnP
=nOs9
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
