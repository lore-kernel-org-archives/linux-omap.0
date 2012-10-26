From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 26 Oct 2012 23:15:39 +0300
Message-ID: <20121026201539.GD29548@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966367Ab2JZUVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:21:39 -0400
Content-Disposition: inline
In-Reply-To: <20121025101212.GD21217@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 01:12:12PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Oct 23, 2012 at 09:23:03PM +0200, Jean Pihet wrote:
> > On Tue, Oct 23, 2012 at 9:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > > On Mon, 22 Oct 2012, Jean Pihet wrote:
> > >
> > >> On Mon, Oct 22, 2012 at 6:12 PM, Jean Pihet <jean.pihet@newoldbits.c=
om> wrote:
> > >>
> > >> > Do you have CPU_IDLE enabled?
> > >> FYI the issue is not present with CPU_IDLE enabled.
> > >
> > > Hmm, how can you tell?  I thought you weren't able to reproduce it wi=
th
> > > CPU_IDLE disabled either?
> > I could not reproduce the issue, with and without CPU_IDLE enabled.
> > What puzzles me is that the PM QoS code only has influence on the
> > states chosen by cpuidle, so the change should not have any impact
> > with CPU_IDLE enabled. I reallt need to reproduce the issue.
> > Let me try with the same setup as yours (bootloader images,
> > omap2pus_defconfig, angstrom roots).
>=20
> I just sent a patch to fix a bug I found on OMAP4 panda but while
> reading this thread again, I think it could be that it's the same bug
> which is just easier to reproduce on Paul's setup.
>=20
> Paul, Aaro, can you see if [1] makes the problem go away ? that would be
> another reason to push [1] during this -rc cycle.
>=20
> [1] http://marc.info/?l=3Dlinux-omap&m=3D135115602407925&w=3D2

ping

--=20
balbi

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiu9rAAoJEIaOsuA1yqREdi4P/3j1LteaGo/KpNJCzf8k1U5n
3cfgWCd/ghzw4iQWQgjyiJ7Ay1veMZt6uArAYOZxQhMjLrfZvrg2qsJOeaTlBsIy
aMHOygGk24PHRhZHJN/mBC8mDVDHj6uWWbKwciRA80WaZILsYo9BKcRiT/fnO46L
WrAPB9gNV1fqEbHMwFvqmuqVBc5eXUgbY9PitaJf+r0hmCzSpc08AyNy1BFkgQOG
9Fn5LXu8vPAN56RrSH/r1Xxn58d8w8zpj8coGC+Y9oITZPEA46PMosvQKfF882MQ
k+dJ5c2B7+3IRMClcBs3D49rRJWSNqX+HujFN3P9cbm/qTl+CGWcBCfV2m2/IeuI
YElsdbsZAoy+fIgw4lwu1XL1V7c40+aRykQCxWRdJ8iwulaTmpW91KAlP158md5F
v4BAJYGxfxxeVGjRqOrrVF9v180vjuf0f17IlSYtF+bLhwPM5uzvYk7cEuDvfv0v
HjqRXJK6WttfRLUSHNE9UAhTknwUy/TdgnwcW78ffcM5EWN3AzBAZH4KU9+QWMXu
3luBlIZ9ndAPYVnv70vMMrOJzMhcVVXf6vgzhbSya+TwMd6hJp7CwdtdsNIwDzNu
83QM4obLiu0Zz0HBztgfV2LfyVbh0eSUxo1PHIizVcNJ4vwaOs6jY9VHFP8BGpuM
PddZzB1pAMX4C4W551S8
=1jnh
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
