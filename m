From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH V3] OMAP: DSS2: don't power off a panel twice
Date: Thu, 21 Oct 2010 14:38:10 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BBEC088@dbde02.ent.ti.com>
References: <1283483028-1970-1-git-send-email-stanley.miao@windriver.com>
 <AANLkTin_ap=CcLXUVC6Ztw_GJ=arymNrK_ByOf8agvQq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42899 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755812Ab0JUJIQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 05:08:16 -0400
In-Reply-To: <AANLkTin_ap=CcLXUVC6Ztw_GJ=arymNrK_ByOf8agvQq@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "mathieu.poirier@canonical.com" <mathieu.poirier@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Grazvydas Ignotas
> Sent: Thursday, October 21, 2010 2:32 PM
> To: tomi.valkeinen@nokia.com
> Cc: Stanley.Miao; linux-omap@vger.kernel.org; bryan.wu@canonical.com;
> mathieu.poirier@canonical.com; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH V3] OMAP: DSS2: don't power off a panel twice
>=20
> Tomi can you queue this? This has been tested by multiple people now,
> also see here:
> http://marc.info/?l=3Dlinux-omap&m=3D128759415821646&w=3D2
>=20
> On Fri, Sep 3, 2010 at 6:03 AM, Stanley.Miao <stanley.miao@windriver.=
com>
> wrote:
> > If we blank the panel by
> > echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
> >
> > Then, we reboot the sytem, the kernel will crash at
> > drivers/video/omap2/dss/core.c:323
> >
> > This is because the panel is closed twice. Now check the state of a
> dssdev
> > to forbid a panel is power on or power off twice.
> >
> > Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> > ---
> > =A0drivers/video/omap2/displays/panel-acx565akm.c =A0 =A0 | =A0 =A0=
6 ++++++
> > =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0 =A0=
6 ++++++
> > =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0 =A06 ++=
++++
> > =A0.../video/omap2/displays/panel-sharp-ls037v7dw01.c | =A0 =A06 ++=
++++
> > =A0.../video/omap2/displays/panel-toppoly-tdo35s.c =A0 =A0| =A0 =A0=
6 ++++++
> > =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0 =A0=
6 ++++++
> >=20
[Senthil]  Why is this change not applicable for panel-taal.c ?
> >
> > diff --git a/drivers/video/omap2/displays/panel-acx565akm.c
> b/drivers/video/omap2/displays/panel-acx565akm.c
> > index 07fbb8a..e773106 100644
> > --- a/drivers/video/omap2/displays/panel-acx565akm.c
> > +++ b/drivers/video/omap2/displays/panel-acx565akm.c
> > @@ -587,6 +587,9 @@ static int acx_panel_power_on(struct omap_dss_d=
evice
> *dssdev)
> >
> > =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
> >
> > + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > +
> > =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
> >
> > =A0 =A0 =A0 =A0r =3D omapdss_sdi_display_enable(dssdev);
> > @@ -644,6 +647,9 @@ static void acx_panel_power_off(struct
> omap_dss_device *dssdev)
> >
> > =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
> >
> > + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > +
> > =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
> >
> > =A0 =A0 =A0 =A0if (!md->enabled) {
<Snip>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
