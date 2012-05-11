From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 11 May 2012 13:28:08 -0600
Message-ID: <4FAD6848.40700@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <201205041923.07620.arnd@arndb.de> <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com> <4FA7F009.5010003@wwwdotorg.org> <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com> <4FA94B49.5050500@wwwdotorg.org> <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com> <4FAAC111.9020308@wwwdotorg.org> <CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com> <4FABF445.3030105@wwwdotorg.org> <CAJe_ZhduQuHnFyF20VnjZW9uz1szwL6O7=ow+tMqanmeHs58pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:32827 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488Ab2EKT2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 15:28:13 -0400
In-Reply-To: <CAJe_ZhduQuHnFyF20VnjZW9uz1szwL6O7=ow+tMqanmeHs58pQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/10/2012 01:59 PM, Jassi Brar wrote:
> On 10 May 2012 22:30, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/09/2012 03:38 PM, Jassi Brar wrote:
> 
>>> One point is about 'qos' here.... something like bandwidth allocation.
>>> If the dmac driver knew up-front the max possible clients that could be
>>> active simultaneously, it could "divide the bandwidth" accordingly.
>>> Again, the example of PL330 employing 2physical channels for better
>>> service - LLI (you got it right), where even 1 physical channel would
>>> also have served only not as reliably. I believe there would be
>>> more such scenarios.
>>
>> QoS seems like policy to me, whereas DT is more about describing the HW.
>> Is DT the correct place to describe QoS policy?
>>
>> I guess you are talking more about deriving policy from the description
>> of HW, i.e. how many client described in DT.
>
> Yeah, that's what I meant.
> 
>> However, for some reason that seems dangerous to me; what if clients
>> can be instantiated some other way?
>
> The other way could be hotplug ?

Yes. Also, there's probably some mix of DT-driven and non-DT-driven
instantiation during the transition to DT, although that's probably
temporary.

> Anyway in those machines every channel would be populated
> and dmac driver would always account for the all-ports-plugged case.
> 
>> For a 1:1 mapping (or 1:n mapping in HW with static selection specified
>> in the DT) between DMA client and DMA controller, perhaps the controller
>> can indeed make QoS decisions based on which (how many) clients are
>> connected to it.
>>
>> However, if a DMA client can be serviced by more than 1 DMA engine, and
>> the decision as to which DMA engine to use occurs at run-time by the DMA
>> driver core, rather than being statically configured in the DT, then the
>> DMA controller drivers cannot know ahead of time which will be used
>
> I think the dmac driver would make use of the routing flexibility to sustain its
> 'qos', and not the other way around (decide qos based on which one of the
> two dmacs would provide a channel to a client in future).
> Anyways, so far only Samsung SoCs seem to have that flexibility/redundancy
> and I have never had anyone asking for that runtime decision making.
> 
>>> The minor difference being, you use the {request-signal, phandle} pair
>>> to find the right channel, I used only 'token'.
>>
>> That's a pretty big difference, I think.
>>
>> In your proposal, every token was globally unique (well, within the 1 DT
>> file). I'd rather not see any more global numbering schemes.
>
> Probably my shallow experience, but "globally unique, within a file" sounds
> like an oxymoron :)

To the kernel, that one file describes everything it knows about the HW
(except for probed information), so it's global:-) Aside from that, I've
often seen the term "global" used relative to some specific scope.

> I think arbitrary numerical tokens are a reasonable price to pay for the
> robustness and simplicity they bring.

I have to disagree here.

Using phandle+ID is almost as simple, and much more flexible. Global IDs
have a number of disadvantages:

a) You have to somehow keep them unique. Even with just a single .dts
file, that's going to be a little painful since there's no central table
of these IDs.

What if the DT is composed of a bunch of chunks that represent pluggable
boards, which may be mixed/matched together depending on what the user
actually plugged in? Then, you have to be very careful to keep the n
different files' numbering ranges segregated, or conflicts will occur.

b) Everything else in DT already uses phandle+ID, so doing the same
thing would be much more familiar and consistent for DT users.

>> Now, DMA requests are signals /from/ a DMA client to a DMA controller
>> ("send more data please", or "pull more data please"). Hence, I assert
>> that the phandle should refer to the DMA client, not the DMA controller.
>
> OK, though we may just want to convey information about the h/w setup
> from the s/w POV, rather than info to simulate the h/w  ;)

DT is specifically about describing the HW from a HW perspective.

> For ex, the dma api and controller drivers don't really care about
> the fact that the client's driver must set some bit to trigger operation,
> whereas some simulator would need to care about that.
> 
> Anyways, I am OK with whatever works well and make things simpler.
> 
>>> Also note that, a client's dma specifier becomes perfectly general
>>> and future-proof
>>>
>>>    client1: spdif {
>>>           dma_tx = <278>
>>>           dma_rx = <723>
>>>     };
>>>
>>> otherwise the following representation
>>>
>>>     client1: spdif {
>>>                dma = <&sdma 2 1 &sdma 3 2>;
>>>      };
>>>
>>> could break with some weird dma setups (IIANW Russell already finds
>>> it wouldn't work for him).
>>
>> To solve Russell's HW, we need some way of representing the mux directly
>> in DT irrespective of how the DMA controller or DMA client specify what
>> they're connected to. Anything else isn't representing the HW in DT.
>>
>> Also, who knows how to control the mux? We need that to be fully
>> general, and so the mux itself really needs some kind of driver which
>> the DMA core or DMA controller can call into when the channel is
>> allocated in order to set up the mux. Right now, Russell's driver calls
>> in the a platform-/board-provided callback, but we should really
>> architect a generic driver framework for this.
>
> Well, I doubt if there would ever be enough such platforms to warrant a
> new generic framework. For now, I would leave that to be a matter between
> the dmac driver and its DT node.
>
> Similarly let every dmac, being unique, require DT data in it's own custom
> format - I don't believe we can find a generic DT format for every kind of
> dmac that does exist or would exist. (For ex, you found a way for RMK's
> mux'ed req_lines, but what about assigning priorities to clients which is
> possible with PL08X dmacs but not most others?)

Good question. Again thought that sounds a little like policy, so
perhaps should be negotiated at runtime rather than described in DT?

> So, I would strive only to make clients' dma specifier generic.
> 
>> client0: i2s {
>>   /* has 2 DMA request output signals: 0, 1 */
>> };
>>
>> client1: spdif {
>>   /* has 2 DMA request signals: 0, 1 */
>> };
>>
> Do we also need to somehow tag these signals for the client to
> differentiate between TX and RX channel ?

Yes, the client's DT binding would certainly need to describe how many
DMA request signals its HW generates, and give a unique ID to each. The
driver would need to request a DMA channel for a specific one of its DMA
requests.
