From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 17:59:37 -0600
Message-ID: <4FB43F69.1070608@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FB3D294.4020505@wwwdotorg.org> <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com> <201205161942.20296.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52750 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760743Ab2EPX7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 19:59:42 -0400
In-Reply-To: <201205161942.20296.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/16/2012 01:42 PM, Arnd Bergmann wrote:
> On Wednesday 16 May 2012, Jassi Brar wrote:
>> On 16 May 2012 21:45, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>>
>> Generic binding to provide a way to provide the client-channel map and
>> other dmac specific parameters to the dma controller driver
>>
>> DMA Model:-
>>   Only the most common characteristics of a dma setup are assumed
>> in this binding.
>> Client: Some h/w controller that could request a DMA controller in
>> the system to perform data transfer on its behalf. Example SPI, MMC,
>> I2S etc.
>> DMAC: A DMA Controller instance. Example, PL330, PL08X, SDMA etc.
>>
>>  The assumed model of the DMAC, in this binding, has P peripheral
>> interfaces (P request signals) that could request a data transfer
>> and C physical channels that actually do the data transfers, hence,
>> at most C out of P peripherals could be served by the DMAC at any
>> point of time. Usually C := P, but not always. Usually, any of the
>> physical channels could be employed by the DMAC driver to serve any
>> client.
>>  The DMAC driver identifies a client by its i/f number, 'peri_id'
>> on the given DMAC. For example, TX for SPI has 7th while RX_TX
>> (half-duplex) for MMC has 10th peripheral interface (request-signal)
>> on a given DMAC. Usually, any of the physical channels could be
>> employed by the DMAC driver to serve a client.
> 
> I'm still anything but convinced by this model. Basically it's the
> exact opposite of what we do for every other subsystem (irq, pinctrl,
> regulator, gpio, ...), where the device using some infrastructure
> contains the information about who provides it, whereas here you
> move all the information into the device that provides the functionality,
> and have no handle in the device using it by which the driver can
> identify it.

Yes, I guess this is backwards. But, the HW is a little different too;
GPIOs (and probably interrupts) don't have multiple places they could
come from.

The problem is that if we did something like this in the DMA client:

dma-reqs = <&dmac1 DMAC1_DMA_REQ_6 &dmac1 DMAC1_DMA_REQ_8>;

how do we know if the client is emitting 2 DMA request signals that get
routed to two different inputs on the DMA controller, or whether this is
two alternatives for the same signal.

Perhaps we can separate each logical request into separate properties.
This will make the simple case slightly more complex, since there are n
properties rather than n entries in each property, but still allow the
more complex case:

Simple case:

/* e.g. FIFO TX DMA req - 2 DMACs possible */
dma-req-0 = <&dmac1 DMAC1_DMA_REQ_6>;
/* e.g. FIFO RX DMA req 1 DMAC possible */
dma-req-1 = <&dmac1 DMAC1_DMA_REQ_8>;

Multiple DMAC case:

/* e.g. FIFO TX DMA req - 2 DMACs possible */
dma-req-0 = <&dmac1 DMAC1_DMA_REQ_6 &dmac2 DMA_2_DMA_REQ_8>;
/* e.g. FIFO RX DMA req 1 DMAC possible */
dma-req-1 = <&dmac1 DMAC1_DMA_REQ_8>;

Then, when the DMA client calls the standard API to "get DMA channel for
my outbound DMA request "n", the core code will kasprintf("dma-req-%d",
n); to generate the property name. That's how pinctrl works.

Does that seem better?
