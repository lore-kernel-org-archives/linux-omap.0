From: epsi@gmx.de
Subject: Re: RE: RE: RE: Memory performance / Cache problem
Date: Wed, 14 Oct 2009 19:23:14 +0200
Message-ID: <20091014172314.130150@gmx.net>
References: <20091012083806.323990@gmx.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF2C@dbde02.ent.ti.com>
 <20091013081651.300080@gmx.net>
 <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com>
 <20091014144839.115530@gmx.net>
 <13B9B4C6EF24D648824FF11BE8967162039B235EFA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56561 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752187AbZJNRYB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 13:24:01 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B235EFA@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, premi@ti.com, linux-omap@vger.kernel.org

> > Mem clock is both times 166MHz. I don't know whether are difference=
s in
> cycle
> > access and timing, but memclock is fine.
>=20
> How did you physically verify this?

Oszi show 166MHz, also the kernel message about freq are in both kernel=
s the same.

> > Following Siarhei hints of initialize the buffers (around 1.2 MByte
> each)
> > I get different results in 22kernel for use of
> > malloc alone
> > memcpy =3D   473.764, loop4 =3D   448.430, loop1 =3D   102.770, ran=
d =3D  =20
> 29.641
> > calloc alone
> > memcpy =3D   405.947, loop4 =3D   361.550, loop1 =3D    95.441, ran=
d =3D  =20
> 21.853
> > malloc+memset:
> > memcpy =3D   239.294, loop4 =3D   188.617, loop1 =3D    80.871, ran=
d =3D   =20
> 4.726
> >
> > In 31kernel all 3 measures are about the same (unfortunatly low) le=
vel
> of
> > malloc+memset in 22.
>=20
> Yes aligned buffers can make a difference.  But probably more so for =
small
> copies.  Of course you must touch the memory or mprotect() it so its
> faulted in, but indications are you have done this.

Mh, alignment (to an address) is done with malloc already. Probably you=
 mean something different. I don't understand the difference. For me is=
 malloc+memset=3Dcalloc.=20
I'll send you the benchmark code, if you like.=20

> > I used a standard memcpy (think this is glib and hence not neonbase=
d)?
> > To be neonbased I guess it has to be recompiled?
>=20
> The version of glibc in use can make a difference.  CodeSourcery in 2=
009
> release added PLD's to mem operations.  This can give a good benefit.=
  It
> might be you have optimized library in one case and a non-optimized i=
n
> another.

In both kernels I used the same rootfs (via NFS). Indeed I used CS2009q=
1 and its libs, but we are talking about factor 2..6. This must be some=
thing serious.

What is your feeling? Does the 22 something strange or are the newer ke=
rnels slower that they have to be.

Would be interesting to see results on other Omap3 boards with both old=
 an new kernels.

Best regards
Steffen
--=20
GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
