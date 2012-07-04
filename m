From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: 3.5-rc3: PM/DSS broken (was vdd_mpu_iva warnings)
Date: Wed, 04 Jul 2012 09:28:50 +0300
Message-ID: <1341383330.9066.7.camel@lappyti>
References: <WC20120618103957.6103F2@terrafix.co.uk> <87zk7h5096.fsf@ti.com>
	 <WC20120703083759.980337@terrafix.co.uk> <4FF2B476.6000900@ti.com>
	 <WC20120703091232.480345@terrafix.co.uk> <4FF2D089.8030507@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-8mH10gvfKhKcyzaU3nze"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59447 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932784Ab2GDG3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 02:29:01 -0400
Received: by lbok6 with SMTP id k6so2551953lbo.32
        for <linux-omap@vger.kernel.org>; Tue, 03 Jul 2012 23:28:59 -0700 (PDT)
In-Reply-To: <4FF2D089.8030507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, jaswinder.singh@linaro.org


--=-8mH10gvfKhKcyzaU3nze
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-07-03 at 16:29 +0530, Archit Taneja wrote:

> Thanks for testing this out.
>=20
> I was going through Tomi's queue for the 3.6 merge window:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git master
>=20
> There is a commit called:
>=20
> 2b8501d777346ce1d4fe99167e9b3c0e42aae7a8
>=20
> OMAPDSS: Use PM notifiers for system suspend
>=20
> The commit message mentions the issue you see, and seems to resolve it.=
=20
> Could you give this a try?
>=20
> Tomi is out on vacation, and I don't know why this wasn't intended for=
=20
> the 3.5-rcs, maybe there are still some discussion going on about this?

I just missed it due to the pre-vacation hassle, I was so focused on
getting the stuff ready for next merge window.

With a quick glance to my master branch, the "OMAPDSS: Use PM notifiers
for system suspend" looks like it could go for 3.5-rc, and also
"OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=3Dn".

Archit, can you check that both apply fine to mainline, and send them to
Florian for 3.5-rc. And make clear they are for him, so that he doesn't
think I'll handle them =3D).

 Tomi


--=-8mH10gvfKhKcyzaU3nze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP8+KiAAoJEPo9qoy8lh71VuUP+gODm6Ho3VaN44cNAKvtwaE7
+I2V1MZCpNl4j7tSplIoKFvde4fwoXMwnBvZ6ugRrY67xcUZrFXCEIuGUZwEZ3S+
JnV/+m/Oxf+5onD6FZQrcqKlyX7FKHDuqBFGiq7oDO0yEeTUSPiYUU13eKP9RRKe
6Bb+Y+LRU1UJUNg5EF/myiM1AZN8ddqpwbabTWaRmVr/pbolIkkFmqP+DRB+9ynS
+Re8PlucVxV1DkW4rf2YFBmxBsn5bswusRFuozM1fIe1eHKgbKc/Tf7kaORRHFT6
nw1AV6F0TVoNiFzRKNFdNLtn3sxKhwVQWEY6YxH1ToPhrIKcdpYXPsCfEAQAr+9m
0Azt7R/+7/K50G+yx4guXdBkwsMz7sM7S0JM2XUMmUo+Q7FpTIW1RIeEViUSg06i
I3c+y8CCWP4zPTZHMC30RxurjafKWpcJownmi/Mc0eIiatrUqadbh6XDazzqlLNu
bj+C/1uGlJPbWz2y6fZkvrPQOiZCpwYje9x/oo3gLRxeBQCAOiEru8+315nZtcXD
ekVd3qsUKOD/9BdwAz7S4+EwIoOjD6nCt7IYUSuhCxWxtJkGr6/s5ZRC4pvzsM6k
yzs9232ozViy87swejNfcvufJlBfFHoeDyNlHiEzXdWHFuTIKhRb8+inVGEbvcNS
f7ihi/YcjQTX8vqD8n3r
=CofB
-----END PGP SIGNATURE-----

--=-8mH10gvfKhKcyzaU3nze--

