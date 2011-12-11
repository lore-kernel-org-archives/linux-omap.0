From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Sun, 11 Dec 2011 11:20:47 +0800
Message-ID: <20111211032046.GH2800@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111203112206.GE6043@opensource.wolfsonmicro.com>
 <4EDCCAE0.2000009@ti.com>
 <20111205154611.GV11150@opensource.wolfsonmicro.com>
 <4EDF27A5.7090909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58132 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785Ab1LKDVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Dec 2011 22:21:40 -0500
Content-Disposition: inline
In-Reply-To: <4EDF27A5.7090909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Wed, Dec 07, 2011 at 10:45:25AM +0200, Peter Ujfalusi wrote:

> I felt it is the right thing to document the current situation.

If we're going to document bindings like this it feels like we should
have a split in the directories in the same way that we handle the
different stability levels for sysfs documentation.

> The documentation will be updated as we can move away from the
> "ti,hwmods" tag from DT.
> I can place comment in the documentation for omap-dmic, omap-mcpdm
> stating that the use of "ti,hwmods" is required at the moment, but it is
> temporally solution.

At the very least, yes.
