From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/5] HSI: ssi-protocol: export modem info via sysfs
Date: Sun, 31 Jan 2016 19:34:10 +0100
Message-ID: <20160131183410.GC18175@earth>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
 <1454203187-688-4-git-send-email-sre@kernel.org>
 <20160131173605.GD3721@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160131173605.GD3721@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sun, Jan 31, 2016 at 06:36:05PM +0100, Pavel Machek wrote:
> On Sun 2016-01-31 02:19:45, Sebastian Reichel wrote:
> > Currently userspace knows about the rapuyama version by
> > checking, which gpios have been exported. This does no
> > longer work with kernel based power management, so export
> > a sysfs file, which provides the rapuyama generation. Also
>=20
> Umm. So patches 1-2 make it impossible for existing userspace to
> detect modem version?
>=20
> Even if we re-add the capability with this patch, that makes it bad
> idea, no?

Thanks for having a look at the patches :) Looks like my commit
messages are not verbose enough to show the whole thing. Let me
try a more verbose explanation:

The N900 and the N950 have more or less the same modem, but with
different GPIOs. That basically means, that the powerup/down
sequence works differently. OFono has code for supporting power
management of both modems by detecting, that some gpios have not
been exported. (So if, for some reason, you have not exported
some of the GPIOs it will also think, that you have an N950 modem)

For kernel based PM there won't be any GPIOs exported, so OFono
cannot derive modem generation information from them. OTOH it
no longer needs to, since the kernel will take care of the
difference between the power up/down sequence. OFono only uses
the derived modem generation information for the different power
sequence.

Unfortunately there is another difference between the N900 and N950
modem, that is not yet covered by OFono at all: The N950 has a
broken CBS interface. So the current OFono code base is broken for
the N950, even though it can power it up. The broken N950 CBS
interface is currently not handled by either ofono, fso-gsmd or
sscd. Thus using an explicit new interface is not a problem IMHO.

Anyways, after this patchset you have the following methods for
using the modem:

1. The existing way using pm=3D1, which is still the default for now.
2. The existing way using pm=3D1 + rapuyama_version to check if all
   GPIOs are there.
3. The new way using pm=3D2. You can use rapuyama_version for avoiding
   the CBS interface on N950.

I don't think we can easily remove pm=3D1 support, since it will be
needed by existing userspace software. I do think though, that we
can change the default from pm=3D1 to pm=3D2 when support for the new
interface has been integrated into userspace software for some time
(e.g. 1 year after it has been merged).

-- Sebastian

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWrlOfAAoJENju1/PIO/qaYQcP/1Y4JiSqZQfD/8y4HCu7B2HO
Pf7bPHqUoL7q+wlRo9rLKXDSIURD2/w5kV5jBwNCQvhZCzeyc7R+0VpFLZoRTwAc
ut55zkmhC4I01lsJEaacDK+05gTYKRWOZXAruAVFkY7HKhH/4Ahby2uyU/9t2T7s
gtt/Zig62c4yqoXTTTkQ5R58KVaUXIsqXdO/iEsQVf+hBk9RjAZ8eCyyCXsoJ1bs
zDW4eDuW/8D+BmRK3NekHA8J1LjH+s18lqep2uJrZfeZyI8BsIMBakF3VB2o1ThQ
uEpO7dLTPhHRIskh+PH940bjZAeizZrDcOZVL0hELXa+x3CT2OYdntqjdr+n4fj8
Xbf+8CsLdVgX7Tte3hxfi26EWngI/L/x/5Zk+moMRpAW1b6mn4amRSt6ECY7nTED
5+5gPQwbmymp0KeREdBEQ+HYizfsGV5Q4cAD8Q7v0DrzsY2CiBV3Sz+xZQZPEx8E
+kEFg4u2jP+zdwBFsFRbHMgNtx2gA9deyX835+4TgLJjwUWtjyfJS1AP5olD8Le6
HIZZTs0pkG8mle/g0OIiHEAN803PnLNBOkj1pFyg8fnVkpedijIF507voMRY1zW9
ADUlVvW4ynIB722d3rp9T+oDTVaGkYF2U6DW6gK6tQeM/q+80AmpKSUtk7cwSJxB
dHBG0CROpkaYQnIr69au
=Wp1b
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
