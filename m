From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: hwmod: drop unnecessary list initialization
Date: Mon, 3 Nov 2014 23:39:52 -0600
Message-ID: <20141104053952.GA15760@saruman>
References: <1405455492-1087-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1407280524160.24161@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47422 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbaKDFjl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2014 00:39:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407280524160.24161@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2014 at 05:24:34AM +0000, Paul Walmsley wrote:
> On Tue, 15 Jul 2014, Felipe Balbi wrote:
>=20
> > ml->node and sl->node are currently initialized
> > by means of INIT_LIST_HEAD(). That initialiation
> > is followed by a list_add() call.
> >=20
> > Looking at what both these functions do we will have:
> >=20
> > 	ml->node.next =3D &ml->node;
> > 	ml->node.prev =3D &ml->node;
> > 	oi->master->master_ports.next.prev =3D &ml->node;
> > 	ml->node.next =3D &oi->master->master_ports.next;
> > 	ml->node.prev =3D &oi->master->master_ports;
> > 	oi->master->master_ports.next =3D &ml->node;
> >=20
> > from this, it's clear that both INIT_LIST_HEAD() calls
> > are unnecessary and can be safely removed.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > found by code inspection, boot tested on am437x SK on today's
> > linux-next + pending patches.
>=20
> Thanks, queued for v3.18.

This is not on v3.18, what happened ?

$ git log --author=3Dbalbi@ti.com linus/master ^v3.17 -- arch/arm/mach-omap=
2/omap_hwmod.c
$

--=20
balbi

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWGaoAAoJEIaOsuA1yqREjI0P/ibRX6ywrBb1ULtl5lgDLsba
D+Rgo7ItLV1wpMt4BG6vtcpAZ2gcq9Zn7NNxTtVh5Q94oIjWBqB5ozI3NDHgSjBi
A6lBtTovWzBA26eZQOMngCGFJQZsjak8GCvvFzOOqQRNht+ZDiitoglMZP5S8puv
4SthPDsmNs+Zl7K0PTNA+XRzZxDG9J/hTnLB0H1uKRHZMRzOxI0urmdq8pXt++bQ
OZIpzPEvvQXF+INN+HGoFFpO40GqAwfcrBp5aEHGfzIAIgpMhWtBEgmnl7nkI9aT
53dYDPg5eAH7FvWaiIxlL4bWx2XvL4SG1XgHxxusSWVzoakA5tayCzE+WGWP6iS/
KzUFyp7UDWhDGVFZgiKncSBMJIZi60QkfVJoZfrr/zD02CmFTpM2Wzs1AUlCLtY2
hwAoQH5ldHKxUnoZzDLsHe3IuhH/0A9GmReeCLicaDWh1bqMQgYoc1GWs6hHh8JT
5/u0cmQX62jSqXuhkUhEqZttiugo8qjLmXYQK67i+w2WZWVzqx+67/83dfAqfRTg
smPzMlyBNuIeDblIy14FQZC3BgqghOuCW9lmMK7N6zGn+VP9dqJ7MED109+dnX0Z
p/sRHYSTBIlhX4GGOOPcRF6DnGtPZH2SyttFZrp+6PbdogPKkL/jgVd1IlmCx2dw
Kh8taaSNfUXooFbkSNea
=7Y+d
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
