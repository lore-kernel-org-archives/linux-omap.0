From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 11 May 2012 01:29:51 +0530
Message-ID: <CAJe_ZhduQuHnFyF20VnjZW9uz1szwL6O7=ow+tMqanmeHs58pQ@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<4FA3F308.6030900@ti.com>
	<CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
	<201205041923.07620.arnd@arndb.de>
	<CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
	<4FA7F009.5010003@wwwdotorg.org>
	<CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
	<4FA94B49.5050500@wwwdotorg.org>
	<CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
	<4FAAC111.9020308@wwwdotorg.org>
	<CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com>
	<4FABF445.3030105@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39298 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760789Ab2EJT7w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 15:59:52 -0400
Received: by lahd3 with SMTP id d3so1386349lah.19
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 12:59:51 -0700 (PDT)
In-Reply-To: <4FABF445.3030105@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 10 May 2012 22:30, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/09/2012 03:38 PM, Jassi Brar wrote:

>> One point is about 'qos' here.... something like bandwidth allocatio=
n.
>> If the dmac driver knew up-front the max possible clients that could=
 be
>> active simultaneously, it could "divide the bandwidth" accordingly.
>> Again, the example of PL330 employing 2physical channels for better
>> service - LLI (you got it right), where even 1 physical channel woul=
d
>> also have served only not as reliably. I believe there would be
>> more such scenarios.
>
> QoS seems like policy to me, whereas DT is more about describing the =
HW.
> Is DT the correct place to describe QoS policy?
>
> I guess you are talking more about deriving policy from the descripti=
on
> of HW, i.e. how many client described in DT.
>
Yeah, that's what I meant.

> However, for some reason that seems dangerous to me; what if clients
> can be instantiated some other way?
>
The other way could be hotplug ?
Anyway in those machines every channel would be populated
and dmac driver would always account for the all-ports-plugged case.

>
> For a 1:1 mapping (or 1:n mapping in HW with static selection specifi=
ed
> in the DT) between DMA client and DMA controller, perhaps the control=
ler
> can indeed make QoS decisions based on which (how many) clients are
> connected to it.
>
> However, if a DMA client can be serviced by more than 1 DMA engine, a=
nd
> the decision as to which DMA engine to use occurs at run-time by the =
DMA
> driver core, rather than being statically configured in the DT, then =
the
> DMA controller drivers cannot know ahead of time which will be used
>
I think the dmac driver would make use of the routing flexibility to su=
stain its
'qos', and not the other way around (decide qos based on which one of t=
he
two dmacs would provide a channel to a client in future).
Anyways, so far only Samsung SoCs seem to have that flexibility/redunda=
ncy
and I have never had anyone asking for that runtime decision making.

>
>> The minor difference being, you use the {request-signal, phandle} pa=
ir
>> to find the right channel, I used only 'token'.
>
> That's a pretty big difference, I think.
>
> In your proposal, every token was globally unique (well, within the 1=
 DT
> file). I'd rather not see any more global numbering schemes.
>
Probably my shallow experience, but "globally unique, within a file" so=
unds
like an oxymoron :)
I think arbitrary numerical tokens are a reasonable price to pay for th=
e
robustness and simplicity they bring.

>
> Now, DMA requests are signals /from/ a DMA client to a DMA controller
> ("send more data please", or "pull more data please"). Hence, I asser=
t
> that the phandle should refer to the DMA client, not the DMA controll=
er.
>
OK, though we may just want to convey information about the h/w setup
from the s/w POV, rather than info to simulate the h/w  ;)
=46or ex, the dma api and controller drivers don't really care about
the fact that the client's driver must set some bit to trigger operatio=
n,
whereas some simulator would need to care about that.

Anyways, I am OK with whatever works well and make things simpler.


>>
>> Also note that, a client's dma specifier becomes perfectly general
>> and future-proof
>>
>> =A0 =A0client1: spdif {
>> =A0 =A0 =A0 =A0 =A0 dma_tx =3D <278>
>> =A0 =A0 =A0 =A0 =A0 dma_rx =3D <723>
>> =A0 =A0 };
>>
>> otherwise the following representation
>>
>> =A0 =A0 client1: spdif {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma =3D <&sdma 2 1 &sdma 3 2>;
>> =A0 =A0 =A0};
>>
>> could break with some weird dma setups (IIANW Russell already finds
>> it wouldn't work for him).
>
> To solve Russell's HW, we need some way of representing the mux direc=
tly
> in DT irrespective of how the DMA controller or DMA client specify wh=
at
> they're connected to. Anything else isn't representing the HW in DT.
>
> Also, who knows how to control the mux? We need that to be fully
> general, and so the mux itself really needs some kind of driver which
> the DMA core or DMA controller can call into when the channel is
> allocated in order to set up the mux. Right now, Russell's driver cal=
ls
> in the a platform-/board-provided callback, but we should really
> architect a generic driver framework for this.
>
Well, I doubt if there would ever be enough such platforms to warrant a
new generic framework. For now, I would leave that to be a matter betwe=
en
the dmac driver and its DT node.
Similarly let every dmac, being unique, require DT data in it's own cus=
tom
format - I don't believe we can find a generic DT format for every kind=
 of
dmac that does exist or would exist. (For ex, you found a way for RMK's
mux'ed req_lines, but what about assigning priorities to clients which =
is
possible with PL08X dmacs but not most others?)

So, I would strive only to make clients' dma specifier generic.

> client0: i2s {
>   /* has 2 DMA request output signals: 0, 1 */
> };
>
> client1: spdif {
>   /* has 2 DMA request signals: 0, 1 */
> };
>
Do we also need to somehow tag these signals for the client to
differentiate between TX and RX channel ?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
