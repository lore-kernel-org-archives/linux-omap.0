From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Sat, 5 May 2012 22:40:58 +0530
Message-ID: <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<4FA3F308.6030900@ti.com>
	<CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
	<201205041923.07620.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64480 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757305Ab2EERLA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 May 2012 13:11:00 -0400
Received: by lbbgm6 with SMTP id gm6so2675887lbb.19
        for <linux-omap@vger.kernel.org>; Sat, 05 May 2012 10:10:59 -0700 (PDT)
In-Reply-To: <201205041923.07620.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jon-hunter@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 5 May 2012 00:53, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 04 May 2012, Jassi Brar wrote:
>> I see this requires a client driver to specify a particular req_line on a
>> particular dma controller. I am not sure if this is most optimal.
>>
>> I think such client->req_line map should be provided to the dmac controller
>> driver via its dt node in some format. The dmac driver could then populate
>> a dma_chan, or similar, only for that req_line and not for the unused one
>> which otherwise could also have served the same client.
>>
>> Ideally the I2C driver should simply ask, say, a channel for TX and another
>> for RX, everything else should already be setup via dmac's dt nodes.
>
> If I understand you correctly, you think we can generalize the dma-request
> data in a way that we don't need to pass a specific dma engine phandle.
> I very much doubt this is possible, given how different the requirements
> are for each of the engines we support. You really need to pass a specific
> phandle so that we can find the code that can interpret the data in a
> meaningful way.
>
Hmm... there ought to be a way by which a client is handed a random 'token'
via its dt node and similarly the dmac informed which channel (and with what
capabilities) to allocate should it see a request coming with that token.

That way dmac and client drivers using DT could do away with the filter_fn.

Roughly speaking (I am not very well versed with DT syntax)

Client Node:-

mmc1: mmc@13002000 {
        ...
        dma_tx = <891>   //some platform-wide unique value
        dma_rx = <927>   //some platform-wide unique value
        ...
 };


Say the PL330 chapter of SoC's trm specifies that "channel_id" for
MMC1_TX is 7 and MMC1_RX is 8 on second instance of PL330.

DMAC's Node:-

pdma2: pdma@10800000 {
         .......
        dma_map = <891, 7>,       //Map mmc1_tx onto i/f 7
                              <927, 8>,      //Map mmc1_rx onto i/f 8
                              <487, 9>,      // Map other dma clients
                                    .......
};

The dma_map could also encode features like duplex, priority etc
depending on the needs of the client and capability of the dmac.
(The "channel_id" could very well be an composite value specifying
more than one parameter.... basically a value private to the dmac driver)

As a positive side effect, the dmac controller could populate channels only
for which some client exists on the machine.

Also the decision to map a client onto one of two or more supporting dmacs
is made here - token 927 wouldn't appear in dma_map of pdma1 even
if it also could do RX for MMC1.

The solution seems so simple that I am already cringing at the thought
of having overlooked something fundamental. Please clarify :)
