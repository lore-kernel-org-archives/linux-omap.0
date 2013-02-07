From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] ARM: dts: Add DT bindings for OMAP SDMA
Date: Thu, 07 Feb 2013 15:01:18 +0100
Message-ID: <1896741.qGDZiL1IcG@wuerfel>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com> <5113A98D.1000209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51700 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758654Ab3BGOBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 09:01:31 -0500
In-Reply-To: <5113A98D.1000209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jon Hunter <jon-hunter@ti.com>, Matt Porter <mporter@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Balaji T K <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>

On Thursday 07 February 2013 14:18:05 Peter Ujfalusi wrote:
> I looked briefly around in the mentioned code and I wonder how this is going
> to work with audio (ASoC).
> When we boot with DT it looks like we are _not_ creating the DMA resources for
> the device as it is done for the IRQ and IO/MEM. So this means that we can not
> use get_resource*() for DMA anymore when we move to DT.

Yes, this is very much intentional. The use of DMA resources is not
really possible across platforms, and I would like to kill it off
entirely, as it is not clearly defined what they actually mean.
In many cases, a single number cannot express the configuration
for a DMA channel, e.g. when you have multiple DMA engines in the
system, or you have one that can drive multiple masters for instance.

While we could in theory extend the infrastructure around DMA resources
to behave like IRQ resources, which can deal with all of that, this
would require a lot of code, and go against the trend: in case of
GPIO numbers and IRQ numbers, people are generally trying to
find ways to get rid of a flat number space and use a more structured
interface.

> This might be OK for (OMAP)mmc, (OMAP)spi, etc. But in audio we have a common
> library used by all platforms to deal with the dmaengine.
>
> I don't think we can switch to use dma_request_slave_channel_compat() in
> soc-dmaengine-pcm.c. We need to pass the dma channel number to the lib from
> the ASoC platform drivers. Or we need to synchronize the order of the dmas and
> the dma-names around all SOCs in existence?
> 
> Has anyone thought about this?

It's the first time I look at the sounds specific portion of this,
but it seems straightforward:

snd_dmaengine_pcm_open is a wrapper around dma_request_channel
and requires a filter function plus data as arguments. We don't
want to use filter functions here any more because they don't
do what we need, so the logical conclusion is to add a similar
wrapper around dma_request_slave_channel, and port drivers to
use that instead.

I see no connection in ASoC between the use of IORESOURCE_DMA
and snd_dmaengine_pcm_open. About half of the drivers calling
that function get the argument from a dma resource, while the
other ones don't. Similarly, not all ASoC drivers using DMA
resources pass the contents of that into snd_dmaengine_pcm_open.

	Arnd
