From: Felipe Balbi <balbi@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 11:41:07 +0300
Message-ID: <20110812084106.GC19467@legolas.emea.dhcp.ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
 <4E41A1B9.1060400@ti.com>
 <20110809211747.GJ11568@ponder.secretlab.ca>
 <4E41AA43.1000506@ti.com>
 <20110809214905.GK11568@ponder.secretlab.ca>
 <4E41AC5C.20301@ti.com>
 <20110810015214.GD23511@yookeroo.fritz.box>
 <CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
 <4E43CB07.20002@ti.com>
 <20110812030218.GP30552@yookeroo.fritz.box>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:35440 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852Ab1HLIlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 04:41:11 -0400
Received: by mail-bw0-f45.google.com with SMTP id zv3so2256299bkb.18
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 01:41:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110812030218.GP30552@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 12, 2011 at 01:02:18PM +1000, David Gibson wrote:
> > That seems to be pretty straightforward to implement, and as soon as
> > it is useful even for a couple of drivers, it worth adding it.
> >=20
> > It is anyway better than having to add a custom property to get the
> > information we will miss otherwise.
> >=20
> > Moreover, since some drivers are relying on that call, it will avoid
> > having to add extra code for nothing if CONFIG_OF is set.
> >=20
> > It will allow the driver to use a pretty standard API in anycase vs
> > using platform_get_resource + some extra optional calls to of_
> > functions + some code to get the information for non-DT build.
>=20
> You don't need to add stuff to the DT to use the byname interface.
> Really.  All you need is a way for the driver (well match table entry,
> really) to provide a list of names to attach to the reg entries in
> order.

the whole point of using *byname() is for the driver to not care about
the order of the resources. So if driver has to provided an ordered list
of names, what's the benefit ? Sounds really stupid to provide an
ordered list of names to an ordered list of resources, just to use
*byname() instead of just assuming the list of resources is already
ordered.

--=20
balbi

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOROciAAoJEAv8Txj19kN1C7MIAI1eCJB27RxBjsTWiXbnsaGS
d3I3BHitQnad+9sMiiehpl1LXIxI9SIRHCaFF6PxpBdhz9jnbUNAIy9KNc1Keio9
AnCMxJcS4gtGW5kUpJLan+mOez88jRhjQoNoAjBWvdKlP/4YKTFRVm3sDlJng+jG
GUs9yU2R1Mc0jg/ZGM8fBPVzIhaTHQ54wA6SIbR8zr0gIvpiNwgGPowGAEjYfyjg
fjtQBiMz6P+b1obm/Vr1gMA8We+a6GiUIqOWKLWano1a6jqTKc6yjUlYOOi6qK2p
JBbnIMaOn1Oq/oe/bq3YbwYFgVI5m7ltvY+EKehf7cdtZ5Dzud0qIqRqu2wJsbU=
=5vCo
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
