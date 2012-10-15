From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [balbi-usb:merge-result-for-greg 59/99]
 webcam.c:(.text+0x14afec): undefined reference to `config_ep_by_speed'
Date: Mon, 15 Oct 2012 22:18:13 +0300
Message-ID: <20121015191813.GA373@arwen.pp.htv.fi>
References: <20121012163902.GA19120@localhost>
 <507BC000.10004@linutronix.de>
 <20121015162914.GB32049@kroah.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121015162914.GB32049-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 15, 2012 at 09:29:14AM -0700, Greg KH wrote:
> On Mon, Oct 15, 2012 at 09:49:20AM +0200, Sebastian Andrzej Siewior wrote:
> > On 10/12/2012 06:39 PM, Fengguang Wu wrote:
> > >Hi Sebastian,
> >=20
> > Hi Fengguang,
> >=20
> > >FYI, kernel build failed on
> > >
> > >tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git me=
rge-result-for-greg
> > >head:   23953bde3e4d6aa8780dc054f6ad9882ac63f4f4
> > >commit: 721e2e91945bc2520d57d795dfe1b502ecec567c [59/99] usb: gadget: =
libcomposite: move composite.c into libcomposite
> > >config: i386-randconfig-b199 (attached as .config)
> > >
> > >All error/warnings:
> > >
> > >drivers/built-in.o: In function `uvc_function_set_alt':
> >=20
> > Yes. I accidentally broke this and this still fails in 3.7-rc1. Greg
> > has a patch for this in his tree ("usb: gadget: Make webcam gadget
> > select USB_LIBCOMPOSITE") which fixes this.
>=20
> Yes, now queued up in my tree.

thanks Greg ;-)

--=20
balbi

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfGF1AAoJEIaOsuA1yqREx4MQAJAOAUdyJeU2A4MupQWNbDll
uycD2PidBFWilMK8odkgQLd5O9H2Fx62XxoA8VjKfU1/HjD3fo5SE6HOv4mp0Av7
Imb1rxOUcH1WE48p/RSD8d4x8eGlCAlE743nYthYFHaOiENDJnsjARlVrk5yj+h2
EmHZ6RT5VSfIkAlLumd3llcN00JyXcVyDRINy4WTSmZv3WJgBRTKLO8YwEl2Kzav
2mi6YZhzx57WQXJ9KsY5DM+8jiMBPWIXfrR2j+3AJNifK/j8HZZFG/BEN3s1SeME
TZJYsXUtNA/gFeXQZBXg3wcYpK7sJOtSqLJ5t6laQp9p8vylinJH1sZeIVgDByS1
bYaBjzFpHZSvg/3uH4wYOyzXEaqX9+rcFvzMa6SgGcitrOlWP1mAzgP7129HSntq
x+pF07K228o92YXQHlym3iLsV8drAUy83dnFzxxYKNykIBndx6h2GWz/FMX9kS80
BZVO7Jz2+J444/0OpDa4OU8xC+/lx629GrdS7GrjJeaHRdrUyNoQaJCZ0Dljs4g+
3dRHo9lYvm9VqqG0PZB/UJ1aI9J5/owFm92+9lCLcPmyit7ZryOSIy5kQm4oXU6L
DypR4EO/oNncLkeSY2ppVQ70C3KoSkyhSogGC0BeT2yelforP6wRvjBtEGT3G0zQ
4hn6Hf2QGgohMAvoCFz8
=sUyi
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
