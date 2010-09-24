From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2 5/6] OMAP1: Amstrad Delta: add support for camera
Date: Fri, 24 Sep 2010 02:00:19 +0200
Message-ID: <201009240200.23301.jkrzyszt@tis.icnet.pl>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl> <20100923231415.GU4211@atomide.com> <20100923232617.GW4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:42888 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab0IXAAx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 20:00:53 -0400
In-Reply-To: <20100923232617.GW4211@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

=46riday 24 September 2010 01:26:17 Tony Lindgren napisa=C5=82(a):
> * Tony Lindgren <tony@atomide.com> [100923 16:06]:
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100910 18:20]:
> > > This patch adds configuration data and initialization code requir=
ed for
> > > camera support to the Amstrad Delta board.
> > >
> > > Three devices are declared: SoC camera, OMAP1 camera interface an=
d
> > > OV6650 sensor.
> > >
> > > Default 12MHz clock has been selected for driving the sensor. Pix=
el
> > > clock has been limited to get reasonable frame rates, not exceedi=
ng the
> > > board capabilities. Since both devices (interface and sensor) sup=
port
> > > both pixel clock polarities, decision on polarity selection has b=
een
> > > left to drivers. Interface GPIO line has been found not functiona=
l,
> > > thus not configured.
> > >
> > > Created and tested against linux-2.6.36-rc3.
> > >
> > > Works on top of previous patches from the series, at least 1/6, 2=
/6 and
> > > 3/6.
> >
> > Queuing these last two patches of the series (5/6 and 6/6) for the
> > upcoming merge window.
>
> BTW, these still depend on updated 2/6 to make compile happy.

Not so simple: still depends on struct omap1_cam_platform_data definiti=
on from=20
<media/omap1_camera.h>, included from <mach/camera.h>. Are you ready to=
=20
accept another temporary workaround?

Thanks,
Janusz


>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
