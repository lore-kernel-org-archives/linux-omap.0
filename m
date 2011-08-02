From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: OMAP4: McPDM: Convert to hwmod/omap_device
Date: Wed, 3 Aug 2011 01:07:11 +0900
Message-ID: <20110802160710.GH25884@opensource.wolfsonmicro.com>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
 <1312284857-1774-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50723 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754258Ab1HBQHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 12:07:17 -0400
Content-Disposition: inline
In-Reply-To: <1312284857-1774-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

On Tue, Aug 02, 2011 at 02:34:17PM +0300, Peter Ujfalusi wrote:
> In order to probe, and operate correctly, the OMAP McPDM driver needs to
> be converted to use hwmod.
> The device name has been changed to probe the driver.
> Replace the clk_* with pm_runtime_* calls to manage the clocks correctly.
> Missing request_mem_region/release_mem_region added.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
