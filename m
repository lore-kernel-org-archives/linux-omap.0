From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 08 May 2012 10:35:21 -0600
Message-ID: <4FA94B49.5050500@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <201205041923.07620.arnd@arndb.de> <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com> <4FA7F009.5010003@wwwdotorg.org> <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59439 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab2EHQf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 12:35:26 -0400
In-Reply-To: <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/07/2012 11:19 AM, Jassi Brar wrote:
> On 7 May 2012 21:23, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/05/2012 11:10 AM, Jassi Brar wrote:
>>
>>> Hmm... there ought to be a way by which a client is handed a random 'token'
>>> via its dt node and similarly the dmac informed which channel (and with what
>>> capabilities) to allocate should it see a request coming with that token.
>>
>> I think that's the whole point of the patch.
>>
>> However, the token needs to be some driver-specific struct, since the
>> required information may be more than just a single channel or request
>> ID in general.
>>
> Well, what I call 'token' could just as well be some numerical hash of
> what you call 'driver-specific struct'.
> And I never thought we could do without h/w specific information,
> just that peculiarities lie with the dmac controllers and that's where
> the discerning should happen.
> 
> Our opinions differ in that, I believe client side shouldn't need to
> parse/decode the h/w specific parameters from data gotten via DT
> (what I call 'token' and you 'driver-specific struct') - because that is
> the key to having common client drivers working with different dma
> controllers. And yes, I don't think we could find a future proof generic
> and simple enough representation of dma resource specification in a
> DT node :)

Yes, I don't believe that follows.

The data doesn't need to be part of the DMA controller node in order for
the DMA controller driver to be the entity interpreting it.

In many existing DT bindings, the structure of the client's property is:

phandle specifier

... all possibly repeated n times if you need to represent n resources,
like n interrupts, n GPIOs, n DMA channels/...)

... where specifier is some arbitrary sequence of cells, whose size and
format are entirely determined by the driver for the node referred to by
phandle.

The parsing of this whole construct is hidden inside some utility code,
so clients simply call e.g. of_get_gpio(), which internally calls a
function in the relevant GPIO driver (as specified by the phandle) to
parse the specifier, and return whatever representation of that
specifier is required for the client to either use directly (e.g. GPIO
ID to pass to gpio_request()) or pass back to the relevant APIs for the
driver's subsystem (e.g. complete possibly driver-specific DMA
filter/data representation for dmaengine).

The advantage here is that:

* The specifier is stored in the client, not the IRQ/GPIO/DMA
controller's node, so it's located right at the usage site, which
typically makes working out what resources a client uses easier. This
also keeps client-specific information out of the provider node,
allowing it to be fully generic.

* The client doesn't know anything about the format of "specifier",
since the provider driver parses it, so clients can still work with
arbitrary providers of resources.

> Instead, I suggest we encode the finer details of each channel-request
> in node of the dma controller matched against the 'token' assigned
> to the respective clients.

Well, I guess I addressed that above - there's no need for the data to
be in the DMA controller node for the DMA controller driver to parse it.

> That encoding("channel_id") would be dma
> controller specific and if we also manage to contain it within fixed number
> of bytes we could also have common helpers for fetching it,

I don't think there's any need for it to fit into a fixed number of
bytes; the parsing routine can simply return a pointer to a
driver-specific structure (or perhaps a dmaengine-defined structure,
which in turn might contain a pointer to a driver-specific structure).
That would allow complete flexibility in the representation of the
driver-specific data.

> though
> it still would need to be decoded by dmac controller driver - which I think
> we can't do without, considering the variety of dma floating around.
