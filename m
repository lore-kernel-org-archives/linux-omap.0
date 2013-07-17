From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Wed, 17 Jul 2013 13:00:21 +0200
Message-ID: <2989497.8E7gzkcamn@avalon>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2883016.87pKJk9n0R@avalon> <51E4C073.4020407@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:60764 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab3GQK7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 06:59:38 -0400
In-Reply-To: <51E4C073.4020407@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Stephen,

On Monday 15 July 2013 21:39:31 Stephen Warren wrote:
> On 07/15/2013 07:10 PM, Laurent Pinchart wrote:
> > On Friday 12 July 2013 08:42:41 Stephen Warren wrote:
> ...
> 
> >> I think the values for any common system-wide flags should be defined
> >> once in some system-wide place, and the values for any HW-specific
> >> values should be defined only in the documentation for that specific HW.
> >> You could try and avoid conflicts by either:
> >> 
> >> a) Allocating system-wide flags from bit 0 up, and HW-specific flags
> >> from bit 31 down.
> >> 
> >> or:
> >> 
> >> b) Using 1 cell for standard flags, and a separate cell for any
> >> HW-specific flags. Drivers can quite easily adapt to adding extra cells
> >> to #pwm-cells, thus making adding a HW-specific cell later
> >> backwards-compatible.
> > 
> > I wasn't referring to HW-specific flags, but rather to system-wide flags
> > that might not be supported by all drivers. If we later add new
> > system-wide flags I think the individual DT bindings should explicitly
> > document which flags they support.
> 
> Shouldn't all system-wide flags be supported by all HW, perhaps being
> implemented by the core subsystem rather than individual drivers to
> ensure that? Consider the case of the GPIO active-low flag which is
> actually implemented in SW, hence can work with any GPIO controller.
> 
> Perhaps that's not possible in all cases, in which case, yes, it does
> make sense to define which of the common flags a particular HW module
> supports.

It largely depends on what we consider as system flags. We should probably be 
talking about common flags instead of system flags. I usually try to 
standardize DT properties that are common to multiple devices. Some of those 
properties can apply to all devices of the same class (possibly 
implemented/emulated in software when the hardware doesn't support them), but 
others are just commonly seen properties that don't make sense for all the 
devices.

One example I'm familiar with can be found in V4L2 DT bindings. We've 
standardized properties to specify what kind of video synchronization signals 
devices support/use. Not all synchronization signals are supported by a given 
video transmitter, so DT bindings for such chips list (or at least should 
list) the common properties supported by a given device. The definitions of 
the properties should of course not be duplicated to all individual DT 
bindings.

> But then there's a problem where people assume that the common flags are
> always available, and somewhere they aren't... Care is needed in the
> choice of which common flags to define and/or how they're used.

Exactly. That's why I think listing the supported common flags in individual 
bindings makes sense when some of the flags are not supported by all devices. 
As the only PWM flags currently used are common to all PWM devices I can leave 
this out now. I have no strong preference, I'll follow your opinion on this.

-- 
Regards,

Laurent Pinchart

