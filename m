From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 10 May 2012 11:00:53 -0600
Message-ID: <4FABF445.3030105@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <201205041923.07620.arnd@arndb.de> <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com> <4FA7F009.5010003@wwwdotorg.org> <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com> <4FA94B49.5050500@wwwdotorg.org> <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com> <4FAAC111.9020308@wwwdotorg.org> <CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57304 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab2EJRA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 13:00:58 -0400
In-Reply-To: <CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/09/2012 03:38 PM, Jassi Brar wrote:
> On 10 May 2012 00:40, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/08/2012 01:09 PM, Jassi Brar wrote:
>>>
>>> There is important difference between providing data via clients
>>> during runtime vs providing info about every client to the dmac driver
>>> at one go during its probe.
>>
>> I certainly see that there is a difference.
>>
>> I don't understand why it's an important difference; I think everything
>> needs to be handled at run-time no matter what:
>>
>> Just because there is information in the DT that "this client DT node
>> uses this channel/request-ID/... of this DMA controller" doesn't mean
>> that the driver for the client is going to be loaded, or that SW running
>> on the system is going to cause that driver to actually be opened and do
>> any DMA. As such, any resource allocation rules etc. must be evaluated
>> only if/when a driver actually requests/uses a DMA channel, so having
>> "all the information up front" doesn't seem like a theoretically
>> possible thing anyway.
>
> One point is about 'qos' here.... something like bandwidth allocation.
> If the dmac driver knew up-front the max possible clients that could be
> active simultaneously, it could "divide the bandwidth" accordingly.
> Again, the example of PL330 employing 2physical channels for better
> service - LLI (you got it right), where even 1 physical channel would
> also have served only not as reliably. I believe there would be
> more such scenarios.

QoS seems like policy to me, whereas DT is more about describing the HW.
Is DT the correct place to describe QoS policy?

I guess you are talking more about deriving policy from the description
of HW, i.e. how many client described in DT. However, for some reason
that seems dangerous to me; what if clients can be instantiated some
other way?

> Another minor benefit could be that the dmac driver populate only
> as many "struct dma_chan" as there are actually clients on the
> machine (and this population has to be done during probe).
> It could mean ~8 instead of ~40 channels populated on a machine.
> Note, a PL330 dmac can have 32 channels, OMAP's has 128....
> 
> Most importantly, I just think it's a cleaner approach.
> 
> 
>> Very similar to this, in order to support your point that a given client
>> could potentially use a channel from either of 2 different DMA
>> controller instances, you don't know until run-time which controller
>> will be used, so can't have up-front information in this scenario
>> either, even if the DMA does actually take place.
>
> Sorry, perhaps I wasn't clear enough.
> A client sees _no_ difference between the two channels that could serve it.
> And it can't start using two, if two are available.
> Client just needs one suitable channel on whichever dmac that might be.
> If the channel for a client is to be switched runtime, that decision
> should lie with the dmac driver, not the client. And I am not really
> after implementing that runtime decision support.

Yes, I understood that point. The issue is:

For a 1:1 mapping (or 1:n mapping in HW with static selection specified
in the DT) between DMA client and DMA controller, perhaps the controller
can indeed make QoS decisions based on which (how many) clients are
connected to it.

However, if a DMA client can be serviced by more than 1 DMA engine, and
the decision as to which DMA engine to use occurs at run-time by the DMA
driver core, rather than being statically configured in the DT, then the
DMA controller drivers cannot know ahead of time which will be used, and
hence cannot have the full information they need to make accurate QoS
decisions ahead of time; they can only make these decisions at run-time
when the DMA channels are actually opened.

So, I believe coupling any QoS decisions to DT content alone is not correct.

>> Solving (b) seems to require something very roughly like:
>>
>> dma-controller@0 {
>>    compatible = "foo,dmac-xxx";
>>    dma-requests = <
>>                &client0 0 // DMAC req 0 is client0's 0th req output
>>                &client0 1
>>                &client1 0
>>                &client1 1
>>                &client2 0
>>                ...>;
>> };
>>
>> dma-controller@1 {
>>    compatible = "bar,dmac-yyy";
>>    dma-requests = <
>>                // Supports some client modules, but not the same ones
>>                &client0 0
>>                &client1 0
>>                &client3 0
>>                ...>;
>> };
>>
>> client0: i2s {
>>    /* has 2 DMA request output signals: 0, 1 */
>> };
>>
>> client1: spdif {
>>    /* has 2 DMA request signals: 0, 1 */
>> };
>>
>> client2: foo {
>>    /* has 1 DMA request signal: 0 */
>> };
>>
>> client3: bar {
>>    /* has 1 DMA request signal: 0 */
>> };
>>
>> and then having the core DMA code have an API like:
>>
>> channel = dma_request(clients_dma_req_output_id)
>>
>> which looks in each DMA controller's dma-requests list for the client's
>> phandle and matching dma_req_output_id.
>
> Almost what I proposed in my third post in this thread !!

Yes, looking back it's quite similar, but...

> The minor difference being, you use the {request-signal, phandle} pair
> to find the right channel, I used only 'token'.

That's a pretty big difference, I think.

In your proposal, every token was globally unique (well, within the 1 DT
file). I'd rather not see any more global numbering schemes.

As such, each token has to encode both some object that it's relative
to, and some ID relative to that object.

In DT parlance, the encoding of the object would be a phandle.

Now, DMA requests are signals /from/ a DMA client to a DMA controller
("send more data please", or "pull more data please"). Hence, I assert
that the phandle should refer to the DMA client, not the DMA controller.

> Please note, with this method we specify info about every client at one
> go and via dmac's DT node - hence those benefits.
> 
> Also note that, a client's dma specifier becomes perfectly general
> and future-proof
>
>    client1: spdif {
>           dma_tx = <278>
>           dma_rx = <723>
>     };
> 
> otherwise the following representation
>
>     client1: spdif {
>                dma = <&sdma 2 1 &sdma 3 2>;
>      };
>
> could break with some weird dma setups (IIANW Russell already finds
> it wouldn't work for him).

To solve Russell's HW, we need some way of representing the mux directly
in DT irrespective of how the DMA controller or DMA client specify what
they're connected to. Anything else isn't representing the HW in DT.

Also, who knows how to control the mux? We need that to be fully
general, and so the mux itself really needs some kind of driver which
the DMA core or DMA controller can call into when the channel is
allocated in order to set up the mux. Right now, Russell's driver calls
in the a platform-/board-provided callback, but we should really
architect a generic driver framework for this.

I'd propose something like the following to handle this:

dma-controller {
   compatible = "foo,dmac-xxx";
   dma-requests = <
		&dma_req_mux 0 // Perhaps RX is mux'd
		&client0 1 // But the 2 TX channels aren't
		&client1 1
		>;
};

The driver for this would somehow register with the DMA core, so that
when the driver for e.g. I2S attempts to allocate a DMA channel, the DMA
core knows to ask the mux driver to route the correct signal upstream to
the DMA controller:

dma_req_mux: mux {
   compatible = "foo,dma-req-mux";
   dma-requests = <&client0 0 &client1 0>;
   // A GPIO-based mux might use a regular GPIO binding for its control:
   gpios = <&gpio 0 0>;
};

client0: i2s {
   /* has 2 DMA request output signals: 0, 1 */
};

client1: spdif {
   /* has 2 DMA request signals: 0, 1 */
};
