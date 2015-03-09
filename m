From: NeilBrown <neilb@suse.de>
Subject: Re: twl4030_charger: need changes to get probed?
Date: Mon, 9 Mar 2015 11:06:53 +1100
Message-ID: <20150309110653.7532613c@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043352.4243.11227.stgit@notabene.brown>
	<20150302210926.GP13270@amd>
	<20150305173350.50502b95@notabene.brown>
	<20150306212417.GA24169@amd>
	<20150307210102.GL5233@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/t8viym4Ys3iYI07D4d0NOPc"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150307210102.GL5233@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/t8viym4Ys3iYI07D4d0NOPc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Mar 2015 22:01:02 +0100 Sebastian Reichel <sre@debian.org> wrote:

> Hi,
>=20
> On Fri, Mar 06, 2015 at 10:24:17PM +0100, Pavel Machek wrote:
> > According to n900 dts, twl4030-bci (aka charger) should be
> > included.
>=20
> its part of twl, but not used on N900 afaik.
>=20
> > (But it does not seem to do anything useful on n900. I was hoping for
> > measurement of input voltage, but .. no.)
>=20
> check for rx51-battery.
>=20
> > Any ideas why the patch below is needed?
>=20
> platform_driver_probe() does not support deferred probing.
>=20
> Neil, can you take this patch into your series for the next round?

I could, but I do wonder if it is the right thing to do.

Shouldn't we fix platform_driver_probe() to support deferred probing.

As I understand it, it refused to retry a probe if there is an error, and t=
he
comments suggest that such retrying is avoided because it would be a waste
of time:

	/*
	 * Prevent driver from requesting probe deferral to avoid further
	 * futile probe attempts.
	 */

In this case, it isn't futile.

Earlier there is a comment saying:

 * Use this instead of platform_driver_register() when you know the device
 * is not hotpluggable and has already been registered, and you want to
 * remove its run-once probe() infrastructure from memory after the driver
 * has bound to the device.

I presume all this applies.  I assume that the only problem is a probe-order
thing.  So maybe we should fix platform_driver_probe() to do the right thing
with -EPROBEDEFER??

Trouble is, I really don't understand the  point or mechanism for
platform_driver_probe(), so I cannot suggest anything.
But I have been annoyed before that platform_driver_probe doesn't cope with
EPROBEDEFER, so I would like it fixed.

NeilBrown

--Sig_/t8viym4Ys3iYI07D4d0NOPc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPzkHTnsnt1WYoG5AQKwHA//d5aOUNOlfZ59C9EtQGz1zSn+mpIsXjz0
MHcL7ZbBSfBxd8PLDBUpb/JRL/SelK5vFqOo2zmXvgqG/ANyDSo3vING8UU0kK2w
WiTQzOKJ5JPfcW4jAPo1TMbE8C7iGttB1/Z0jOEe6BlZiDYpobWYYKV7wtK3dVPl
c+Gdc1tY1s2v4+zoSe4t5gjZdBEsbS0Z2+4Y1ldkQ5Jx6dZyR9bThe/Orp1rJz3q
FgNuvxrtf27BJEHGhZ9+gucK/thxHqilVXqTjj2EBAPFnnIDftuRCzEnck/ukCFp
rvtGBHuNyAP8bQJYAs1/fObFlDkIdu4OqJE5sKWT0hhirx6D6EpMzsnfiCFRy4DG
ajmhXEJQ1sKo0PFoJE82W3zXrgAoMGefuy8+oeagToQG8WfHI3RuqDVhEijg3Rj2
t131LOi3p2M4KlirhhBO3P9EXUvfPBtIOIo6Y1y2clxR/cIV5P1QSpTiuAm0G9Qt
WvgrySckYYEv7naTF0wB9E3jr/7zV4qDlcloh50v0gqZlWIyvD24IFR0/NT89ByG
tOKRs51XQ4fGphETeztoTX23N0OCd9+rY4uH4Sln34de6U24CVhlZQ9MEF/aZ0zh
s3tK/ppkWEtWC4QgswqRTvXmER+5aRvUivkHOKcW8DbA3r+oHhNZmB03XOr7rnpY
/K5p1mS9J+8=
=4dn5
-----END PGP SIGNATURE-----

--Sig_/t8viym4Ys3iYI07D4d0NOPc--
