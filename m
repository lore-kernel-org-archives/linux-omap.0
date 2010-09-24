From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND][PATCH v2 2/6] OMAP1: Add support for SoC camera interface
Date: Fri, 24 Sep 2010 12:28:24 +0200
Message-ID: <201009241228.26466.jkrzyszt@tis.icnet.pl>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl> <20100923235444.GX4211@atomide.com> <Pine.LNX.4.64.1009240853080.14966@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1009240853080.14966@axis700.grange>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

=46riday 24 September 2010 08:54:20 Guennadi Liakhovetski napisa=C5=82(=
a):
> On Thu, 23 Sep 2010, Tony Lindgren wrote:
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100923 16:37]:
> > > Friday 24 September 2010 01:23:10 Tony Lindgren napisa=C5=82(a):
> > > > I think you can just move the OMAP1_CAMERA_IOSIZE to the device=
s.c or
> > > > someplace like that?
> > >
> > > Tony,
> > > Not exactly. I use the OMAP1_CAMERA_IOSIZE inside the driver when
> > > reserving space for register cache.
> > >
> > > I think that I could just duplicate its definition in the devices=
=2Ec for
> > > now, than clean things up with a folloup patch when both parts al=
ready
> > > get merged. Would this be acceptable?
> >
> > Yeah, that sounds good to me.
>
> ...better yet put a zero-length cache array at the end of your struct
> omap1_cam_dev and allocate it dynamically, calculated from the resour=
ce
> size.

Guennadi,
Yes, this seems the best solution, thank you.

Tony,
You'll soon get it as you ask: <media/camera.h> no longer included from=
=20
<mach/camera.h>.

Thanks,
Janusz
