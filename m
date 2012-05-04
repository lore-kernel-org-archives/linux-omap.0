From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Sat, 5 May 2012 00:31:49 +0530
Message-ID: <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
	<4FA3F308.6030900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35030 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab2EDTBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 15:01:51 -0400
Received: by lbbgm6 with SMTP id gm6so2257460lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 12:01:50 -0700 (PDT)
In-Reply-To: <4FA3F308.6030900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 4 May 2012 20:47, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Jassi,
>
> On 05/04/2012 01:56 AM, Jassi Brar wrote:
>> On 1 May 2012 02:47, Jon Hunter <jon-hunter@ti.com> wrote:
>>> From: Jon Hunter <jon-hunter@ti.com>
>>>
>>> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre=
 [2]
>>> to add some basic helpers to retrieve a DMA controller device_node =
and the
>>> DMA request/channel information.
>>>
>>> Aim of DMA helpers
>>> - The purpose of device-tree (as far as I understand), is to descri=
be the
>>> =A0capabilites of the hardware. Thinking about DMA controllers pure=
ly from the
>>> =A0context of the hardware to begin with, we can describe a device =
in terms of
>>> =A0a DMA controller as follows ...
>>> =A0 =A0 =A0 =A01. Number of DMA controllers
>>> =A0 =A0 =A0 =A02. Number of channels (maybe physical or logical)
>>> =A0 =A0 =A0 =A03. Mapping of DMA requests signals to DMA controller
>>> =A0 =A0 =A0 =A04. Number of DMA interrupts
>>> =A0 =A0 =A0 =A05. Mapping of DMA interrupts to channels
>>> - With the above in mind the aim of the DT DMA helper functions is =
to extract
>>> =A0the above information from the DT and provide to the appropriate=
 driver.
>>> =A0However, due to the vast number of DMA controllers and not all a=
re using a
>>> =A0common driver (such as DMA Engine) it has been seen that this is=
 not a
>>> =A0trivial task.
>>>
>> Sorry for being slow, but so far I thought DT is only to provide _h/=
w_
>> specific info
>> to the _controller_ drivers. It was not supposed to provide any info
>> pertaining to
>> some API (dmaengine in this case).
>>
>> And I believe this is one of few situations where we are better off
>> not generalizing
>> the interface - pass controller specific info in the controller
>> driver's specified format.
>> Generalizing only seems to complicate things here, when we anyway ha=
ve machine
>> specific dtb, which could always have clients requesting and the
>> controllers given
>> dma's info in controller driver's specific format.
>>
>> Perhaps I am overlooking the need to generalize. If you think so, pl=
ease help me
>> understand by pointing out some use case for it.
>
> No not really, your points are valid. From reading the previous
> discussions one of the items that was clearly lacking was the ability=
 to
> represent and identify a device having more than one DMA controller. =
In
> other words, when you request the DMA resource, how do you identify
> which DMA controller in the system that resource belongs too. With DM=
A
> engine there are ways we can do this.
>
Well, if we really can't have dmac drivers make 'intelligent' runtime d=
ecision
of request mapping on more than one capable controllers, we still can
make it simpler than the proposed scheme.

+       i2c1: i2c@1 {
+               ...
+               dma =3D <&sdma 2 1 &sdma 3 2>;
+               ...
+       };
>
I see this requires a client driver to specify a particular req_line on=
 a
particular dma controller. I am not sure if this is most optimal.

I think such client->req_line map should be provided to the dmac contro=
ller
driver via its dt node in some format. The dmac driver could then popul=
ate
a dma_chan, or similar, only for that req_line and not for the unused o=
ne
which otherwise could also have served the same client.

Ideally the I2C driver should simply ask, say, a channel for TX and ano=
ther
for RX, everything else should already be setup via dmac's dt nodes.

Channel properties like duplex, priority etc specified in client's dt n=
ode
doesn't seem really necessary - the client's driver is able to adjust
according to the capability of the channel the dmaengine api is able
to provide and the client driver can't really do anything if it saw "tx=
rx"
specified in it's dt node while it doesn't yet support full-duplex (say=
).

Having spilled my guts and realizing the fact that the Maradonas and Pe=
les
of the game seem to have already bought the scheme, I am afraid it only
points to my not yet diagnosed adhd  :o
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
