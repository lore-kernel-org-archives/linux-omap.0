From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Mon, 5 Dec 2011 15:46:11 +0000
Message-ID: <20111205154611.GV11150@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111203112206.GE6043@opensource.wolfsonmicro.com>
 <4EDCCAE0.2000009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40737 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932348Ab1LEPqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 10:46:14 -0500
Content-Disposition: inline
In-Reply-To: <4EDCCAE0.2000009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Mon, Dec 05, 2011 at 03:45:04PM +0200, Peter Ujfalusi wrote:
> On 12/03/2011 01:22 PM, Mark Brown wrote:

> > Actually thinking about this some more I think what's concerning me is
> > the documentation as much as anything else - if it was just an internal,
> > unpublished interface of the OMAP core code which happened to use device
> > tree I probably wouldn't have worried about it churning.

> Actually it is documented here:
> Documentation/devicetree/bindings/arm/omap/omap.txt

That's not exactly the point...

> In order to move all OMAP drivers to DT - as Benoit already mentioned -
> we need additional work in DT.
> At this point of time if we add the DT representation we anyways need to
> change it as the core will receive the features, and we still need to
> fall back to hwmod to get the drivers working.
> As soon as we can migrate away from the hwmod we will do, but having
> this in place helps us to migrate other parts to DT.

And what I'm saying is that my main concern is that you're publishing
documenting a binding which isn't intended to be the the final binding
and which there's no intention that anyone should use directly anyway.
