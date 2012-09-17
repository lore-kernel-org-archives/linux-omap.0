From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 04/15] dmaengine: Pass no_wakeup parameter via
 device_prep_dma_cyclic() callback
Date: Mon, 17 Sep 2012 15:23:26 +0800
Message-ID: <20120917072323.GD1338@S2101-09.ap.freescale.net>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
 <20120917063451.GB6413@S2101-09.ap.freescale.net>
 <5056CE65.9080401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43235 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab2IQHXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 03:23:14 -0400
Received: by pbbrr13 with SMTP id rr13so8595183pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Sep 2012 00:23:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5056CE65.9080401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Barry Song <baohua.song@csr.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Vista Silicon <javier.martin@vista-silicon.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Laxman Dewangan <ldewangan@nvidia.com>

On Mon, Sep 17, 2012 at 10:16:53AM +0300, Peter Ujfalusi wrote:
> All users of this callback is updated with this patch.
> The public API (dmaengine_prep_dma_cyclic) is only used by ASoC, which has
> been updated by the previous patch.
> 
Ah, ok.  You actually changed dmaengine_prep_dma_cyclic signature before
this patch.  Sorry, I overlooked that.

-- 
Regards,
Shawn
