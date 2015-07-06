From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Mon, 6 Jul 2015 15:24:44 +0200
Message-ID: <201507061524.44999@pali>
References: <20141019090107.GA19132@amd> <20141028222123.GA17518@amd> <20141028222641.GW2542@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart43540907.4BOXQvmnfg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141028222641.GW2542@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart43540907.4BOXQvmnfg
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 28 October 2014 23:26:41 Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [141028 15:22]:
> > On Tue 2014-10-28 23:04:50, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > Here's a patch that should fix the issues for built-in USB
> > > > gadgets.
> > > >=20
> > > > Pavel, care to see if this gets NFSroot over USB working again
> > > > for you?
> > >=20
> > > It seems to have did the trick for me. (Plus I needed to add
> > >=20
> > > +CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> > > +CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
> > > +# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
> > >=20
> > > to be able to control the command line, that's why testing took
> > > me a while.)
> > >=20
> > > Networking now works against 3.17-based kernel. Thanks!
> >=20
> > It works on 3.18-rc1 kernel, too. (I had to hand-modify patch to
> > apply to 3.17, no changes needed for 3.18-rc1.)
> >=20
> > Tested-by: Pavel Machek <pavel@ucw.cz>
>=20
> Whatever we decice to do to fix this regression, it should probably
> be backported to at least v3.16 stable for distro use, maybe earlier
> too. I'd assume this is broken on multiple platforms currently.
>=20
> Regards,
>=20
> Tony

Hi Tony,

it looks like this patch was not included into any kernel version... I'm=20
still using it on top of 4.x kernels. Are you going to send this patch=20
into upstream? Or do you have another fix for this problem?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart43540907.4BOXQvmnfg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWagZwACgkQi/DJPQPkQ1LUrQCgo68Sg1XZmeEf3csIBHt33mPB
3vgAoK6scNhi5DoKx/05N64kIdIjSdtV
=Q5kB
-----END PGP SIGNATURE-----

--nextPart43540907.4BOXQvmnfg--
