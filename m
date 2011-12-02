From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Fri, 2 Dec 2011 13:02:42 +0000
Message-ID: <20111202130242.GO8245@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111202122558.GM8245@opensource.wolfsonmicro.com>
 <4ED8C57B.2000503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55192 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755332Ab1LBNCo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 08:02:44 -0500
Content-Disposition: inline
In-Reply-To: <4ED8C57B.2000503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Fri, Dec 02, 2011 at 02:32:59PM +0200, Peter Ujfalusi wrote:

> As of now we receive all these information via OMAP hwmod.
> All the properties (addresses, irq, etc) of the HW IP will be coming
> from DT as soon as I can remove the ti,hwmod property.

Oh, right.  We should really be churning the device tree like this - the
idea is that the device tree should be stable and independant of kernel
versions.  It would be better if we were able to go straight to the one
without hwmod, especially if Benoit is able to get the underlying
changes done soon (which sounded like it might be the case).  Could we
define and implement the "real" version now (it should be reasonable to
code blind except possibly for the DMA channel as it's such a direct
mapping) with hwmod left in there as something that's legacy for old
kernels?
