From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3 05/15] dmaengine: omap-dma: Add support to suppress
 interrupts in cyclic mode
Date: Mon, 17 Sep 2012 15:30:21 +0530
Message-ID: <1347876021.1943.149.camel@vkoul-udesk3>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
	 <1347624358-25582-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11557 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab2IQKEZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Sep 2012 06:04:25 -0400
In-Reply-To: <1347624358-25582-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> When requested (DMA_PREP_INTERRUPT is cleared in flags) disable all
> DMA
> interrupts for the channel. In this mode user space does not expect
> periodic reports from kernel about the progress of the audio stream.
> PulseAudio for example support this type of mode.
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod

