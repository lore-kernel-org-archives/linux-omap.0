From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 3/9] tvp514x: add YUYV format support
Date: Wed, 24 Feb 2010 11:10:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DA99713@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1262613782-20463-4-git-send-email-hvaibhav@ti.com>
 <55a3e0ce1002231544o36a63a07if76501bff7967b45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33750 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab0BXFkf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 00:40:35 -0500
In-Reply-To: <55a3e0ce1002231544o36a63a07if76501bff7967b45@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Muralidharan Karicheri <mkaricheri@gmail.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>


> -----Original Message-----
> From: Muralidharan Karicheri [mailto:mkaricheri@gmail.com]
> Sent: Wednesday, February 24, 2010 5:15 AM
> To: Hiremath, Vaibhav
> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org;
> hverkuil@xs4all.nl; davinci-linux-open-source@linux.davincidsp.com;
> Karicheri, Muralidharan
> Subject: Re: [PATCH 3/9] tvp514x: add YUYV format support
>=20
> Vaibhav,
>=20
>=20
> On Mon, Jan 4, 2010 at 9:02 AM,  <hvaibhav@ti.com> wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> > =A0drivers/media/video/tvp514x.c | =A0 =A07 +++++++
> > =A01 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/media/video/tvp514x.c b/drivers/media/video/tv=
p514x.c
> > index 4cf3593..b344b58 100644
> > --- a/drivers/media/video/tvp514x.c
> > +++ b/drivers/media/video/tvp514x.c
> > @@ -212,6 +212,13 @@ static const struct v4l2_fmtdesc tvp514x_fmt_l=
ist[] =3D
> {
> > =A0 =A0 =A0 =A0 .description =3D "8-bit UYVY 4:2:2 Format",
> > =A0 =A0 =A0 =A0 .pixelformat =3D V4L2_PIX_FMT_UYVY,
> > =A0 =A0 =A0 =A0},
> > + =A0 =A0 =A0 {
> > + =A0 =A0 =A0 =A0.index =3D 1,
> > + =A0 =A0 =A0 =A0.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE,
> > + =A0 =A0 =A0 =A0.flags =3D 0,
> > + =A0 =A0 =A0 =A0.description =3D "8-bit YUYV 4:2:2 Format",
> > + =A0 =A0 =A0 =A0.pixelformat =3D V4L2_PIX_FMT_YUYV,
> > + =A0 =A0 =A0 },
> > =A0};
>=20
> As per data sheet I can see only CbYCrY format output from the tvp514=
6
> which translate to UYVY. How are you configuring tvp to output YUYV? =
I
> don;t see any change to the code to configure this format.
>=20
[Hiremath, Vaibhav] Yes you are right, actually this is dummy format cr=
eated to support YUYV.
> CCDC can switch the CbCr order and also can swap Y/C order. So if you
> are achieving
> this via ccdc configuration, there is no need to add this format to t=
vp5146
> IMO.
>=20
[Hiremath, Vaibhav] I think it makes sense to handle this is master dri=
ver, since we are handling this in CCDC. It could possible in the futur=
e TVP5146 might get used with SoC which don't have this capability.=20

Thanks,
Vaibhav

> -Murali
>=20
> >
> > =A0/**
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-med=
ia" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
>=20
>=20
> --
> Murali Karicheri
> mkaricheri@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
