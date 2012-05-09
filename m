From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 09 May 2012 13:10:09 -0600
Message-ID: <4FAAC111.9020308@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <201205041923.07620.arnd@arndb.de> <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com> <4FA7F009.5010003@wwwdotorg.org> <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com> <4FA94B49.5050500@wwwdotorg.org> <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57162 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab2EITKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 15:10:13 -0400
In-Reply-To: <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/08/2012 01:09 PM, Jassi Brar wrote:
> On 8 May 2012 22:05, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>> The data doesn't need to be part of the DMA controller node in order for
>> the DMA controller driver to be the entity interpreting it.
>>
> I rather say, if the dma controller driver is the entity going to interpret the
> data, why not provide the data directly through its node at one go?
> 
> There is important difference between providing data via clients
> during runtime vs providing info about every client to the dmac driver
> at one go during its probe.

I certainly see that there is a difference.

I don't understand why it's an important difference; I think everything
needs to be handled at run-time no matter what:

Just because there is information in the DT that "this client DT node
uses this channel/request-ID/... of this DMA controller" doesn't mean
that the driver for the client is going to be loaded, or that SW running
on the system is going to cause that driver to actually be opened and do
any DMA. As such, any resource allocation rules etc. must be evaluated
only if/when a driver actually requests/uses a DMA channel, so having
"all the information up front" doesn't seem like a theoretically
possible thing anyway.

Very similar to this, in order to support your point that a given client
could potentially use a channel from either of 2 different DMA
controller instances, you don't know until run-time which controller
will be used, so can't have up-front information in this scenario
either, even if the DMA does actually take place.

>> The advantage here is that:
>>
>> * The specifier is stored in the client, not the IRQ/GPIO/DMA
>> controller's node, so it's located right at the usage site, which
>> typically makes working out what resources a client uses easier.
>
> A client doesn't really need some n'th channel of some m'th dma controller.
> A client simply needs one channel for transmitting data whichever
> platform it be.
> So {n,m}_channel isn't really a required resource, dma_tx is, which I  still
> specify in the client's node.
>   The fact that this information is simply fwd by the client as such to the dmac
> (via utility code), makes the ritual even more pointless.

Ah, I see your point now.

To solve this, we would need to (optionally?) model the DMA request
signal routing in the DT, so that one could explicitly model the 1:1 or
1:n situation.

And since a given DMA client might be able to use the services of 2
different DMA controllers, those controllers might not even be identical
HW, and hence would potentially not have identical DMA bindings. So,
that doesn't work; we really do need device-agnostic DMA bindings in
order to support this while maintaining all features.

That all said, do we want to:

a) Have the DT specify exactly which controller a given client will use,
i.e. pick a particular one even when multiple are possible in HW.

This is supported by the currently proposed bindings without issue; we
just ignore the fact that the DT author could have connected the client
to a different controller if they wanted.

b) Have the DT represent exactly what exists in HW, i.e. that the
client's DMA request signal is routed to N places, and have the SW pick
which to use at runtime.

You're obviously arguing for (b), and indeed that does seem more like a
simple representation of the HW, rather than SW's use of HW, and so is
indeed more appropriate.

Solving (b) seems to require something very roughly like:

dma-controller@0 {
    compatible = "foo,dmac-xxx";
    dma-requests = <
		&client0 0 // DMAC req 0 is client0's 0th req output
		&client0 1
		&client1 0
		&client1 1
		&client2 0
		...>;
};

dma-controller@1 {
    compatible = "bar,dmac-yyy";
    dma-requests = <
		// Supports some client modules, but not the same ones
		&client0 0
		&client1 0
		&client3 0
		...>;
};

client0: i2s {
    /* has 2 DMA request output signals: 0, 1 */
};

client1: spdif {
    /* has 2 DMA request signals: 0, 1 */
};

client2: foo {
    /* has 1 DMA request signal: 0 */
};

client3: bar {
    /* has 1 DMA request signal: 0 */
};

and then having the core DMA code have an API like:

channel = dma_request(clients_dma_req_output_id)

which looks in each DMA controller's dma-requests list for the client's
phandle and matching dma_req_output_id.

>> This also keeps client-specific information out of the provider node,
>> allowing it to be fully generic.
>
> A typical Samsung SoC has 2 peripheral DMA controllers and
> about 40 possible clients. Of which ~20 clients could be served by either of
> the two dmacs. Of course hardly ever a machine has 10 clients. It would be
> desirable if the dma driver doesn't populate the unused 54(32+32-10) channels,
>  presumably also reserving limited resources for each, on the machine.
> 
> Consider this example ...
> A PL330 instance has 8 physical channels and 32 client i/f.
> So only 8 client reqs could be active at any time.
> PL330 doesn't provide a way to program a true LLI transfer(very useful for
> audio) using a single physical channel. However, we could emulate
> true LLI if we employ 2 physical channels for one audio channel request.

I'm not familiar with what LLI means. I assume it's when the HW can be
programmed with 2 DMA requests, and automatically starts the second once
the first has completed, without SW intervention or interrupt latency.

> Obviously, if a machine had 7 or lesser clients, one would freely employ
> 2 physical channels for audio and yet not worry about starving other clients.
> How would we achieve this if the dmac driver was initialized as "fully
> generic" ?

Well, the DMA controller's binding could easily allow representation of
"single-channel" v.s. "double-channel" by specifying just one ID or two
IDs in the binding. It'd make the binding more complex, but it is possible.
