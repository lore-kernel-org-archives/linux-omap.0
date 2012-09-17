From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3 03/15] dmaengine: Add flags parameter to
 dmaengine_prep_dma_cyclic()
Date: Mon, 17 Sep 2012 15:28:59 +0530
Message-ID: <1347875939.1943.147.camel@vkoul-udesk3>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
	 <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26391 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab2IQKDF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Sep 2012 06:03:05 -0400
In-Reply-To: <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> With this parameter added to dmaengine_prep_dma_cyclic() the API will
> be in
> sync with other dmaengine_prep_*() functions.
> The dmaengine_prep_dma_cyclic() function primarily used by audio for
> cyclic
> transfer required by ALSA, we use the from audio to ask dma drivers to
> suppress interrupts (if DMA_PREP_INTERRUPT is cleared) when it is
> supported
> on the platform.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Lars-Peter Clausen <lars@metafoo.de>
> --- 
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>


-- 
~Vinod

