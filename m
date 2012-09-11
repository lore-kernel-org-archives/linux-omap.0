From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v9 00/13] usb: musb: adding multi instance support
Date: Tue, 11 Sep 2012 14:35:45 +0300
Message-ID: <20120911113544.GE18907@arwen.pp.htv.fi>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
 <20120911091731.GA18907@arwen.pp.htv.fi>
 <6C6B28D4DC342643927BEAFCE8707BF63E9FCB6C@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43811 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932224Ab2IKLkS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 07:40:18 -0400
Received: by weyx10 with SMTP id x10so254860wey.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 04:40:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6C6B28D4DC342643927BEAFCE8707BF63E9FCB6C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "B, Ravi" <ravibabu@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2012 at 10:45:44AM +0000, B, Ravi wrote:
> >=20
> > Hi,
> >=20
> > On Fri, Aug 31, 2012 at 04:39:46PM +0530, Ravi Babu wrote:
> > > This series of patches adds,
> > > a) Multi instances support in musb driver
> > > b) DT support for musb_dsps glue layer
> > > c) DT support for NOP transceiver
> > >=20
> > > AM33xx and TI81xx has dual musb controller and has two usb=20
> > PHY of same type.
> > > This patch series uses 'phandle' based API=20
> > > devm_usb_get_phy_by_phandle() to get the PHY of same type. This API=
=20
> > > support is being added by Kishon's patch discussed at [1]
> > >=20
> > > The series applies to felipe/master [1] branch
> > > 	+ Vaibhav baseport patches on his tree at [4]
> > > 	+ Kishon's multi phy patches on Felipe's branch 'xceiv'
> > > 	+ Kishon's patch on phandle at [2]
> > > 	+ Damodar's recent patch at [3]=20
> > > 	+ Ajay's & Damodar's patches at [5] and [6] included in=20
> > this series
> > >=20
> > > 1. http://git.kernel.org/?p=3Dlinux/kernel/git/balbi/usb.git;a=3Dsumm=
ary
> > > 2. http://marc.info/?l=3Dlinux-usb&m=3D134070369306112&w=3D2
> > > 3. http://marc.info/?l=3Dlinux-usb&m=3D134200284230689&w=3D2
> > > 4.=20
> > >=20
> > https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-stagi
> > > ng 5. http://marc.info/?l=3Dlinux-usb&m=3D134200285530701&w=3D2
> > > 6. http://marc.info/?l=3Dlinux-usb&m=3D134208820028625&w=3D2
> > >=20
> > > Changes from v8:
> > > 	- included Sergei's comment, removing underscore in=20
> > device tree file
> > > 	- removed duplicated signoff from patches Changes from v7:
> > > 	- patches rebased on felipe/master branch & verified
> > > 	- included additional two patches 0001 & 0002 as part=20
> > of this series
> > > 	  which are already submitted [5] & [6] Changes from v6:
> > > 	- Removed parent_pdev to get glue and used=20
> > dev_get_getdrv() as per
> > > 	  Felipe's comment
> > > 	- use pr_debug() instead of pr_info() as per Felipe's=20
> > comment Changes=20
> > > from v5:
> > > 	- Removed musb->id as per Felipe's comment
> > > 	- used nop_ida as per Felipe's comment Changes from v4:
> > > 	- Fixed Felipe's comment for adding EXPORT_SYMBOL_GPL()
> > > 	- Fixed Felipe's comment on using dev_set_mask()=20
> > Changes from v3:
> > > 	- Fixed Kishon's comment on removing "id" from phy struct and
> > > 	  removing unneeded "#else" part.
> > > Changes from v2:
> > > 	- Fixed Sergei's comment on not using address prefix in=20
> > musb_dsps
> > > 	  glue and nop transceiver dt dats.
> > > 	- Also removed the "ti" string in compatible property=20
> > for nop data.
> > > Changes from v1:
> > > 	- Defined musb_ida to manage core ids based on Felipe's comment
> > > 	  in [PATCH 01/11]
> >=20
> > I tried appliying this, but this doesn't apply. Please rebase=20
> > on my musb branch. Unfortunately there's no time anymore to=20
> > wait otherwise the entire musb branch will miss this merge window.
> >=20
> > I'm sorry
>=20
> Felipe, patch set is ready, I will re-send the patches shortly by today.

Thanks a lot. So I'll wait for a few more hours before sending out my
musb pull request ;-)

--=20
balbi

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQTyIQAAoJEIaOsuA1yqREor4QALN5KE7ogkc4RXqr31aGMwW4
8W+9mx7wz/ogM5v9TcaCQqCZaCq8QGLR2tsThJTFY6R3eCq6zabBx2uTAsZQsZma
uBZiYlFtyHLNlZd94veS/S64Wqc/FyGzsyyYOINCbx057b2mCD9G3cvWPtxLONVv
u072hlK/wjT0AtypRSZgIJJvJLuvQHXRF5MRX+tA/JvBRUE5r/fzgm+AC2ZuqBE8
c1gWae2PrJwEVBHpFPoQ2is5po1wo4kce3KAlI591YSjAIF+W1TPod2ZY3MpiSwZ
aFa5DL18mM9UCg9DBrESHI+VoRFKa6usTR23EOt7tyzP0z0z48TKKMjPL+NjHS29
ktBpAx6VZ5ITcWUQPfIrjqXwP6CF2Scz4L4pErOWp+eUVMvgfH2GNvVLjQUD0vT/
3Npb6pXsgYg1d+o9hb65GrraOGx7VzVUj8Q497sHcI2V0+49Pw3bEJkFDtbwMeeI
6iTY01EfYJcV1cVuUEXxqRK4QJcwlhrz+CwvLtzl/2WXdHAkI4/pdFTMQhQ09j3C
OuwUnmRzS20gO7Qde3CT8QjsFe2Q+q3MAQNH5T4otacpfRPQz3xqEsbMM398lsC3
09xqpFMaTjipaghXLePt4EU4nA3iZ7IAVZCusnhUHgUcRoo7LSLi8IhPDzDB4uxL
eotdt70faABpTk2HDYif
=2U0t
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
