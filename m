From: NeilBrown <neilb@suse.de>
Subject: Re: omap2430 regression due to "usb: musb: fix incorrect usage of
 resource pointer"
Date: Fri, 26 Jul 2013 22:24:58 +1000
Message-ID: <20130726222458.3324ddd9@notabene.brown>
References: <20130726191445.1b2aaef7@notabene.brown>
	<20130726102008.GE2970@radagast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/3cXm=W9AFJ=SbM4erHY=96S"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55632 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094Ab3GZMZL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 08:25:11 -0400
In-Reply-To: <20130726102008.GE2970@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org

--Sig_/3cXm=W9AFJ=SbM4erHY=96S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jul 2013 13:20:08 +0300 Felipe Balbi <balbi@ti.com> wrote:

> On Fri, Jul 26, 2013 at 07:14:45PM +1000, NeilBrown wrote:
> >=20
> > Hi,
> >  the commit:
> >=20
> > commit 09fc7d22b024692b2fe8a943b246de1af307132b
> > Author: Felipe Balbi <balbi@ti.com>
> > Date:   Wed Apr 24 17:21:42 2013 +0300
> >=20
> >     usb: musb: fix incorrect usage of resource pointer
> >    =20
> >     We can't simply pass the resource pointer from our
> >     device down to our children, otherwise module
> >     reinsertion will not work as the resource will
> >     continue to be marked as busy.
> >    =20
> >     Fix it by building a proper struct resource for
> >     our child musb device.
> > =20
> >=20
> > (even with the subsequent compile fix applied) breaks my USB-OTG port o=
n my
> > GTA04.
> >=20
> > I must admit that I don't see the point of the patch at all.
> > Instead of passing one array to platform_device_add_resources()
> > which will copy it into malloced space, it copies bits of the array onto
> > the stack on passes that for platform_device_add_resources to copy.
> > What is the value of the second copy??
>=20
> if you don't do that, the resource will already be busy and ioremap will
> fail on second modprobe.

Ahhh... the parent/sibling/child linkage - got it.

>=20
> > But that isn't the real problem.  The real problem is that in omap2430_=
probe,
> > on my board at least, pdev->num_resources =3D=3D 3.  But only the first=
 2 entries
> > in the array are copied.
> >=20
> > If I make the array one entry larger and copy the extra entry it works.=
  Of
> > course that might break for someone else who only has 2 resources to co=
py....
> >=20
> > Can we go back to just leaving it to platform_device_add_resources to d=
o the
> > copying it have I missed something?  (I can't see where the new old code
> > would mark something as 'busy' that the new code won't mark as busy...)
>=20
> patches already in Greg's queue
>=20

Thanks.=20
Doesn't seem to be in the usb-next or usb-linus branches of=20
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
Can you give me a pointer?

Thanks,
NeilBrown


--Sig_/3cXm=W9AFJ=SbM4erHY=96S
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUfJqmjnsnt1WYoG5AQJ38BAAsnkWBApfOUWcXWX8+87mkiAX+0v7Mip3
I79WZRIL/6s6zQGxC3/Wn6YuEwwD7KfsPecnFtDU0e20tWzWeLu7bSpEBKQOfZCf
H85IjOSZn+7C3+KAnbi+EIRZqhscANQ6Msw7bGCWnJbO7C5fzfTE4Du9ov15cWpN
w0uAQOAtTlVmPTnioAsZ9ofvtCW6sOjRfjbslLw2n8c/AWWkZEw7GF6HEB9xISAO
wtQ+OlCwa66sXaBclab+9/mbRt50UA4/h9BThbdbeaY4JNbtCt4yL59tbNJpGB76
4bTcgUHSGAPDhkhSHjOBWOAYC71YVfiX2RhzfKXwSxjZThKNYRAiSdivAujixWml
ZjZECw6QqzQBSb3L7X2l5KtW0xI5c4gi3R3gWyZQfwJVUpdm+uftJuxKcDGlcXLO
wiT4CdVoRyNGMGZw3Crei3opvSpDMvdMjqRk7IwfZPKvsWY0u9D6Asr2IpK/nNHS
0ZeM2/lqbmtc8Fid8V/i8gWzHbfmj9YOM26flnUfl5N7G/uLDmiBHTBnD+1sfixx
vOH9cdBNdS7EMBwXdx9cJZEFQOxkGP40bBB+YNEBPFUySyVRv4mVnodBwvyiOVOY
ffIlZJq3G/RxsxfcMvpWaJvJ7i8MnJoXOz5QiuF8bgEotrnn+VvW+/mKuPjiNHZl
Zs/8gNARJCw=
=FYOp
-----END PGP SIGNATURE-----

--Sig_/3cXm=W9AFJ=SbM4erHY=96S--
