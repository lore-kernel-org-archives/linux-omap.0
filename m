From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/5] OMAP4: hwmod: Add names for DMIC memory address
	space
Date: Thu, 24 Nov 2011 22:24:06 +0000
Message-ID: <20111124222406.GB21244@opensource.wolfsonmicro.com>
References: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com> <1322142889-12017-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53011 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736Ab1KXWYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 17:24:07 -0500
Content-Disposition: inline
In-Reply-To: <1322142889-12017-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Thu, Nov 24, 2011 at 03:54:45PM +0200, Peter Ujfalusi wrote:
> To be able to get the memory resources by name from
> the DMIC driver (for MPU and for DMA).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

There doesn't appear to be any direct dependency between the arch/arm
side and the ASoC side here so the OMAP stuff should just go in via OMAP
(assuming there's no problems, it looks good to me).
