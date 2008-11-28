From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Sat, 29 Nov 2008 00:04:10 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904ECE1@dbde02.ent.ti.com>
References: <200811280833.30868.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbYK1Sef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 13:34:35 -0500
In-Reply-To: <200811280833.30868.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Friday, November 28, 2008 10:04 PM
> To: Hiremath, Vaibhav
> Cc: video4linux-list@redhat.com; davinci-linux-open-source-
> bounces@linux.davincidsp.com; linux-omap@vger.kernel.org; Jadav,
> Brijesh R; Shah, Hardik; Hadli, Manjunath; R, Sivaraj; Karicheri,
> Muralidharan
> Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
>=20
> On Friday 28 November 2008, hvaibhav@ti.com wrote:
> > +/*
> > + * Supported standards - These must be ordered according to enum
> tvp514x_std
> > + * order.
>=20
> In this case it'd be easy to remove that restriction...
>=20
>=20
[Hiremath, Vaibhav] Very true, I never thought this of while implementi=
ng. I will change this in next patch.

> > + * Currently supports two standards only, need to add support for
> rest of the
> > + * modes, like SECAM, etc...
> > + */
> > +static struct tvp514x_std_info tvp514x_std_list[] =3D {
> > +=A0=A0=A0=A0=A0=A0=A0{
>=20
> 	[STD_NTSC_MJ] =3D {
>=20
> > +=A0=A0=A0=A0=A0=A0=A0 .width =3D NTSC_NUM_ACTIVE_PIXELS,
> > +=A0=A0=A0=A0=A0=A0=A0 .height =3D NTSC_NUM_ACTIVE_LINES,
> > +=A0=A0=A0=A0=A0=A0=A0 .video_std =3D VIDEO_STD_NTSC_MJ_BIT,
> > +=A0=A0=A0=A0=A0=A0=A0 .standard =3D {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.index =3D=
 0,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.id =3D V=
4L2_STD_NTSC,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.name =3D=
 "NTSC",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.frameper=
iod =3D {1001, 30000},
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.framelin=
es =3D 525
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 },
> > +=A0=A0=A0=A0=A0=A0=A0}, {
>=20
> 	[STD_PAL_BDGHIN] =3D { ...
>=20
> ... for clarity.  Though it's more conventional to have
> the "undefined" value be zero, and thus what kzalloc or
> static initialization provides, than have NTSC be zero.  :)
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
