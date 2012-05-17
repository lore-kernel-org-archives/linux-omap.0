From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 17 May 2012 09:35:39 +0530
Message-ID: <CAJe_ZheKUoM+UjagtfmqLha-vwQr4J+CdEjvtR8t0cmdOQJPyw@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<4FB3D294.4020505@wwwdotorg.org>
	<CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
	<201205161942.20296.arnd@arndb.de>
	<4FB43F69.1070608@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42331 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750896Ab2EQEFl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 00:05:41 -0400
Received: by lahd3 with SMTP id d3so1027961lah.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 21:05:40 -0700 (PDT)
In-Reply-To: <4FB43F69.1070608@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 17 May 2012 05:29, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>
>>> Generic binding to provide a way to provide the client-channel map =
and
>>> other dmac specific parameters to the dma controller driver
>>>
>>> DMA Model:-
>>> =A0 Only the most common characteristics of a dma setup are assumed
>>> in this binding.
>>> Client: Some h/w controller that could request a DMA controller in
>>> the system to perform data transfer on its behalf. Example SPI, MMC=
,
>>> I2S etc.
>>> DMAC: A DMA Controller instance. Example, PL330, PL08X, SDMA etc.
>>>
>>> =A0The assumed model of the DMAC, in this binding, has P peripheral
>>> interfaces (P request signals) that could request a data transfer
>>> and C physical channels that actually do the data transfers, hence,
>>> at most C out of P peripherals could be served by the DMAC at any
>>> point of time. Usually C :=3D P, but not always. Usually, any of th=
e
>>> physical channels could be employed by the DMAC driver to serve any
>>> client.
>>> =A0The DMAC driver identifies a client by its i/f number, 'peri_id'
>>> on the given DMAC. For example, TX for SPI has 7th while RX_TX
>>> (half-duplex) for MMC has 10th peripheral interface (request-signal=
)
>>> on a given DMAC. Usually, any of the physical channels could be
>>> employed by the DMAC driver to serve a client.
>>
>> I'm still anything but convinced by this model. Basically it's the
>> exact opposite of what we do for every other subsystem (irq, pinctrl=
,
>> regulator, gpio, ...), where the device using some infrastructure
>> contains the information about who provides it, whereas here you
>> move all the information into the device that provides the functiona=
lity,
>> and have no handle in the device using it by which the driver can
>> identify it.
>
> Yes, I guess this is backwards. But, the HW is a little different too=
;
> GPIOs (and probably interrupts) don't have multiple places they could
> come from.
>
> The problem is that if we did something like this in the DMA client:
>
> dma-reqs =3D <&dmac1 DMAC1_DMA_REQ_6 &dmac1 DMAC1_DMA_REQ_8>;
>
> how do we know if the client is emitting 2 DMA request signals that g=
et
> routed to two different inputs on the DMA controller, or whether this=
 is
> two alternatives for the same signal.
>
=46WIW, I wouldn't lose sleep over the possibility of redundancy on sam=
e DMAC.
If a client's request signal is routed to 2 inputs, they are usually
on different DMACs.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
