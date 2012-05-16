From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 21:46:46 +0530
Message-ID: <CAJe_ZhcQAABe9xF6HEvUq8OT8RoWXTHAsrzyZiGO9bM-GHNiTg@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
	<4FA3F308.6030900@ti.com>
	<CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
	<4FB2FEBA.1030404@ti.com>
	<CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com>
	<4FB3A87C.1000000@ti.com>
	<4FB3CF44.4040603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48270 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756525Ab2EPQQr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 12:16:47 -0400
Received: by lahd3 with SMTP id d3so638179lah.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 09:16:46 -0700 (PDT)
In-Reply-To: <4FB3CF44.4040603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 16 May 2012 21:31, Jon Hunter <jon-hunter@ti.com> wrote:
> On 05/16/2012 08:15 AM, Jon Hunter wrote:
>> Hi Jassi,
>>
>> On 05/16/2012 07:37 AM, Jassi Brar wrote:
>>> Hi Jon,
>>>
>>> On 16 May 2012 06:41, Jon Hunter <jon-hunter@ti.com> wrote:
>>>> On 05/04/2012 02:01 PM, Jassi Brar wrote:
>>>>>
>>>>> + =A0 =A0 =A0 i2c1: i2c@1 {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma =3D <&sdma 2 1 &sdma 3 2>;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>>> + =A0 =A0 =A0 };
>>>>>>
>>>>> I see this requires a client driver to specify a particular req_l=
ine on a
>>>>> particular dma controller. I am not sure if this is most optimal.
>>>>
>>>> Actually, no. The phandle in the DT specifies the DMA controller t=
o use.
>>>> Then the client simply asks for a channel with a particular proper=
ty,
>>>> for example, DMA_MEM_TO_DEV (ie. TX) and the channel information i=
s return.
>>>>
>>> See below.
>>>
>>>>> I think such client->req_line map should be provided to the dmac =
controller
>>>>> driver via its dt node in some format. The dmac driver could then=
 populate
>>>>> a dma_chan, or similar, only for that req_line and not for the un=
used one
>>>>> which otherwise could also have served the same client.
>>>>>
>>>>> Ideally the I2C driver should simply ask, say, a channel for TX a=
nd another
>>>>> for RX, everything else should already be setup via dmac's dt nod=
es.
>>>>
>>>> Yes that is the intention here.
>>>>
>>> But the client is required to specify the dmac that would serve it.
>>> Which is more
>>> than simply asking for "some suitable channel".
>>
>> No this is not the case with what I propose. The client knows nothin=
g
>> about the dmac.
>
> By the way, I do see your point. You wish to describe the all the
> mappings available to all dma controllers and then set a mapping in t=
he
> device tree. Where as I am simply setting a mapping and do not list a=
ll
> other possibilities (assuming that there some).
>
> What is still unclear to me, is if you use this token approach how
> readable is the device-tree? For example, if you have a client that c=
an
> use one of two dmac and for each dmac the request/channel number is
> different, then by using a global token how can I determine what the
> options available for this client are?
>
Simple - you/client need not know about any option at all :)

Client driver would simply request some channel and if it
doesn't get it, it bails out.

It would be the DMACs' DT node that would contain that info.

> Take your example ...
>
> mmc1: mmc@13002000 {
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0dma_tx =3D <891> =A0 //some platform-wide unique value
> =A0 =A0 =A0 =A0dma_rx =3D <927> =A0 //some platform-wide unique value
> =A0 =A0 =A0 =A0...
> };
>
> DMAC's Node:-
>
> pdma2: pdma@10800000 {
> =A0 =A0 =A0 =A0 .......
> =A0 =A0 =A0 =A0dma_map =3D <891, 7>, =A0 =A0 =A0 // Map mmc1_tx onto =
i/f 7
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<927, 8>, =A0 =A0 =A0 // Map mmc1_=
rx onto i/f 8
> =A0 =A0 =A0 =A0.......
> };
>
> But now I have another dmac which has the following options ...
>
> pdma1: pdma@10000000 {
> =A0 =A0 =A0 =A0 .......
> =A0 =A0 =A0 =A0dma_map =3D <598, 2>, =A0 =A0 =A0 // Map mmc1_tx onto =
i/f 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<230, 3>, =A0 =A0 =A0 // Map mmc1_=
rx onto i/f 3
> =A0 =A0 =A0 =A0.......
> };
>
No, rather the pdma1 node should look like

 pdma1: pdma@10000000 {
 =A0 =A0 =A0 =A0 .......
 =A0 =A0 =A0 =A0dma_map =3D <891, 2>, =A0 =A0 =A0 // Map mmc1_tx onto i=
/f 2
  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<927, 3>, =A0 =A0 =A0 // Map mmc1_=
rx onto i/f 3
 =A0 =A0 =A0 =A0.......
};

Because the tokens 891 and 927 are came from the client's node/driver.

After the DMAC driver has probed both pdma-0 & 1, it would
know that MMC1 could be served by 2 DMACs. And basically
its the dmac driver that should be making about routing decisions,
not the client.

Btw, everything remains same, only we have now decided to not
use tokens but phandle+req_sig_ids instead.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
