From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 12:09:43 -0500
Message-ID: <4FB3DF57.6090802@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <4FB2FEBA.1030404@ti.com> <CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com> <4FB3A87C.1000000@ti.com> <4FB3CF44.4040603@ti.com> <4FB3D294.4020505@wwwdotorg.org> <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35595 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979Ab2EPRKE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 13:10:04 -0400
In-Reply-To: <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 05/16/2012 11:22 AM, Jassi Brar wrote:

[...]

> OK, my guts feel people might be interested in what's cooking on
> my side. I started with the binding text first and then would write
> code based upon that approach.
> 
> The following might be tweaked as I look deeper into client and DMAC
> drivers while deciding upon what the helper functions should be optimally...
> 
> -------------------- 8< --------------------
> 
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
> 
> * DMA Controller
> 
> Required property:
> 
> 	- #map-cells: Number of elements in each chan-map entry.
> 		At least 3 elements are required by this binding.
> 
> 	- chan-map: List of entries that specify clients' 'peri_id'.
> 		and also possibly DMAC specific per-client data.
> 		The first element of each entry being the client's
> 		phandle. The second the direction of data transfer
> 		w.r.t the client 1 for RX, 2 for TX and  3 for RX|TX.
> 		The third the 'peri_id' of the client's request signal
> 		on the DMAC.
> 
> Optional properties:
> 
> 	- #dma-peri-ifs: P, usually the DMAC driver would simply assume the
> 		number of entries in the 'chan-map' property to be the
> 		effective number of peripheral request interfaces on the
> 		DMAC. If specified, it should be at least the number of
> 		entries in the 'chan-map' property.
> 
> 	- #dma-channels: C, if specified, it should neither be more than
> 		the value of 'dma-peri-ifs' nor equal to zero.
> 		If unspecified,	it is assumed to be equal to the value of
> 		'dma-peri-ifs', i.e, C := P
> 
> 	- #private-data: Peculiarities of the DMAC setup, not taken into
> 		account by this generic model. The decoding of it would
> 		be private to the DMAC's driver. For ex, some DMAC drivers
> 		for dmaengine would specify dma_cap_mask_t for the DMAC,
> 		if they don't need to specify it on a per-client basis
> 		(i.e, via 4th element of a 'chan-map' entry).
> 
> Example:
> 
> 	dma-controller@0 {
> 		compatible = "foo,dmac-xxx";
> 		#private-data = <0x80808080>;
> 		#dma-peri-ifs = <32>;
> 		#dma-channels = <8>;
> 		#map-cells = <3>;
> 		chan-map =
> 			<&i2s1 1 2>,     /* peri_id of I2S's RX is 2 */
> 			<&i2s1 2 3>,     /* peri_id of I2S's TX is 3 */
> 			<&mmc1 3 5>,  /* peri_id of MMC's RX_TX is 5 */
> 			<&spi1 1 6>,
> 			<&spi1 2 8>,
> 			...;
> 	};
> 
> 
> * Client Controller
> 
> Required property: None.
> 	The client's DT node doesn't need any DMA specifier.
> 	Typically it would only comment about the data transfer
> 	direction associated with each of its request signal.
> 	Preferably also mentioned in the binding.
> 
> Optional property: None.

May be I am still missing something here, but in the case where a client
can use one of two dma controllers, how do you specify which to use? Who
decides?

I was under the impression that you would use the phandle of the dma
controller to specify which controller is used in the client node.

For example ...

 	i2s1: i2s@70002800 {
 	/* This controller has a request-signal for TX and RX each
 	 * i.e, the driver is going to request a channel for RX(1)
 	 * and another for TX(2).
 	 */
		dma = <dma-controller0>
 		...
 	};

Cheers
Jon
