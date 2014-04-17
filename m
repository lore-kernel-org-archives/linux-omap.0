From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] ARM: OMAP2+: don't try to register the main clock twice.
Date: Thu, 17 Apr 2014 10:55:40 +0200
Message-ID: <20140417085539.GA7804@katana>
References: <1396007435-20100-1-git-send-email-wsa@the-dreams.de>
 <alpine.DEB.2.02.1404111829520.14347@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60655 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbaDQIzp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2014 04:55:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1404111829520.14347@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@sang-engineering.com>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

thanks for the reply!

> > If omap_device_alloc is given 2 or more "struct omap_hwmod" it will try
> > to register the 'main_clk' of each of them with the same alias - "fck" -
> > against the same device.  This fails. So to avoid a warning, don't even
> > try.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > [wsa: ported to top-of-tree]
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
>=20
> What devices and hwmods cause this warning on AM335x?   Ideally, there=20
> should only be one hwmod per device.  Usually when multiple hwmods are=20
> stacked up for a device, it means that something isn't right - either the=
=20
> hwmod data, or the device driver itself.=20

I applied the patch because of the edma driver DT entry for the am335x.
Check am33xx.dtsi, it has multiple hwmods. I also get this message
printed for the d_can driver with am335x; they have two entries in
drivers/clk/ti/clk-33xx.c. Probably as a workaround to match the desired
clock name for the d_can driver? Didn't really investigate yet.

> In the specific context of this patch, the problem would be: what if the=
=20
> two hwmods have different main_clk entries?  Which one should be=20
> associated with the "fck" alias?

Sadly, I am in a board bringup phase and can't really contribute to the
discussions. Lots of other issues to tackle at the moment.

All the best,

   Wolfram


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTT5cLAAoJEBQN5MwUoCm25YQQAJAogmtkIxNV4RKlcln0RfyL
i1bAXfqYkKmhJXXyFdPfrvBbutyD+QYLFISXCBqmjTzSj/LHSUjgUHBur4blftnl
9TFA6Lg3UZIP0XMtvHIy3rlYctjeyCmtGQhvciNJdxm8WhCNsWqXsMPa8ERw4ocX
mEgEmRCz6eGzrqeim0YV+0QNH+WbSgvC4O5Xv/v/CTFxoUqUWO+0JE5EJm/EcZeb
Yr0DZHsKD5E9zO27BXN6seGVOa7lBKBIOiyE+HlWz98XcitfnubeBqsuUIpE/X5y
5fPhtvB3TyDVLCsucPZVjUtyyLqx/gAi+lkW0KVuIqVe8BeeCZ9hg5PyFQUvloOa
atgmHzKJvhV3KMg3W6TRoXjYY004rMh+7x1aMf9ZkI9vuuj1kiQ5p8FgEaZlHD7v
9vsMSWuUQQNe4YIOEDKS3C01eW6wzWABmx1KA0gV2HK2T2Ib3B/kOvT6npqcFZOC
VV0O7FA8d6iFS/ill9NX31qCTf7yo3dRus09kBkbTyM7LbMawrL1W+0lu1v60eib
Nsc95r8elx+v9AVILmUsZhtd23yzgfglOk1knlgTS1w3lLln1x29SL8C7Peg/qpx
y+jkOTiU1f9L1Gon3Jd5CsNEpKuRN5b3FvGq224Vn92+InJ8PdsFr8pE/dd+cUww
pjg0Jh3ni+jnoeDTxlTl
=cWMG
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
