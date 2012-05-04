From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 4 May 2012 12:26:13 +0530
Message-ID: <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52568 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2EDG4O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 02:56:14 -0400
Received: by lbbgm6 with SMTP id gm6so1809977lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 23:56:13 -0700 (PDT)
In-Reply-To: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 1 May 2012 02:47, Jon Hunter <jon-hunter@ti.com> wrote:
> From: Jon Hunter <jon-hunter@ti.com>
>
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [=
2]
> to add some basic helpers to retrieve a DMA controller device_node an=
d the
> DMA request/channel information.
>
> Aim of DMA helpers
> - The purpose of device-tree (as far as I understand), is to describe=
 the
> =A0capabilites of the hardware. Thinking about DMA controllers purely=
 from the
> =A0context of the hardware to begin with, we can describe a device in=
 terms of
> =A0a DMA controller as follows ...
> =A0 =A0 =A0 =A01. Number of DMA controllers
> =A0 =A0 =A0 =A02. Number of channels (maybe physical or logical)
> =A0 =A0 =A0 =A03. Mapping of DMA requests signals to DMA controller
> =A0 =A0 =A0 =A04. Number of DMA interrupts
> =A0 =A0 =A0 =A05. Mapping of DMA interrupts to channels
> - With the above in mind the aim of the DT DMA helper functions is to=
 extract
> =A0the above information from the DT and provide to the appropriate d=
river.
> =A0However, due to the vast number of DMA controllers and not all are=
 using a
> =A0common driver (such as DMA Engine) it has been seen that this is n=
ot a
> =A0trivial task.
>
Sorry for being slow, but so far I thought DT is only to provide _h/w_
specific info
to the _controller_ drivers. It was not supposed to provide any info
pertaining to
some API (dmaengine in this case).

And I believe this is one of few situations where we are better off
not generalizing
the interface - pass controller specific info in the controller
driver's specified format.
Generalizing only seems to complicate things here, when we anyway have =
machine
specific dtb, which could always have clients requesting and the
controllers given
dma's info in controller driver's specific format.

Perhaps I am overlooking the need to generalize. If you think so, pleas=
e help me
understand by pointing out some use case for it.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
