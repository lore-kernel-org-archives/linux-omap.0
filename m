From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] arm: omap: display: Ensure DRM/FB/V4L devices
 are created if DSS is available
Date: Tue, 8 Oct 2013 14:06:25 -0700
Message-ID: <20131008210625.GP8313@atomide.com>
References: <1379315911-24634-1-git-send-email-archit@ti.com>
 <5236C63A.9000709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10693 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756501Ab3JHVG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 17:06:27 -0400
Content-Disposition: inline
In-Reply-To: <5236C63A.9000709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130916 01:57]:
> On 16/09/13 10:18, Archit Taneja wrote:
> > Currently, omapdrm, omapfb and omap_vout platform devices are created and
> > registered through omap_arch_initcalls. In a multiplatform config. It's
> > possible that all the corresponding configs for the above drivers along with
> > omapdss config are selected even if the hardware doesn't have a DSS IP.
> > 
> > If the image is booted on a AM33xx platform, the above drm, fb and v4l devices
> > would be registered throuth the omap_arch_initcalls even if omapdss itself isn't
> > registered. These platform devices don't cause any harm, but are unnecessary.
> > 
> > Move the registration of these devices into omap_display_init(), which registers
> > omapdss devices and is called only if the platform has DSS hardware.
> > 
> > Also, the first patch prevents creation of a DMM device when omapdrm device is
> > registered. With the removal of address and irq data from the omap4 hwmods, the
> > probe of DMM driver fails and omapdrm isn't able to utilize the DMM hardware.
> > This will be fixed when DMM DT nodes are added for omap4, omap5 and dra7x.
> > 
> > Changes in v2:
> > - Move device creation for omapfb and omap_vout to omap_display_init too.
> > - Keep the DMM DT conversion as a separate patch series since this series does
> >   something different now.
> > 
> > Archit Taneja (4):
> >   arm: omap: drm: Don't build device for DMM
> >   arm: omap: display: Create omapdrm device inside omap_display_init
> >   arm: omap: display: Create omapvrfb and omapfb devices inside
> >     omap_display_init
> >   arm: omap: display: Create omap_vout device inside omap_display_init
> > 
> >  arch/arm/mach-omap2/Makefile  |  6 +-----
> >  arch/arm/mach-omap2/devices.c | 10 +++++-----
> >  arch/arm/mach-omap2/display.c | 28 ++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/display.h |  4 ++++
> >  arch/arm/mach-omap2/drm.c     | 24 +++++-------------------
> >  arch/arm/mach-omap2/fb.c      | 14 +++++++-------
> >  6 files changed, 50 insertions(+), 36 deletions(-)
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Tony, since there are no driver changes here, and it's unlikely that
> we'd have a conflict between the dss driver changes and these changes, I
> think it's best if this goes through linux-omap.

OK applying into omap-for-v3.13/display, thanks.

Tony
