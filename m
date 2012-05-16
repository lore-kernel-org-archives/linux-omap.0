From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 22:54:57 +0530
Message-ID: <CAJe_Zhe_edZ32K50i8AH+wagUkYWRxJpWpZpZ-ddk83LF5vKRg@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
	<4FA3F308.6030900@ti.com>
	<CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
	<4FB2FEBA.1030404@ti.com>
	<CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com>
	<4FB3A87C.1000000@ti.com>
	<4FB3CF44.4040603@ti.com>
	<CAJe_ZhcQAABe9xF6HEvUq8OT8RoWXTHAsrzyZiGO9bM-GHNiTg@mail.gmail.com>
	<4FB3E00B.4030207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61781 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759130Ab2EPRY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 13:24:58 -0400
Received: by lbbgm6 with SMTP id gm6so695686lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 10:24:57 -0700 (PDT)
In-Reply-To: <4FB3E00B.4030207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 16 May 2012 22:42, Jon Hunter <jon-hunter@ti.com> wrote:

>>> What is still unclear to me, is if you use this token approach how
>>> readable is the device-tree? For example, if you have a client that can
>>> use one of two dmac and for each dmac the request/channel number is
>>> different, then by using a global token how can I determine what the
>>> options available for this client are?
>>>
>> Simple - you/client need not know about any option at all :)
>>
>> Client driver would simply request some channel and if it
>> doesn't get it, it bails out.
>>
>> It would be the DMACs' DT node that would contain that info.
>
> Yes, but what if I am doing some custom application and want to modify
> the mapping that is being used? So I just wanted to make sure it is easy
> to understand assuming that you understand what your h/w is capable of.
>
Any scenario when a client would want to choose which dma controller
it runs on?

Because when we say a client could be provided a channel on any of the
two given dmacs, it implies that the client wouldn't feel any difference.
