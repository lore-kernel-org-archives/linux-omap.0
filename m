From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global data
Date: Wed, 8 May 2013 10:54:48 +0800
Message-ID: <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com> <5189B7BF.8070607@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:57021 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab3EHCzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 22:55:09 -0400
In-Reply-To: <5189B7BF.8070607@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>
> This probably could be initialized from some DT property. However,
> there's no such property defined right now, and considering that DT is
> supposed to be an ABI, we'd always need the code in this patch as a
> fallback for DTs that were created before any such property was defined.
>
> Equally, since the data is SoC-specific rather than board-specific, and
> is even fairly unlikely to vary between SoC versions since these values
> are all 0xffffffff anyway, I don't really see much point in putting it
> into DT, rather than just putting the static data into the driver.

I mean there is already dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
at function of_platform_device_create, why can't add
dev->dev.dma_mask = &dev->dev.coherent_dma_mask after that?

If DT core can do above things, can we delete dma_mask assignment
at every driver?


--
BR,
Peter Chen
