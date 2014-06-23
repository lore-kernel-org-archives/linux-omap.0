From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH for v3.15] usb: musb: Fix panic upon musb_am335x module
 removal
Date: Mon, 23 Jun 2014 13:34:21 -0500
Message-ID: <20140623183421.GE5073@saruman.home>
References: <1400371473-2053-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <20140520165510.GA28859@arch.cereza>
 <20140614125902.GA1202@arch.cereza>
 <20140623182300.GC5073@saruman.home>
 <CAAEAJfAH6V9BQH2adJq-FKAYrcDrw4x5Uc7S0nudL7cuJZzD0w@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfAH6V9BQH2adJq-FKAYrcDrw4x5Uc7S0nudL7cuJZzD0w@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Cc: Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, George Cherian <george.cherian@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2014 at 03:29:07PM -0300, Ezequiel Garc=EDa wrote:
> On 23 June 2014 15:23, Felipe Balbi <balbi@ti.com> wrote:
>=20
> >>
> >> Any comments on this? I don't like to remove a feature, but as
> >> explained above, I don't see any other way to solve this.
> >>
> >> The driver is currently broken. I tried using of_platform_depopulate()
> >> but failed.
> >
> > yeah, I know about the problem and, frankly, there's no other way to fix
> > this. Just resend with linux-usb in Cc.
> >
>=20
> Ouch, forgot about linux-usb on this one! I'm resending on top of
> v3.16-rc1 (although I think this one already applies).

thanks, that helps

> Thanks for the feedback,

no problem.

--=20
balbi

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqHMtAAoJEIaOsuA1yqREkUoP/A/goDpuiUX/AmB+NdI1wG77
p/P8wul4Awet8DYCCfry5UvLPXtMe9AKA8rV6QdTmurPLqHjtGdj72YlWtTMiPO9
KnsVzhzPoaT++eDiikFgpfuPmaZ5zJGOPkD+JtsjVB4KcMZZEEVUi66OSRZUYQSb
OkoVnJZzW0Gujs+kUevHdZQe8fu873TzaNouJvjmb9qFKKJYdPc6xMjwpr97YFMH
z7z+Ci+rBkzYYR0ZdxEP8uJYopxGW/tmxcdrRC1AKL6zMOdLv1LapTRHpNX//H5p
IPUyOqwM/emKqEY2+65ABKJt+FOB9QmqqqcoMILQfRnN35Im6e1WTBx2EzGNOiD+
W7HrtFeCcl0BRqON2lJDwgye1JpBibE80SltfIL6y+7QIaGqB8k4LButmS1in7iI
V0j9N008TZPxZC8DNveox+vKgyY6n7jxr7flqv2O8tvLMrfSY8IVSUXt3bG07NYe
Fmht+LZKxXiIw/nH7ncXM/4OLjisoImoeY6zKIJzhGSIImJQ3tPNv+C60xONuY4/
MoQmpfbLUPkwWvUGJXIicf/pzd1m1MerbBAcCf4jbPVhdzSzR5ONwIbcKLVCeXlT
GyNLe5VgB9ecBf5MuOhPJ3B9e7/DVLDNhIdKDRU9khtZZPZLt2ZqU3QDXgu7euJv
HEj9uBCFYRjmeAw4RcG3
=c/JZ
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
