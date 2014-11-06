From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: hwmod: drop unnecessary list initialization
Date: Thu, 6 Nov 2014 10:19:40 -0600
Message-ID: <20141106161940.GE16896@saruman>
References: <1405455492-1087-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1407280524160.24161@utopia.booyaka.com>
 <20141104053952.GA15760@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45838 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaKFQTc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 11:19:32 -0500
Content-Disposition: inline
In-Reply-To: <20141104053952.GA15760@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 11:39:52PM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Jul 28, 2014 at 05:24:34AM +0000, Paul Walmsley wrote:
> > On Tue, 15 Jul 2014, Felipe Balbi wrote:
> >=20
> > > ml->node and sl->node are currently initialized
> > > by means of INIT_LIST_HEAD(). That initialiation
> > > is followed by a list_add() call.
> > >=20
> > > Looking at what both these functions do we will have:
> > >=20
> > > 	ml->node.next =3D &ml->node;
> > > 	ml->node.prev =3D &ml->node;
> > > 	oi->master->master_ports.next.prev =3D &ml->node;
> > > 	ml->node.next =3D &oi->master->master_ports.next;
> > > 	ml->node.prev =3D &oi->master->master_ports;
> > > 	oi->master->master_ports.next =3D &ml->node;
> > >=20
> > > from this, it's clear that both INIT_LIST_HEAD() calls
> > > are unnecessary and can be safely removed.
> > >=20
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >=20
> > > found by code inspection, boot tested on am437x SK on today's
> > > linux-next + pending patches.
> >=20
> > Thanks, queued for v3.18.
>=20
> This is not on v3.18, what happened ?
>=20
> $ git log --author=3Dbalbi@ti.com linus/master ^v3.17 -- arch/arm/mach-om=
ap2/omap_hwmod.c
> $

ping

--=20
balbi

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUW5+cAAoJEIaOsuA1yqRE+38P/jknMnJvpsLfpM5kdstx74RI
5S9BtG5sLtOh7brNmObRn4wHS6+UHUyl/XQWyTa98UuycTAlqQa0l12MRYn9sK4e
L8ZesREW5AOO/1QBNq+wrVaFNa9XHLk3ni/iYanBnnHbrqdQmMorQ0pQcSSyVGaY
aCZD+HqlPEPHRmQYsfwMtBfiAXx5CRuqK2CQ27zfKNr+JuGRkuEo5L6krQ1k+JiD
xyS3ftQj3e5JnmB56/CqjzLIK8tMtHeMaz5RF+pLuD1aH2lNyD7sqXgRSHdPsF+C
saQRkVB/vxrA+9hffY9C6je3BwDzHtu/ue7wlaeCZxeIbx1F2oAesXP0XRbb7ZME
EujmEz4BtSDJF2vpHJHIfRptY+CTkF6gYFaFHRaSr5GJ0Dls/8/P+M+rdrds98ko
ItMdWeAik8fm6Da1Ldc8yQXq+zhasGiGvC54ED+SyZaBn103YE2RZY+pwxC7lWYB
LakUMUSBFmlSVfrx9e+q1qCY/Vuem4WDYJ1WRQ9sUjodBlktfeJpqZM/IoiAKhUW
YYsFhW6Mg8kvDj8y34dZoLaP885Y6FCfKOalAD8xP8wAdy4CMf+SUb2subf/qLWo
3VFIRz6KuYqn1eaexdxzUdMVqVjIAZYC+damQjSl2cuDlvinObTh0QBiXik1tJwJ
PNewj2CqNzaIdEgqd4AM
=WbtT
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
