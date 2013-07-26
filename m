From: Felipe Balbi <balbi@ti.com>
Subject: Re: omap2430 regression due to "usb: musb: fix incorrect usage of
 resource pointer"
Date: Fri, 26 Jul 2013 16:51:08 +0300
Message-ID: <20130726135108.GB9795@radagast>
References: <20130726191445.1b2aaef7@notabene.brown>
 <20130726102008.GE2970@radagast>
 <20130726222458.3324ddd9@notabene.brown>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51614 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222Ab3GZNv2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 09:51:28 -0400
Content-Disposition: inline
In-Reply-To: <20130726222458.3324ddd9@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: balbi@ti.com, Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 10:24:58PM +1000, NeilBrown wrote:
> On Fri, 26 Jul 2013 13:20:08 +0300 Felipe Balbi <balbi@ti.com> wrote:
>=20
> > On Fri, Jul 26, 2013 at 07:14:45PM +1000, NeilBrown wrote:
> > >=20
> > > Hi,
> > >  the commit:
> > >=20
> > > commit 09fc7d22b024692b2fe8a943b246de1af307132b
> > > Author: Felipe Balbi <balbi@ti.com>
> > > Date:   Wed Apr 24 17:21:42 2013 +0300
> > >=20
> > >     usb: musb: fix incorrect usage of resource pointer
> > >    =20
> > >     We can't simply pass the resource pointer from our
> > >     device down to our children, otherwise module
> > >     reinsertion will not work as the resource will
> > >     continue to be marked as busy.
> > >    =20
> > >     Fix it by building a proper struct resource for
> > >     our child musb device.
> > > =20
> > >=20
> > > (even with the subsequent compile fix applied) breaks my USB-OTG port=
 on my
> > > GTA04.
> > >=20
> > > I must admit that I don't see the point of the patch at all.
> > > Instead of passing one array to platform_device_add_resources()
> > > which will copy it into malloced space, it copies bits of the array o=
nto
> > > the stack on passes that for platform_device_add_resources to copy.
> > > What is the value of the second copy??
> >=20
> > if you don't do that, the resource will already be busy and ioremap will
> > fail on second modprobe.
>=20
> Ahhh... the parent/sibling/child linkage - got it.
>=20
> >=20
> > > But that isn't the real problem.  The real problem is that in omap243=
0_probe,
> > > on my board at least, pdev->num_resources =3D=3D 3.  But only the fir=
st 2 entries
> > > in the array are copied.
> > >=20
> > > If I make the array one entry larger and copy the extra entry it work=
s.  Of
> > > course that might break for someone else who only has 2 resources to =
copy....
> > >=20
> > > Can we go back to just leaving it to platform_device_add_resources to=
 do the
> > > copying it have I missed something?  (I can't see where the new old c=
ode
> > > would mark something as 'busy' that the new code won't mark as busy..=
=2E)
> >=20
> > patches already in Greg's queue
> >=20
>=20
> Thanks.=20
> Doesn't seem to be in the usb-next or usb-linus branches of=20
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> Can you give me a pointer?

hmmm, looks like this is not in greg/usb-linus indeed. I'll send him
another pull request on monday. If you wanna try, use my 'fixes' branch
on kernel.org.

cheers

--=20
balbi

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR8n7MAAoJEIaOsuA1yqREcXcP/A/vcUs0ZzI9O2Aca6sL5ZZ2
CaIyVJA6Cykh67gUMDbPiqaT6NsddVJzmxXORAQOKUA3/Y18w89TvqcbL+0cQZqT
caH6D15b/TZBCmwJFVoYwMgfuHj7oVsgNVEzn6Awv5XYz+7O2rmyhLGNuMEUUPu/
xLk6Hmz6z+TxhMcK30YXrkz6Rv996v6im88xqqs9iA2BPK6pG5pP15U8Kf/Kzcqf
WawsQn0vZy1Q4NUgbfk8nKqnPiHDa+3OMwQ7dbiMVM3NWAQfdmEDcItNcYvq3+m9
0EAlG0HcYAZKNOyAM0S/++kak5lt3GqmDvA7tSgDebjAuCCBEDOTA9Toznr/oXPC
Wk3tr77kNGR/4Sa4frWLgouemPMjiJGG/ONKKixXL6EC+YdoofKYw+xk35KGhCeQ
n0wVcoTeseIN8YlD2qdt5EIa5m5QLKkwW4ReHS1oajGQy703MBqrht9shGO9+Wms
yGhSTt0vI1PZOc/47uyHrrf6h/YGvyEE6dFF6KaYAge4Y61Pcs+imLOJK9VJx8Db
x83RPrQVMyA0mU2YYgMqtJM/pl8ZE7r000fajtNiGSMK6lrSbrd87OBz1LPP1CVi
xWS9wCICJ4b2sN7du+Pd2MrLvysI0gLPR0VIk+MeCAwoIr11JI1b35HFgAa/4T8s
MnZYjZmYrhhSLv8fiNPm
=jzgO
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
