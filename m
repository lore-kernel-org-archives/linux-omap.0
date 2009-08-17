From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][PATCH 2/3] ASoC: OMAP: Make use of DMA channel self
 linking on OMAP1510
Date: Mon, 17 Aug 2009 12:18:58 +0300
Message-ID: <20090817121858.fe80fb95.jhnikula@gmail.com>
References: <200908101050.05314.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:60311 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757528AbZHQJR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 05:17:27 -0400
In-Reply-To: <200908101050.05314.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 10 Aug 2009 10:50:04 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Use newly implemented DMA channel self linking on OMAP1510 like on other OMAP
> models. Remove unnecessary DMA transfer restart from interrupt handler
> routine.
> 
> The interrupt routine used to maintain a period index, originally needed for
> counting up periods up to a full buffer in order to restart the DMA transfer.
> For some time, this counter is also used as a replacement for hardware DMA
> progress counter that has been found unusable on OMAP1510 in case of playback.
> Thus, the period index calculation cannot be omitted completely. However, the
> accuracy of this counter can still suffer from missing DMA interrupts.
> 
> In order to work correctly, it requires patch 1 from this series also applied:
> [RFC][PATCH 1/3] ARM: OMAP: DMA: Add support for DMA channel self linking on OMAP1510
> 
> Created against linux-2.6.31-rc5.
> 
> Tested on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
Nice to see code to be more uniform across the OMAP's. Note this
depends on patch 1 which touches the arch/arm/plat-omap/dma.c.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
