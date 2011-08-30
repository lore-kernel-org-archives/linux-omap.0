From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/3] ASoC: tpa6130a2: model handling cleanup
Date: Tue, 30 Aug 2011 16:38:50 +0300
Message-ID: <4E5CE7EA.4000101@bitmer.com>
References: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:60718 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab1H3NjE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 09:39:04 -0400
In-Reply-To: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 08/30/2011 02:39 PM, Peter Ujfalusi wrote:
> Hello,
>
> Small cleanup for the tpa6130a2 driver for model handling:
> Remove the model_id from platform_data, and use the device name/device_data
> to distinguish between the supported models of TPA.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>    ASoC: tpa6130a2: Model support cleanup
>    OMAP: RX51: No need to configure the tpa_model
>    ASoC: tpa6130a2: Remove model_id from platform data
>
>   arch/arm/mach-omap2/board-rx51-peripherals.c |    1 -
>   include/sound/tpa6130a2-plat.h               |    6 ------
>   sound/soc/codecs/tpa6130a2.c                 |   12 +++++++++---
>   3 files changed, 9 insertions(+), 10 deletions(-)
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

