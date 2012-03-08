From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/21] OMAPDSS: clean up the omapdss platform data mess
Date: Thu, 08 Mar 2012 10:02:57 +0200
Message-ID: <1331193777.2354.21.camel@deskari>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331124290-6285-9-git-send-email-tomi.valkeinen@ti.com>
	 <4F57A4E5.6070201@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-pfxTuCWwWPy2Cxmzzv3e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:52067 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752934Ab2CHIDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 03:03:32 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id y4so253809lag.8
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 00:03:31 -0800 (PST)
In-Reply-To: <4F57A4E5.6070201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com


--=-pfxTuCWwWPy2Cxmzzv3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-07 at 23:41 +0530, Archit Taneja wrote:
> On Wednesday 07 March 2012 06:14 PM, Tomi Valkeinen wrote:
> > The omapdss pdata handling is a mess. This is more evident when trying
> > to use device tree for DSS, as we don't have platform data anymore in
> > that case. This patch cleans the pdata handling by:
> >
> > - Remove struct omap_display_platform_data. It was used just as a
> >    wrapper for struct omap_dss_board_info.
> > - Pass the platform data only to omapdss device. The drivers for omap
> >    dss hwmods do not need the platform data. This should also work bett=
er
> >    for DT, as we can create omapdss device programmatically in generic =
omap
> >    boot code, and thus we can pass the pdata to it.
> > - Create dss functions for get_ctx_loss_count and dsi_enable/disable_pa=
ds
> >    that the dss hwmod drivers can call.
> >
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> > ---
> >   arch/arm/mach-omap2/display.c   |   37 ++++++++++++++++++------------=
-------
> >   drivers/video/omap2/dss/core.c  |   35 ++++++++++++++++++++++++++++++=
+++++
> >   drivers/video/omap2/dss/dispc.c |   21 ++-------------------
> >   drivers/video/omap2/dss/dsi.c   |   17 +++--------------
> >   drivers/video/omap2/dss/dss.h   |    3 +++
> >   drivers/video/omap2/dss/hdmi.c  |    2 --
> >   include/video/omapdss.h         |    5 -----
> >   7 files changed, 61 insertions(+), 59 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/displa=
y.c
> > index 3677b1f..279c124 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -185,10 +185,23 @@ int __init omap_display_init(struct omap_dss_boar=
d_info *board_data)
> >   	struct omap_hwmod *oh;
> >   	struct platform_device *pdev;
> >   	int i, oh_count;
> > -	struct omap_display_platform_data pdata;
> >   	const struct omap_dss_hwmod_data *curr_dss_hwmod;
> >
> > -	memset(&pdata, 0, sizeof(pdata));
> > +	/* create omapdss device */
> > +
> > +	board_data->dsi_enable_pads =3D omap_dsi_enable_pads;
> > +	board_data->dsi_disable_pads =3D omap_dsi_disable_pads;
> > +	board_data->get_context_loss_count =3D omap_pm_get_dev_context_loss_c=
ount;
>=20
> Why are the checks for board data being NULL removed here?

We didn't check if board_data is NULL in the earlier version either. And
I don't think there's need to check that, because if the board file
calls this function, it should also give the board data.

However, the earlier version didn't set the func pointers if the func
pointer in the board_data was !=3D NULL. Did you mean that? I removed that
check, as I don't see a need for it. The func pointers should be set by
this function, and I don't see why the board file would need to use its
own versions.

> > diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/c=
ore.c
> > index 8613f86..3efd473 100644
> > --- a/drivers/video/omap2/dss/core.c
> > +++ b/drivers/video/omap2/dss/core.c
> > @@ -87,6 +87,41 @@ struct regulator *dss_get_vdds_sdi(void)
> >   	return reg;
> >   }
> >
> > +int dss_get_ctx_loss_count(struct device *dev)
> > +{
> > +	struct omap_dss_board_info *board_data =3D core.pdev->dev.platform_da=
ta;
> > +	int cnt;
> > +
> > +	if (!board_data || !board_data->get_context_loss_count)
> > +		return -ENOENT;
>=20
> why do we check board_data being NULL here and not in omap_display_init()=
?

I added it for DT case, because then we don't have board_data for the
devices defined in the DT data. However, for now we always have the
board_data, and in this patch I should just move the code. So I'll
remove the check, and add it later with DT code if needed.

(and actually, I don' think the check is needed in DT case either...)

 Tomi





--=-pfxTuCWwWPy2Cxmzzv3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWGexAAoJEPo9qoy8lh71KrMP/jJq47DoNDI3vYwgMmXS3/XO
FSGPGuv3lggNcQczizQ9S/gj//H+/DQkFL7Lscer39fTXwjSIfjiO96u1hhWHvMV
kt4rsY9o40GC+dxXUgUPPfuRIAPGmPs2SEO3eX3WgTSOv+gDAJvqn5SHQZB61uRb
HayGOv/U7c+IHdZwVLeVvV1sqrXnZW+9tSKE6S31Y+qOW7UgaE/swl0J/EjBGBMm
d+qJDrGUj1UvwGdslO01zAmENyqJdWuv/oeTBQY2408e7W+s2XWfy5b2gnjHQNHy
o9O1W0teztxb+dOYP7pbKpHr19RJ41eXqIfBHak6SAOFtVUAvQbO7a92DUpnkiHa
Wleb7PqQ1WRYha+n+Cb0gUOdqbdP3EqWACnY2lzeTQjDEQcJRKPVwPIJ/AWtvLQb
TLglXTjmx9o674oAgOxgoOp8FBLw0aZLpC5uEXjGOzmn6DDDtUBiNP9UNgxNWjF0
uki0nJHpLzRItDdXIIMVPMPwoLo+osKYxyJDybEVpdan7GI45Q7G5t5SzYcL/6XK
/ZJdE6cTRqu9VHgensmY8E+lRJ+Oh+mpf0XPyOuVuuHFpFx4fEx3/3J1AI8JO9wC
PvUpZbmTA3xpfJznF8rN5Oem37miHWtJ0bTcQPabyD5o/CCqV/TQmCdPUPWNUGVy
4AUHyQrRIbHS9OQgwSMs
=bxqz
-----END PGP SIGNATURE-----

--=-pfxTuCWwWPy2Cxmzzv3e--

