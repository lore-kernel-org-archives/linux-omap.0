From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
Date: Fri, 7 Jun 2013 13:01:05 -0400
Message-ID: <51B211D1.20100@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com> <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com> <87zjv2ooxi.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45645 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab3FGRBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 13:01:31 -0400
In-Reply-To: <87zjv2ooxi.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Thursday 06 June 2013 06:27 PM, Kevin Hilman wrote:
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
> 
> I've also not been able to boot a mainline kernel on the BeagleBone for
> some time.
> 
Looping Rajendra.

Regards,
Santosh

