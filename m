From: NeilBrown <neilb@suse.de>
Subject: Re: GPIO debounce problems on 3.2
Date: Wed, 1 Feb 2012 17:21:00 +1100
Message-ID: <20120201172100.0e958f8a@notabene.brown>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
	<CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
	<alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
	<CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
	<alpine.DEB.2.00.1201312237410.10061@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/T8jIO3NGvNLPhN8=9fMo_ib"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38453 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab2BAGVZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 01:21:25 -0500
In-Reply-To: <alpine.DEB.2.00.1201312237410.10061@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

--Sig_/T8jIO3NGvNLPhN8=9fMo_ib
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Jan 2012 22:47:32 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> Let me also answer the question from the MPU's perspective.  Suppose the=
=20
> MPU powerdomain has entered a low power state.  That means that the MPU=20
> INTC -- part of the MPU powerdomain -- is also in a low power state.=20

My TRM says - in section 12.3.1.3 Power Management

    The MPU subsystem INTC belongs to the CORE power domain.

This is:

      AM/DM37x Multimedia Device
      Silicon Revision 1.x
      Version N

Is it wrong, are you wrong, or am I confused?

Thanks,
NeilBrown


 So=20
> neither the MPU nor the MPU INTC are working: clocks are disabled, the=20
> voltage may be scaled down, etc.  So even if an IP block elsewhere on the=
=20
> chip asserts an MPU interrupt, the MPU INTC won't notice it; it's=20
> non-functional at this point.  So for the MPU to notice the interrupt, it=
=20
> has to first come out of its low-power state.  That happens when some IP=
=20
> block asserts that SWAKEUP signal to the PRCM, which, if it's programmed=
=20
> correctly, will then bring the MPU powerdomain out of its low-power state=
,=20
> re-enable clocks, etc.  At that point, the MPU INTC should notice the=20
> interrupt, and the kernel should take it from there.
>=20
>=20
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Sig_/T8jIO3NGvNLPhN8=9fMo_ib
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyjZzDnsnt1WYoG5AQJuyxAAsS99W58DYJLG0LCB5iP3VV3SlYDTxQ9o
xrokL/aiCNimpcP7eEMYcO90mDOxeTn1cwFbjiUk1vxV2+V6d7dN4qFGfpesy08g
mPGb3oEaIKQh90WnnalCr/6xy6XPIJ3G8O6oeXp2ToFDavxRM6hL9Yf3JBEqMGq2
Ej5AAYObo6nTSrfPvYAgUPy6zye5gMt5Ildkt+vBzzn3aow/BRZjg69q8Q3LlkIK
sNE+4nYAXB5aPfiw6c4YRlzGh/scDcxDwliEFaQXLCANjGBef0je85QeSeX0beRX
xDxmRqLOCCguwQ08f81Szj+36XVWkE2A/3/PZ5qSUyx4YRdTGCGclXuaNtJ/f0yM
OhBm5vIAdwK07QytY6YrXRLk+YBa96hwd2/cSHx0ecpiDJq4Lm7vEcbrBF5lo5hg
qxWygZGIphZy8c9ivY8tgSnMBMMJZ2o7vv2MQVB4Of3Zry5Zza6mITaXh0WDJEcF
hgdF8tj8o59oGvm+tPg2x8uyWYrzLgfHXGZevCpzeiot6EzKxudh6+uzHO3HXo3D
VyJrCAoboGqXBHJfdJbjdSnxn2W/BWJoGn+fIuQf/wXuGdcBmN13KM4wNGalxAGs
PC62M4mrkUluT+THVZZKKjoakMyC1qbxsmHy6r9A9YWdoAppGfIntYpPm1pKWKR2
W9avf7LJepU=
=lkR2
-----END PGP SIGNATURE-----

--Sig_/T8jIO3NGvNLPhN8=9fMo_ib--
