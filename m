From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Wed, 25 Nov 2015 23:00:59 +0100
Message-ID: <201511252300.59976@pali>
References: <20150713131902.GH26485@atomide.com> <201511252244.28797@pali> <17689711.DsQsCiDFAN@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart724251494.rz7WDksilK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17689711.DsQsCiDFAN@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart724251494.rz7WDksilK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 November 2015 22:51:00 Arnd Bergmann wrote:
> On Wednesday 25 November 2015 22:44:28 Pali Roh=C3=A1r wrote:
> > Arnd, my question about proper solution reminds... Proprietary
> > bootloader which cannot be replaced (e.g. it is signed or do
> > unknown magic) provides information to booted kernel via custom
> > specific ATAGs fields. How userspace could properly read those
> > custom information from bootloader?
>=20
> The typical solution for nonstandard bootloaders is to have a boot
> wrapper like the one from
> https://github.com/zonque/pxa-impedance-matcher that translates
> whatever information we have at the bootloader level into DT
> properties.
>=20

Ok. So there is no better solution. With some hacks we can use U-Boot as=20
3rd stage bootloader. But this is not useful for debugging or=20
developing...

Ideal "wrapper" solution would be to compile wrapper and linux zImage=20
and then glue them together to one binary. Something like internal linux=20
uncompress code which translate atags to dt.

> As I understand, the reason we are not doing that here is that we
> also have proprietary user space that we can't fix to look in a
> different place, i.e. the interface is between the bootloader and
> some user binary, not bootloader to kernel.
>=20

Yes, proprietary/closed applications are problems which we cannot fix=20
(without rewriting them).

New applications could use new "proper" interface. But without that=20
interface we cannot do that.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart724251494.rz7WDksilK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZWL5sACgkQi/DJPQPkQ1KN9ACgqFuY1Bltbq3pNCRXmHYto6go
5BAAni99JGn/sd8QiaEv/jGPEKzxcB77
=mEtj
-----END PGP SIGNATURE-----

--nextPart724251494.rz7WDksilK--
