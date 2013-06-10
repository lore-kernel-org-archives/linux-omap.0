From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
Date: Mon, 10 Jun 2013 14:05:53 +0530
Message-ID: <51B58FE9.5040309@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com> <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com> <87zjv2ooxi.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41525 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3FJIga (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jun 2013 04:36:30 -0400
In-Reply-To: <87zjv2ooxi.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, Sricharan R <r.sricharan@ti.com>

Hi Kevin,

On Friday 07 June 2013 03:57 AM, Kevin Hilman wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>
>> On Wed, 29 May 2013, Santosh Shilimkar wrote:
>>
>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>
>>> AM33XX only supports DT boot mode and with addition of
>>> extracting module resources like, irq, dma and address space
>>> from DT block, so now we can remove duplicate information from
>>> hwmod data file.
>>
>> OK, guess I'll take your word for it that it all works.  The
>> BeagleBone-white with appended DTB hasn't booted here since v3.7.
>> And the BeagleBone-black with discrete DTB doesn't boot at all with
>> current mainline, only with the TI vendor kernel & DTB...
>
> Anyone care to shed light on what's missing for BeagleBone boot with
> mainline currently?
I have tested BeagleBone boot with today's mainline bootloader and
kernel. It boots perfectly fine.

Thanks and regards,
Lokesh
>
> I've also not been able to boot a mainline kernel on the BeagleBone for
> some time.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

