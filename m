From: NeilBrown <neilb@suse.de>
Subject: omap2430 regression due to "usb: musb: fix incorrect usage of
 resource pointer"
Date: Fri, 26 Jul 2013 19:14:45 +1000
Message-ID: <20130726191445.1b2aaef7@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/5YDAJFJLPMen5=KAVA4taso"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49700 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab3GZJO6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 05:14:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: linux-omap@vger.kernel.org

--Sig_/5YDAJFJLPMen5=KAVA4taso
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Hi,
 the commit:

commit 09fc7d22b024692b2fe8a943b246de1af307132b
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Apr 24 17:21:42 2013 +0300

    usb: musb: fix incorrect usage of resource pointer
   =20
    We can't simply pass the resource pointer from our
    device down to our children, otherwise module
    reinsertion will not work as the resource will
    continue to be marked as busy.
   =20
    Fix it by building a proper struct resource for
    our child musb device.
=20

(even with the subsequent compile fix applied) breaks my USB-OTG port on my
GTA04.

I must admit that I don't see the point of the patch at all.
Instead of passing one array to platform_device_add_resources()
which will copy it into malloced space, it copies bits of the array onto
the stack on passes that for platform_device_add_resources to copy.
What is the value of the second copy??

But that isn't the real problem.  The real problem is that in omap2430_prob=
e,
on my board at least, pdev->num_resources =3D=3D 3.  But only the first 2 e=
ntries
in the array are copied.

If I make the array one entry larger and copy the extra entry it works.  Of
course that might break for someone else who only has 2 resources to copy..=
..

Can we go back to just leaving it to platform_device_add_resources to do the
copying it have I missed something?  (I can't see where the new old code
would mark something as 'busy' that the new code won't mark as busy...)

Thanks,
NeilBrown

--Sig_/5YDAJFJLPMen5=KAVA4taso
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUfI+BTnsnt1WYoG5AQKKxw/9Evylq2UJL6fZq9XyhcaO/cHuAxlq9nP2
X8w2R7CcnfU8HPVofywub+A1Hd3pNSrPlAfIoxJf+dUKddrtw2Obcm+l+zxyIUZu
Uw0Z8blNYQ+1W2c7wGQuERGoAooyMlT5hMf9lvZ0vdZvDWww28OQFmsNCajsnRJ/
R2RQbtcl1MiKTsWyPn+BQX3C8oyFtUM81ejTBuRXpq5x72RvDd98NiRsYN5EigeT
T+fAw2zm13pR/LKdAkPfWTP7dFxHsat2Itn6I9QuLgtF07nVv9pb+bYFASqdOEPh
G6rZbqTYXFZhk9ZVztUDXu8cz8aI50zy3DJ08/UmLwzuMzExEmADPRjcXBJToelB
Pwj0kWZlyarvZL4P0A6UIQWIDYQcjuXqvF+hCEeQpnhmtKKnVizxHs+CHkSb655c
9NwLZRNntm2q8arFBRhvJFPcaP+KlSRoj7UUhWQDud8/s9HNft0lIrURy87ZL+ch
EcpIT+1NNOZt4BbeSPBsJVZi1MXtmxxksnf83yn5sN20+zBbXPNAmG7Kkq9850ZQ
A/Jy+4SPvJwa/0JMM3lMuFqKEWKzkww+XkZBwrnJQZLkantoJQ8TksSLXykbbDSO
ZS7Yw6ZmdN5+E1qw0xFedZWnsuLzJD7SarMRqmYiK+zAseW+/lGlSYg65gZPWYcl
frTobYDGimM=
=ke/B
-----END PGP SIGNATURE-----

--Sig_/5YDAJFJLPMen5=KAVA4taso--
