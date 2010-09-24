From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2 5/6] OMAP1: Amstrad Delta: add support for camera
Date: Fri, 24 Sep 2010 08:57:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009240854470.14966@axis700.grange>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl> <20100923231415.GU4211@atomide.com>
 <20100923232617.GW4211@atomide.com> <201009240200.23301.jkrzyszt@tis.icnet.pl>
 <20100924004936.GZ4211@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:45420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755584Ab0IXG5A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 02:57:00 -0400
In-Reply-To: <20100924004936.GZ4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

On Thu, 23 Sep 2010, Tony Lindgren wrote:

> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100923 16:52]:
> > Friday 24 September 2010 01:26:17 Tony Lindgren napisa=C5=82(a):
> > > * Tony Lindgren <tony@atomide.com> [100923 16:06]:
> > > > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100910 18:20]:
> > > > > This patch adds configuration data and initialization code re=
quired for
> > > > > camera support to the Amstrad Delta board.
> > > > >
> > > > > Three devices are declared: SoC camera, OMAP1 camera interfac=
e and
> > > > > OV6650 sensor.
> > > > >
> > > > > Default 12MHz clock has been selected for driving the sensor.=
 Pixel
> > > > > clock has been limited to get reasonable frame rates, not exc=
eeding the
> > > > > board capabilities. Since both devices (interface and sensor)=
 support
> > > > > both pixel clock polarities, decision on polarity selection h=
as been
> > > > > left to drivers. Interface GPIO line has been found not funct=
ional,
> > > > > thus not configured.
> > > > >
> > > > > Created and tested against linux-2.6.36-rc3.
> > > > >
> > > > > Works on top of previous patches from the series, at least 1/=
6, 2/6 and
> > > > > 3/6.
> > > >
> > > > Queuing these last two patches of the series (5/6 and 6/6) for =
the
> > > > upcoming merge window.
> > >
> > > BTW, these still depend on updated 2/6 to make compile happy.
> >=20
> > Not so simple: still depends on struct omap1_cam_platform_data defi=
nition from=20
> > <media/omap1_camera.h>, included from <mach/camera.h>. Are you read=
y to=20
> > accept another temporary workaround?
>=20
> Heh I guess so. Or do you want to queue everything via linux-media?

Yes, we often have to select via which tree to go, then the maintainer =
of=20
the other tree just acks the patches. Sometimes we push them via differ=
ent=20
trees and try to enforce a specific merge order...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
