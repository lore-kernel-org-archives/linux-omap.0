From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 18:07:34 +0530
Message-ID: <CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
	<4FA3F308.6030900@ti.com>
	<CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
	<4FB2FEBA.1030404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50929 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab2EPMhg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 08:37:36 -0400
Received: by lbbgm6 with SMTP id gm6so462007lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 05:37:34 -0700 (PDT)
In-Reply-To: <4FB2FEBA.1030404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On 16 May 2012 06:41, Jon Hunter <jon-hunter@ti.com> wrote:
> On 05/04/2012 02:01 PM, Jassi Brar wrote:
>>
>> + =A0 =A0 =A0 i2c1: i2c@1 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma =3D <&sdma 2 1 &sdma 3 2>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>> + =A0 =A0 =A0 };
>>>
>> I see this requires a client driver to specify a particular req_line=
 on a
>> particular dma controller. I am not sure if this is most optimal.
>
> Actually, no. The phandle in the DT specifies the DMA controller to u=
se.
> Then the client simply asks for a channel with a particular property,
> for example, DMA_MEM_TO_DEV (ie. TX) and the channel information is r=
eturn.
>
See below.

>> I think such client->req_line map should be provided to the dmac con=
troller
>> driver via its dt node in some format. The dmac driver could then po=
pulate
>> a dma_chan, or similar, only for that req_line and not for the unuse=
d one
>> which otherwise could also have served the same client.
>>
>> Ideally the I2C driver should simply ask, say, a channel for TX and =
another
>> for RX, everything else should already be setup via dmac's dt nodes.
>
> Yes that is the intention here.
>
But the client is required to specify the dmac that would serve it.
Which is more
than simply asking for "some suitable channel".

If you read the whole exchange between I and Stephen, we converged on a
scheme of clients' node having nothing to specify and DMAC told all abo=
ut
every client in one palce. Which resembles closer to reality and is
much simpler.
I already started on a patchset and should be able submit for review
in a day or two.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
