From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
Date: Mon, 6 Jun 2016 22:58:23 -0700
Message-ID: <20160607055823.GC22406@atomide.com>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
 <bca39779-6fda-a718-3fa3-5089f4d5bfbc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bca39779-6fda-a718-3fa3-5089f4d5bfbc@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160603 06:10]:
> On 06/03/16 14:03, Peter Ujfalusi wrote:
> > 
> > I have prepared two branches on top of v4.7-rc1:
> > [1] https://github.com/omap-audio/linux-audio.git peter/for-4.8_omapdss_part1
> > 
> > containing:
> >   ARM: OMAP: rx51-video: Do not set TV connector_type
> >   ARM/video: omap2: Move omap_display_init declaration to
> >     mach-omap2/display.h
> >   video/platform_data: omapdss: Create new header file for platform data
> >   ARM: OMAP2: Use the platform_data header for omapdss
> 
> I have added your Acked-by to the ARM: OMAP patches to speed things up, please
> let me know if that is OK.

Well in general not, but seems OK to me in this case.

If peter/for-4.8_omapdss_part1 is now considered immutable, can
you please send me a pull request that I can merge it into
omap-for-v4.8/soc too?

Regards,

Tony
