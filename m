From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 10:15:16 -0600
Message-ID: <4FB3D294.4020505@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <4FB2FEBA.1030404@ti.com> <CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com> <4FB3A87C.1000000@ti.com> <4FB3CF44.4040603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60526 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2EPQPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 12:15:21 -0400
In-Reply-To: <4FB3CF44.4040603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/16/2012 10:01 AM, Jon Hunter wrote:
...
> By the way, I do see your point. You wish to describe the all the
> mappings available to all dma controllers and then set a mapping in the
> device tree. Where as I am simply setting a mapping and do not list all
> other possibilities (assuming that there some).
> 
> What is still unclear to me, is if you use this token approach how
> readable is the device-tree? For example, if you have a client that can
> use one of two dmac and for each dmac the request/channel number is
> different, then by using a global token how can I determine what the
> options available for this client are?
> 
> Take your example ...
> 
> mmc1: mmc@13002000 {
>         ...
>         dma_tx = <891>   //some platform-wide unique value
>         dma_rx = <927>   //some platform-wide unique value
>         ...
> };

I believe those properties (in the DMA client) should be completely
omitted; there's no need for them.

Also, we definitely should not be using "some platform-wide unique
value", but rather the phandle of the DMA client, plus some
client-defined client channel ID. ...

(oh, and - rather than _ is idiomatic for DT property names)

> DMAC's Node:-
> 
> pdma2: pdma@10800000 {
>          .......
> 	dma_map = <891, 7>,       // Map mmc1_tx onto i/f 7
> 		  <927, 8>,       // Map mmc1_rx onto i/f 8
> 	.......
> };

So this would become:

pdma2: pdma@10800000 {
	.......
	dma-map =
		... entries for channels 0.. 6
		<&mmc1, 0>,       // Map mmc1_tx onto i/f 7
		<&mmc1, 1>,       // Map mmc1_rx onto i/f 8
		... ;
	.......
};

This (a) follows existing DT practice of using phandle + specifier, and
(b) makes it easy to know exactly what clients you're talking about,
since all you need to do is search for the label "mmc1" throughout the DT.

> But now I have another dmac which has the following options ...
> 
> pdma1: pdma@10000000 {
>          .......
> 	dma_map = <598, 2>,       // Map mmc1_tx onto i/f 2
> 		  <230, 3>,       // Map mmc1_rx onto i/f 3
> 	.......
> };

Which would become something very similar:

pdma1: pdma@10000000 {
	.......
	dma-map =
		... entries for channels 0.. 1
		<&mmc1, 0>,       // Map mmc1_tx onto i/f 2
		<&mmc1, 1>,       // Map mmc1_rx onto i/f 3
		... ;
	.......
};

Note that dma-map here is describing the list of DMA requests that the
DMA controller knows about. As far as the binding goes, these are
irrelevant to channels; only the driver for the DMAC knows whether it
needs to use a specific channel ID to service a particular DMA request
signal, or not.

> Other than using a comment or yet another token to represent the client,
> it is not clear from the arbitrary token value itself what my options are.
> 
> One way around this would be to have an enable/disable flag along with
> the token such as ...
> 
> mmc1: mmc@13002000 {
>         ...
>         dma_tx = <891, 1>   // default tx channel
>         dma_rx = <927, 1>   // default rx channel
>         dma_tx = <598, 0>   // other available tx channel
>         dma_rx = <230, 0>   // other available rx channel
>         ...
> };
> 
> That being said, we could take the same approach with using the dmac
> phandle instead of the token. So you would have ...
> 
> 
> mmc1: mmc@13002000 {
>         ...
> 		// phandle + channel + enable/disable
>         dma_tx = <pdma0, 7, 1>   // default tx channel
>         dma_rx = <pdma0, 8, 1>   // default rx channel
>         dma_tx = <pdma1, 2, 0>   // other available tx channel
>         dma_rx = <pdma1, 3, 0>   // other available rx channel
>         ...
> };
> 
> Then you could eliminate the random token and dma map from the dmac.
> Seems easier to read too.
