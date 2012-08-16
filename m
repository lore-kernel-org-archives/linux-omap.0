From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DSI: Maintain copy of operation mode in
 driver data
Date: Thu, 16 Aug 2012 15:23:35 +0300
Message-ID: <1345119815.2534.32.camel@deskari>
References: <343817088-29645-1-git-send-email-archit@ti.com>
	  <1345102594-6222-1-git-send-email-archit@ti.com>
	  <1345102594-6222-2-git-send-email-archit@ti.com>
	 <1345115964.15132.2.camel@lappyti> <502CE36A.5020700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-1VDlbOb1FewgbMCcRtX+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:47177 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753668Ab2HPMXl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:23:41 -0400
Received: by lbbgk1 with SMTP id gk1so1549002lbb.26
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 05:23:38 -0700 (PDT)
In-Reply-To: <502CE36A.5020700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-1VDlbOb1FewgbMCcRtX+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-16 at 17:41 +0530, Archit Taneja wrote:
> On Thursday 16 August 2012 04:49 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
> >> The DSI driver currently relies on the omap_dss_device struct to know =
the mode
> >> of operation of the DSI protocol(command or video mode). This makes th=
e DSI
> >> interface driver dependent on the omap_dss_device struct.
> >>
> >> Make the DSI driver data maintain it's own operation mode field. The p=
anel
> >> driver is expected to call omapdss_dsi_set_operation_mode() before the=
 interface
> >> is enabled.
> >>
> >> Signed-off-by: Archit Taneja <archit@ti.com>
> >> ---
> >>   drivers/video/omap2/displays/panel-taal.c |    1 +
> >>   drivers/video/omap2/dss/dsi.c             |   42 +++++++++++++++++++=
++--------
> >>   include/video/omapdss.h                   |    2 ++
> >>   3 files changed, 34 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video=
/omap2/displays/panel-taal.c
> >> index d220f19..649247f 100644
> >> --- a/drivers/video/omap2/displays/panel-taal.c
> >> +++ b/drivers/video/omap2/displays/panel-taal.c
> >> @@ -1063,6 +1063,7 @@ static int taal_power_on(struct omap_dss_device =
*dssdev)
> >>   	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
> >>   		dssdev->panel.timings.y_res);
> >>   	omapdss_dsi_set_pixel_format(dssdev, dssdev->panel.dsi_pix_fmt);
> >> +	omapdss_dsi_set_operation_mode(dssdev, dssdev->panel.dsi_mode);
> >
> > Taal is always in cmd mode. Shouldn't we just use a hardcoded value
> > here?
> >
> > Actually I think the same goes for the pix_fmt above. It's always the
> > same for Taal.
>=20
> Yes, I'll do this. I guess we could gradually remove some of these=20
> fields from omap_dss_device? Can't we? I mean, if there are no panels=20
> which can ever support command and video mode together, then we can just=
=20
> leave it to the driver to hold this information.

Yes, we can remove them. Even if there was a panel taht supports both
cmd and video mode, it would be the panel driver's job to handle it, and
any parameters passed to the driver would happen via the panel's own
platform data, not via dssdev.

 Tomi


--=-1VDlbOb1FewgbMCcRtX+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLOZHAAoJEPo9qoy8lh71UnUP/2MGQgXKoCSXkOjJ5NQvvPz+
d9tCHpkBQFZDM62HslnD2niAk4p+zPYYcwwR/R33YBxVkKU4H/nsWpg/ZfTHlWLo
m2QXJdJDwSqpCNp4WYZWqZHLFhkXE01ty8K2q6nSHECYMtUC31pI3rk/uIr99gQJ
jKNuaLcF+nP9hm4ctNikXDiJA+/f3pLKfT4OQuhbeAQ5ot7f5jT3IVrkmaDgj2vv
y3Zh66GzbWSFZA5EIpPMPLjtqMrqkaYPdqFQg3QlW4OAKL25QOvxFwGhWXCfATm3
N4NLeSbKgT5BzUJRsVFPTuQiKbqbeQkx8a3U/9YiQQI2mF6/YW+ARLYnULm63pfL
a9YfSROfoXWPjL1KwIJO/gRqRJNRGiThayp4HEk/ABDFvg2PuGY7gyFtDldFgxsm
UEtrgb/MY6pl/3RM5kALuMv8aJ9ZWPTPkfyc9NnMN3+1Ae7Bg6ksEdgYd3vVzoDM
U15mnTyjFlCs7gSBC0BReehqwId9V+pzYvmb8BdyroelLzrVvh+jVwnP4O8Zkg7U
IyjzNxxqYlG3XcGP2OxC3IMm91qoFtiG1LgDz+xDPozUk82jejZulpagIAWd0ihP
FWTXwYxmFBkYqPzLACnkKOnc4NzK0d4YlLjrZ8DEIVlvCq+PlpurE2iqEwBBcolM
v0MdPS4D1Mk3XsjlRkHY
=Bogl
-----END PGP SIGNATURE-----

--=-1VDlbOb1FewgbMCcRtX+--

