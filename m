From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 10/14] dt: Add pd_size to AUXDATA structure
Date: Wed, 10 Aug 2011 21:32:04 +0530
Message-ID: <20110810160204.GA2091@manju-desktop>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
 <1312897232-4792-11-git-send-email-manjugk@ti.com>
 <4E42723D.1010501@ti.com>
 <CACxGe6tq43M6x-pQS4CHTsjiNORLgMzWXL7Hn0GzTFMNCrRzAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:42921 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752443Ab1HJQCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 12:02:22 -0400
Received: by mail-gw0-f52.google.com with SMTP id 15so1118511gwj.11
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 09:02:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACxGe6tq43M6x-pQS4CHTsjiNORLgMzWXL7Hn0GzTFMNCrRzAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 10, 2011 at 07:16:30AM -0600, Grant Likely wrote:
> On Wed, Aug 10, 2011 at 5:57 AM, Cousson, Benoit <b-cousson@ti.com> w=
rote:
> > On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
> >>
> >> Add pd_size in the AUXDATA structure so that device drivers which =
require
> >> platform_data size can pass along with AUXDATA.
> >
> > It is really needed by device driver? Or is it because omap_device_=
build is
> > using platform_device_add_data that is doing a copy of the pdata an=
d thus
> > require the size?
>=20
> Yes, I have the same question.  What is the reason for needing the
> platform data size?

Yes. It is required by "omap_device_build" which in turn calls=20
"platform_device_add_data" and copies using "kmemdup" and original
pdata pointer memory will get freed.

It is required by hwmod and not device driver. I can change description=
=2E

>=20
> g.
>=20
> >
> >> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >> ---
> >> =A0drivers/of/platform.c =A0 =A0 =A0 | =A0 =A02 ++
> >> =A0include/linux/of_platform.h | =A0 =A05 +++++
> >> =A02 files changed, 7 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >> index ebbbf42..4b27286 100644
> >> --- a/drivers/of/platform.c
> >> +++ b/drivers/of/platform.c
> >> @@ -565,6 +565,7 @@ static int of_platform_bus_create(struct devic=
e_node
> >> *bus,
> >> =A0 =A0 =A0 =A0struct platform_device *dev;
> >> =A0 =A0 =A0 =A0const char *bus_id =3D NULL;
> >> =A0 =A0 =A0 =A0void *platform_data =3D NULL;
> >> + =A0 =A0 =A0 int pd_size;
> >
> > Maybe platform_data_size will be a little bit more consistent?

Thought shorter name is better and still it should be readable.

-M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
