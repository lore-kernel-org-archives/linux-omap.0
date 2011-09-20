From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap2plus_defconfig: Enable omap3isp and MT9T111
 sensor drivers
Date: Tue, 20 Sep 2011 16:52:54 -0700
Message-ID: <20110920235254.GM2937@atomide.com>
References: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
 <1316530612-23075-6-git-send-email-deepthy.ravi@ti.com>
 <201109210113.49151.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201109210113.49151.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Deepthy Ravi <deepthy.ravi@ti.com>, mchehab@infradead.org, hvaibhav@ti.com, linux-media@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, hverkuil@xs4all.nl, m.szyprowski@samsung.com, g.liakhovetski@gmx.de, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, david.woodhouse@intel.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110920 15:40]:
> >  CONFIG_REGULATOR_TPS65023=y
> >  CONFIG_REGULATOR_TPS6507X=y
> > +CONFIG_MEDIA_SUPPORT=y
> > +CONFIG_MEDIA_CONTROLLER=y
> > +CONFIG_VIDEO_DEV=y
> > +CONFIG_VIDEO_V4L2_COMMON=y
> > +CONFIG_VIDEO_ALLOW_V4L1=y
> > +CONFIG_VIDEO_V4L1_COMPAT=y
> > +CONFIG_VIDEO_V4L2_SUBDEV_API=y
> > +CONFIG_VIDEO_MEDIA=y
> > +CONFIG_VIDEO_MT9T111=y
> > +CONFIG_VIDEO_OMAP3=y
> 
> Shouldn't they be compiled as modules instead ?

Yes, let's not apply this.

Tony
