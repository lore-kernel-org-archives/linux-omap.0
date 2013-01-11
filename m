From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC 0/4] TI LCDC DRM driver
Date: Fri, 11 Jan 2013 01:05:34 +0100
Message-ID: <1782274.DIo8UG5duX@avalon>
References: <1357704685-3600-1-git-send-email-robdclark@gmail.com> <CAPM=9tzZiQuVNdNhm9=iNWqAwk+uZRh0_YC3QLkyZbne5dfeyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:57233 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3AKADy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 19:03:54 -0500
In-Reply-To: <CAPM=9tzZiQuVNdNhm9=iNWqAwk+uZRh0_YC3QLkyZbne5dfeyg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thursday 10 January 2013 10:16:10 Dave Airlie wrote:
> On Wed, Jan 9, 2013 at 2:11 PM, Rob Clark <robdclark@gmail.com> wrote:
> > Updated version of DRM driver for TI LCD Controller.  Since the initial
> > version of the patch, which only supported TFP410 DVI output, I've added
> > an output driver for LCD panels (for example, LCD3 or LCD7 cape for the
> > beagle-bone), and initial support for HDMI output via NXP TDA19988 HDMI
> > encoder (via i2c encoder-slave output driver).
> > 
> > At this point, I think the basic lcdc drm driver plus TFP410 DVI output
> > (first patch) is in reasonable shape (barring potential rename, if lcdc
> > is too generic of a name... but I was not feeling creative enough yet to
> > pick a new name).
> 
> I'd like at least tilcdc :-)

So do I :-) The Renesas LCD controller is also called LCDC, and they called 
the fbdev driver sh_mobile_lcdcfb. tilcdc isn't *that* long in comparison :-)

-- 
Regards,

Laurent Pinchart

