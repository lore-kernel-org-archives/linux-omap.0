From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 19:42:20 +0000
Message-ID: <201205161942.20296.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FB3D294.4020505@wwwdotorg.org> <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62634 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964799Ab2EPTme (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 15:42:34 -0400
In-Reply-To: <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 16 May 2012, Jassi Brar wrote:
> On 16 May 2012 21:45, Stephen Warren <swarren@wwwdotorg.org> wrote:

> 
> Generic binding to provide a way to provide the client-channel map and
> other dmac specific parameters to the dma controller driver
> 
> DMA Model:-
>   Only the most common characteristics of a dma setup are assumed
> in this binding.
> Client: Some h/w controller that could request a DMA controller in
> the system to perform data transfer on its behalf. Example SPI, MMC,
> I2S etc.
> DMAC: A DMA Controller instance. Example, PL330, PL08X, SDMA etc.
> 
>  The assumed model of the DMAC, in this binding, has P peripheral
> interfaces (P request signals) that could request a data transfer
> and C physical channels that actually do the data transfers, hence,
> at most C out of P peripherals could be served by the DMAC at any
> point of time. Usually C := P, but not always. Usually, any of the
> physical channels could be employed by the DMAC driver to serve any
> client.
>  The DMAC driver identifies a client by its i/f number, 'peri_id'
> on the given DMAC. For example, TX for SPI has 7th while RX_TX
> (half-duplex) for MMC has 10th peripheral interface (request-signal)
> on a given DMAC. Usually, any of the physical channels could be
> employed by the DMAC driver to serve a client.

I'm still anything but convinced by this model. Basically it's the
exact opposite of what we do for every other subsystem (irq, pinctrl,
regulator, gpio, ...), where the device using some infrastructure
contains the information about who provides it, whereas here you
move all the information into the device that provides the functionality,
and have no handle in the device using it by which the driver can
identify it.

I believe that it can work and that it solves the problem you are
faced with at minimal complexity, but you put the burden of this
complexity on everybody who does not have this issue, and make
the general binding confusing and harder to read. It also adds
much more data to the device tree (in source and binary form)
because you need to describe every device using a dma controller
and have a label to reference it. More importantly, you make it
very hard to add devices in a board file to a dma controller
that already has descriptions for some channels, because you
cannot easily extend the chan-map unless you rewrite all of it.

We really need something simpler than this for the common case.
I have already made suggestions for how to make it still possible
to cover the corner case of multiple dma engines connected to the
same slave, which would keep the complexity local to those devices
that actually need it.

	Arnd
