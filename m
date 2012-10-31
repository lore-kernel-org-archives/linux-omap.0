From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 12:12:33 +0200
Message-ID: <20121031101233.GC10094@arwen.pp.htv.fi>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
 <CAM=Q2cssHRYFJprozOSJqXNgeCub27jyVXkhvvMaxz-Z44d_EA@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cssHRYFJprozOSJqXNgeCub27jyVXkhvvMaxz-Z44d_EA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 03:02:57PM +0530, Shubhrajyoti Datta wrote:
> On Wed, Oct 31, 2012 at 2:29 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wro=
te:
> > The revision register on OMAP4 is a 16-bit lo and a 16-bit
> > hi. Currently the driver reads only the lower 8-bits.
> > Fix the same by preventing the truncating of the rev register
> > for OMAP4.
> >
> > Also use the scheme bit ie bit-14 of the hi register to know if it
> > is OMAP_I2C_IP_VERSION_2.
> >
> > On platforms previous to OMAP4 the offset 0x04 is IE register whose
> > bit-14 reset value is 0, the code uses the same to its advantage.
> >
> > The dev->regs is populated after reading the rev_hi. A NULL check
> > has been added in the resume handler to prevent the access before
> > the setting of the regs.
> >
> tested on omap4sdp, omap3630 based beagle , omap3430sdp.

oh, now I see. You need to test on OMAP2 which has different revision
layout.

--=20
balbi

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkPmRAAoJEIaOsuA1yqREjwkQAJ7CTihLLygt9HLl/go2fpxH
dLKrNKX81+58+Fu+EAZzXu7zVIAHgkhfd7eKwCsiwx39XQRM/vwaMuKQO31HBSGt
Uo37K29RCH0HI9aTbKmiyHLqK/pl+FrK/+//1L/7+2q6d3PU2mGDdPmgI8wIn0Gj
HL0lUFzmro0bnDFGkzGMw+I4zT5zUDQYtqpW95Y6N2TPKuURdVEzslgAgkCvLfzk
6aK4r5h/RC4L7LNXIwPyIBKAsNoS3oGeafljmFE1rQOvBnqIiKQws8oy63WPJjna
IUTEwu5uQgZnJx4myIiBKnxZ5vy0A+2cszdetb0xbDXFL5D8vZXuXmU8J3/qPNPo
HwrlpfpBWxmRD3nih/u7xSHMvBVV94PtLA4fymkfMNjmhb0hUPvd8j7SNh1YceCI
6DP2w+DBsOrEb0T3AIpHReak8vY2DziLI1N+R/Umf5v9wsUVXEuliB0z0UiK3yNg
5qXwJXlz37uGLvTrU9l5oYnMBNN84aOgFuNpMPpOGokxzlk6aHjbvd8jaTSZKKiH
g8X7ZZcC7aa3bcfSDtNQKqv09+P35/nYQ0B2WOEROq6NIZONIDDHgBDBW80eTzld
yiTv28JjLbmQP4WGh5wMieuQYBiaEfh8TUp/x10ALR3axzVcDHijEnyZRK0JGpIZ
b3vRsfE0fS4atZImP8Iz
=J8cR
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
