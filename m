From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 1 Dec 2014 11:07:06 +0200
Message-ID: <547C2FBA.4030204@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141129115957.GE7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="blQAtojEKCpEraSF8CEc62QM0jTNWlldg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56290 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbaLAJHS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Dec 2014 04:07:18 -0500
In-Reply-To: <20141129115957.GE7712@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

--blQAtojEKCpEraSF8CEc62QM0jTNWlldg
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/11/14 13:59, Mark Brown wrote:
> On Wed, Nov 12, 2014 at 04:40:51PM +0200, Jyri Sarha wrote:
>> The patches are based on:
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next=

>>
>> The base, the patches, and couple of additional not-to-be-merged
>> omap2plus_defconfig patches can be found here:
>> https://github.com/jsarha/linux.git omap-hdmi-audio
>=20
> I guess I'm OK with these so
>=20
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks. And just to be sure, that's "ok, we can merge these in the next
merge window"?

> but like I said in reply to the patch adding the new driver I think
> we're going to want to generalize this a bit.

Yep, if I'm not mistaken I did suggest that to Jyri at some point. We
can continue working on that, but I'd rather not do anything big on that
front before there is some other SoC that has the same setup.

 Tomi



--blQAtojEKCpEraSF8CEc62QM0jTNWlldg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfC+6AAoJEPo9qoy8lh71N+EP/0AYndnEucrVPo1Wg9ARmSu2
o8CDwQlVAijTtsF2g0tHyk2dwUfWQAu7bXGs9poCMPckAxPQ0jcO8R4CYnOpH+ot
pWqMj3/x6HBLbzMI9Lt50ucj4nVMWX9+aBLt7gux4vJja1OPw05jNzYRg+mHarKE
9+M/sb6aI06/XcDB4Pi+7RqiquqyQGU5FioqSlamiU9jx11aPFWCJKYc43QOfAYn
JGoYaBuX+95LKurfUdn2s8R8dfSU4Vi3GIOosfsMrW7E5ZAPbqP1kSYf6A78hzkz
QAP+t0TCBRGJ/FxXQPleY5TL0Qpskt49suqMjJhzTJ4biiQQdTqgmau43EiSePHD
AsTS6CPlMy8NE1XJlVlYq0QZ/dgReM519M3Po5CF1ZLZ4YriONcBEYWNay/nJhHq
4Q9ASgjYCXTAG7JkKt8LH2uAw3RDifj1ILqIZ16dUnOf74ZNIPzFb5pnRitERqOa
FLJYjDRdKFLpDYIex+HD8g1MsUrI2MzxcvvD+mX3uYjaoMcTHQVTI1/69U47Ival
OUVT93TeAjFGt2cP47FU126DUn1Q1hIp08xVZFbzNyCNJ3grNsT8f/xpf/MnHDQv
qFZ6k9r1dRiRsgfb9Cc23NrxxcdRzQvRD4Dls1H7HD0oFqcmZVS19VYqOet/cf1B
PwtILvmX7JcGQb98yA6E
=W/24
-----END PGP SIGNATURE-----

--blQAtojEKCpEraSF8CEc62QM0jTNWlldg--
