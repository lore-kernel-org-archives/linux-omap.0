From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 9 May 2012 00:39:12 +0530
Message-ID: <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<4FA3F308.6030900@ti.com>
	<CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
	<201205041923.07620.arnd@arndb.de>
	<CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
	<4FA7F009.5010003@wwwdotorg.org>
	<CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
	<4FA94B49.5050500@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51910 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755557Ab2EHTJO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 15:09:14 -0400
Received: by lahd3 with SMTP id d3so1321134lah.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 12:09:13 -0700 (PDT)
In-Reply-To: <4FA94B49.5050500@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 8 May 2012 22:05, Stephen Warren <swarren@wwwdotorg.org> wrote:
>
> The data doesn't need to be part of the DMA controller node in order for
> the DMA controller driver to be the entity interpreting it.
>
I rather say, if the dma controller driver is the entity going to interpret the
data, why not provide the data directly through its node at one go?

There is important difference between providing data via clients
during runtime vs providing info about every client to the dmac driver
at one go during its probe.

>
> The advantage here is that:
>
> * The specifier is stored in the client, not the IRQ/GPIO/DMA
> controller's node, so it's located right at the usage site, which
> typically makes working out what resources a client uses easier.
>
A client doesn't really need some n'th channel of some m'th dma controller.
A client simply needs one channel for transmitting data whichever
platform it be.
So {n,m}_channel isn't really a required resource, dma_tx is, which I  still
specify in the client's node.
  The fact that this information is simply fwd by the client as such to the dmac
(via utility code), makes the ritual even more pointless.


> This also keeps client-specific information out of the provider node,
> allowing it to be fully generic.
>
A typical Samsung SoC has 2 peripheral DMA controllers and
about 40 possible clients. Of which ~20 clients could be served by either of
the two dmacs. Of course hardly ever a machine has 10 clients. It would be
desirable if the dma driver doesn't populate the unused 54(32+32-10) channels,
 presumably also reserving limited resources for each, on the machine.

Consider this example ...
A PL330 instance has 8 physical channels and 32 client i/f.
So only 8 client reqs could be active at any time.
PL330 doesn't provide a way to program a true LLI transfer(very useful for
audio) using a single physical channel. However, we could emulate
true LLI if we employ 2 physical channels for one audio channel request.

Obviously, if a machine had 7 or lesser clients, one would freely employ
2 physical channels for audio and yet not worry about starving other clients.
How would we achieve this if the dmac driver was initialized as "fully
generic" ?

>
>> That encoding("channel_id") would be dma
>> controller specific and if we also manage to contain it within fixed number
>> of bytes we could also have common helpers for fetching it,
>
> I don't think there's any need for it to fit into a fixed number of  bytes
>
Yeah, I realized that soon after posting.

I think I have run out of ways to explain myself better. FWIW, I won't
object to whatever mechanism folks decide after knowing my concerns.

Best Regards,
-Jassi
