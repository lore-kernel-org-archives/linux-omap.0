From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info clean up
Date: Mon, 10 Jun 2013 10:03:52 -0700
Message-ID: <877gi1ew3r.fsf@linaro.org>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
	<1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
	<87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:65099 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab3FJRD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 13:03:56 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so1489277pab.3
        for <linux-omap@vger.kernel.org>; Mon, 10 Jun 2013 10:03:55 -0700 (PDT)
In-Reply-To: <51B58FE9.5040309@ti.com> (Lokesh Vutla's message of "Mon, 10 Jun
	2013 14:05:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, Sricharan R <r.sricharan@ti.com>

Hi Lokesh,

Lokesh Vutla <lokeshvutla@ti.com> writes:

> Hi Kevin,
>
> On Friday 07 June 2013 03:57 AM, Kevin Hilman wrote:
>> Paul Walmsley <paul@pwsan.com> writes:
>>
>>> On Wed, 29 May 2013, Santosh Shilimkar wrote:
>>>
>>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>>
>>>> AM33XX only supports DT boot mode and with addition of
>>>> extracting module resources like, irq, dma and address space
>>>> from DT block, so now we can remove duplicate information from
>>>> hwmod data file.
>>>
>>> OK, guess I'll take your word for it that it all works.  The
>>> BeagleBone-white with appended DTB hasn't booted here since v3.7.
>>> And the BeagleBone-black with discrete DTB doesn't boot at all with
>>> current mainline, only with the TI vendor kernel & DTB...
>>
>> Anyone care to shed light on what's missing for BeagleBone boot with
>> mainline currently?
> I have tested BeagleBone boot with today's mainline bootloader and
> kernel. It boots perfectly fine.

Can you post git trees + branch names (and/or commit IDs) and also
kernel config please?

Thanks,

Kevin
