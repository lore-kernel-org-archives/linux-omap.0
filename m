From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 21:50:01 +0100
Message-ID: <24001F85-AB58-4ADB-A7A3-1E9AD6F3E1AB@goldelico.com>
References: <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <20170219232918.53801560@aktux> <20170219223949.GA2470@amd> <EE81034E-C10E-4E8B-B026-B3E92C0DAA19@goldelico.com> <20170220193228.GB23745@amd> <776DC6E2-5D58-40F4-8866-39D9002EF772@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <776DC6E2-5D58-40F4-8866-39D9002EF772-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrey Gelman <andrey.gelman-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Michel Verlaan <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Igor Grinberg <grinberg@comp>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 20.02.2017 um 21:22 schrieb H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>=20
> Hi,
>=20
>> Am 20.02.2017 um 20:32 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>>=20
>> Hi!
>>=20
>>>> But if you have userspace that depends on touchscreen to be
>>>> calibrated... that _is_ wrong.
>>>=20
>>> User-space people and real users have the opposite opinion. They
>>> prefer if a touch is plug&play. I.e. without need for calibration.
>>=20
>> Some people prefer to calibrate their touchscreens; because of
>> per-device variations, that gives better precision.
>>=20
>> You can pass default calibration data from device tree to kernel to
>> userland. But you can not force people to use that calibration.
>=20
> Yes, you can do that if you want. I hope it became clear by the =
formula
> in my last mail.

Sorry this can be completely misleading, if read in conjunction with =
your
sentences. Brevity in answers may disturb the message.

It does not mean that you can and should force people to use that =
calibration...

It means that users still can do per-device calibration and do not have
to use the pre-calibration capability of the driver. Hence we called it
pre-calibration.

>=20
> I just want to be able to do it the other way for those users who =
don't
> care about this per-device variation.
>=20
> BR,
> Nikolaus
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel


--Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq1Z6AAoJEIl79TGLgAm6DDMP/2KjPv4aWmaKFpArgEinX0oU
D/Fuu1ZG3lLCYkTnC0DbSRdmh2G52xitI6Au/F82CLNx1qhHrNWBdECmoJDNNmq6
Ej8XIM1wl8VWC8d4AnL871YwLdrRuHYgr27UbcsJTZhaZYT/L2pxDznx/NJjUojO
51aJL2JNz0XnrRf9DJenFN7O1dkJFx/yC5bXJlTnC7d/c0od4hHVRuT/Ya/VbGtF
7XwhBLnfTui8Zd4JaQZPu0LBRYI+RzX4jQW890pVPTVWWDgF/qEuahq7MuYjzGIB
rkfPhGkEWHPClCdBSHv30ESaKNNtQJKK03YtvDUMuXWAGF0JiPdqg5oqP3rCA3rA
HZ8T0be+mEspEd5KDKCf/fTvrrIjAqV7N+xMPXvXjRkrqfd9TUo6ZLy9BeFVQvaK
va/tO2fYTtH/Jfm3ucMa1Hy3FtTY8bKPdR3Q845VOV0cJ87tTaIPaZmuNaVNn9KX
euunfW0tKNolen/tdK9WQv3RHnTpPTU+K15c6FZMb25lBkLKIxmlJveq9WvCfyLQ
XBqpgn6f3CA4jvc2iP2ycpIrkhumd0Sp+H+fH9A+btv+n+wRNxynO+IzrL1g3i4D
NcAOxcxFsIp/sH+ZJ4W0zOqrrjIeIraqQrAMC/NPmHKSrEidtzkFfxPniQCHleNV
Q0Ou9KzfZGpSOkDqDb58
=l2hy
-----END PGP SIGNATURE-----

--Apple-Mail=_55895E39-6B3C-4E01-AB1E-6364FF78CF1F--
