From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Fri, 28 Nov 2008 08:33:30 -0800
Message-ID: <200811280833.30868.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1227876228-16553-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:25726 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750899AbYK1Qdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 11:33:33 -0500
In-Reply-To: <1227876228-16553-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: video4linux-list@redhat.com, davinci-linux-open-source-bounces@linux.davincidsp.com, linux-omap@vger.kernel.org, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>, Karicheri Muralidharan <m-karicheri2@ti.com>

On Friday 28 November 2008, hvaibhav@ti.com wrote:
> +/*
> + * Supported standards - These must be ordered according to enum tvp=
514x_std
> + * order.

In this case it'd be easy to remove that restriction...


> + * Currently supports two standards only, need to add support for re=
st of the
> + * modes, like SECAM, etc...
> + */
> +static struct tvp514x_std_info tvp514x_std_list[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{

	[STD_NTSC_MJ] =3D {

> +=A0=A0=A0=A0=A0=A0=A0 .width =3D NTSC_NUM_ACTIVE_PIXELS,
> +=A0=A0=A0=A0=A0=A0=A0 .height =3D NTSC_NUM_ACTIVE_LINES,
> +=A0=A0=A0=A0=A0=A0=A0 .video_std =3D VIDEO_STD_NTSC_MJ_BIT,
> +=A0=A0=A0=A0=A0=A0=A0 .standard =3D {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.index =3D =
0,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.id =3D V4L=
2_STD_NTSC,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.name =3D "=
NTSC",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.frameperio=
d =3D {1001, 30000},
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0.framelines=
 =3D 525
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 },
> +=A0=A0=A0=A0=A0=A0=A0}, {

	[STD_PAL_BDGHIN] =3D { ...

=2E.. for clarity.  Though it's more conventional to have
the "undefined" value be zero, and thus what kzalloc or
static initialization provides, than have NTSC be zero.  :)



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
