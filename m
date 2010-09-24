From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [RESEND][PATCH v2 2/6] OMAP1: Add support for SoC camera interface
Date: Fri, 24 Sep 2010 08:54:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009240853080.14966@axis700.grange>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl>
 <201009110334.03905.jkrzyszt@tis.icnet.pl> <20100923232309.GV4211@atomide.com>
 <201009240144.47422.jkrzyszt@tis.icnet.pl> <20100923235444.GX4211@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100923235444.GX4211@atomide.com>
Sender: linux-media-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

On Thu, 23 Sep 2010, Tony Lindgren wrote:

> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100923 16:37]:
> > Friday 24 September 2010 01:23:10 Tony Lindgren napisa=C5=82(a):
> > >
> > > I think you can just move the OMAP1_CAMERA_IOSIZE to the devices.=
c or
> > > someplace like that?
> >=20
> > Tony,
> > Not exactly. I use the OMAP1_CAMERA_IOSIZE inside the driver when r=
eserving=20
> > space for register cache.
> >=20
> > I think that I could just duplicate its definition in the devices.c=
 for now,=20
> > than clean things up with a folloup patch when both parts already g=
et merged.=20
> > Would this be acceptable?
>=20
> Yeah, that sounds good to me.

=2E..better yet put a zero-length cache array at the end of your struct=
=20
omap1_cam_dev and allocate it dynamically, calculated from the resource=
=20
size.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
