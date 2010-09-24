From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH v2 2/6] OMAP1: Add support for SoC camera
 interface
Date: Fri, 24 Sep 2010 10:43:21 -0700
Message-ID: <20100924174321.GE4211@atomide.com>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl>
 <20100923235444.GX4211@atomide.com>
 <Pine.LNX.4.64.1009240853080.14966@axis700.grange>
 <201009241228.26466.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201009241228.26466.jkrzyszt@tis.icnet.pl>
Sender: linux-media-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100924 03:20]:
> Friday 24 September 2010 08:54:20 Guennadi Liakhovetski napisa=C5=82(=
a):
> > On Thu, 23 Sep 2010, Tony Lindgren wrote:
> > > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100923 16:37]:
> > > > Friday 24 September 2010 01:23:10 Tony Lindgren napisa=C5=82(a)=
:
> > > > > I think you can just move the OMAP1_CAMERA_IOSIZE to the devi=
ces.c or
> > > > > someplace like that?
> > > >
> > > > Tony,
> > > > Not exactly. I use the OMAP1_CAMERA_IOSIZE inside the driver wh=
en
> > > > reserving space for register cache.
> > > >
> > > > I think that I could just duplicate its definition in the devic=
es.c for
> > > > now, than clean things up with a folloup patch when both parts =
already
> > > > get merged. Would this be acceptable?
> > >
> > > Yeah, that sounds good to me.
> >
> > ...better yet put a zero-length cache array at the end of your stru=
ct
> > omap1_cam_dev and allocate it dynamically, calculated from the reso=
urce
> > size.
>=20
> Guennadi,
> Yes, this seems the best solution, thank you.
>=20
> Tony,
> You'll soon get it as you ask: <media/camera.h> no longer included fr=
om=20
> <mach/camera.h>.

OK, sounds good to me.

Tony
