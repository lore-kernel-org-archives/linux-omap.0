From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/13] OMAPDSS: DSI: Use new lane config in
 dsi_set_lane_config
Date: Mon, 28 Nov 2011 17:43:35 +0200
Message-ID: <1322495015.2364.12.camel@deskari>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
	 <1322141381-5395-7-git-send-email-tomi.valkeinen@ti.com>
	 <1322471339.17335.73.camel@groo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9A5nddTS1zh2/NHjjHph"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:37497 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467Ab1K1Pnm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 10:43:42 -0500
In-Reply-To: <1322471339.17335.73.camel@groo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-9A5nddTS1zh2/NHjjHph
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-11-28 at 11:08 +0200, Carlos Chinea wrote:
> Hi Tomi,
>=20
> Just a question/suggestion, bellow:
>=20
> On Thu, 2011-11-24 at 15:29 +0200, ext Tomi Valkeinen wrote:
> > Use the new lane config in dsi_set_lane_config().
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  drivers/video/omap2/dss/dsi.c |   84 +++++++++++++++++++--------------=
-------
> >  1 files changed, 40 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/ds=
i.c
> > index aea110c..ba8d6b3 100644
> > --- a/drivers/video/omap2/dss/dsi.c
> > +++ b/drivers/video/omap2/dss/dsi.c
> > @@ -2154,59 +2154,53 @@ static int dsi_parse_lane_config(struct omap_ds=
s_device *dssdev)
> >  	return 0;
> >  }
> > =20
> > -static void dsi_set_lane_config(struct omap_dss_device *dssdev)
> > +static int dsi_set_lane_config(struct omap_dss_device *dssdev)
> >  {
> >  	struct platform_device *dsidev =3D dsi_get_dsidev_from_dssdev(dssdev)=
;
> > +	struct dsi_data *dsi =3D dsi_get_dsidrv_data(dsidev);
> > +	static const u8 offsets[] =3D { 0, 4, 8, 12, 16 };
> > +	static const enum dsi_lane_function functions[] =3D {
> > +		DSI_LANE_CLK,
> > +		DSI_LANE_DATA1,
> > +		DSI_LANE_DATA2,
> > +		DSI_LANE_DATA3,
> > +		DSI_LANE_DATA4,
> > +	};
>=20
> Patch 05 of the series has a function (dsi_parse_lane_config) with
> exactly the same static local declaration. Wouldn't be better to have an
> static global declaration instead to save some space ? or are the values
> from those functions going to differ in the near future ?=20

True, the array could be a global, and no, I don't think they'll change
in the near future.

But the data is more like function internal stuff than global data. The
functions want to parse and set the lane configs in particular order,
and use the array for that.

While the order happens to be the same in both functions, I still felt
the array is internal to each function rather than global data. Looking
from outside the function, the order doesn't matter. It's just an
internal detail.

 Tomi


--=-9A5nddTS1zh2/NHjjHph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO06wnAAoJEPo9qoy8lh71mzEP/jufJ2b79lcwh9laipjkuRsd
udOg9s7RjWkzBzp/C0teg8BpteFwNTADN/e1kKpA8ZjQ1ipJm1lcEYtns3Cgm19N
OLrY2jkrErB78RZzbmfgRZu05+dDFjqQQJiAHRWRi5JQoQmN5TzMOOqkoU09EXpw
FMLt3akPpbFGiUNOCk/KI5osIAYZ257/KNf5ZkGcLWUAmGtfH/UyP6CU9Y2u3hOH
GRdGJGv/j51/v9HBlzkgrKdfekxzaivb+sAM3lXVlz/bNZa4hKY6oVC3PhNa/67U
GDD/ASGV2koUEoirdNcNxUh9HHMMEYUKVix3leNjZGEYZ54KtJiHdgW9bzXK1P00
PngVjyUmuL3yowBQKbb+BnFp+7cD1/xonyKgskdRqID6mnJyc/R0omQg+B52T7Yr
lqzOqC6lYiaQA3wfB2f3vSHRHFVEbdAgGaHLT4kQ4QWsXGvTCU9GaQ+eznjBoyH3
UnkEZaSqd77S/b2YLN5kbn1QiIPrKyO9QEihbEvdZLqQjReecyYn+0uhJCJQ/Jqs
UpgY95ySydnD6Od0gOsX6yKjC0G9lCBda/UIBZSMMUgOxW7glZBpchJNFUvvgnyy
eiQidQdk+1oodL+dMaEOOwuG6EdT1vkLBs6xLe5xCa0kG3rBEtptEV6+nQmUFbvE
W331jjMSwPC4oxxgsIG/
=1iR8
-----END PGP SIGNATURE-----

--=-9A5nddTS1zh2/NHjjHph--

