From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP4: CLKDM: Update supported transition modes
Date: Tue, 15 May 2012 09:33:34 -0500
Message-ID: <4FB2693E.7090303@ti.com>
References: <1336599364-11024-1-git-send-email-jon-hunter@ti.com> <4FAB6623.9090005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38182 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355Ab2EOOdl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 10:33:41 -0400
In-Reply-To: <4FAB6623.9090005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Santosh, Benoit,

On 05/10/2012 01:54 AM, Santosh Shilimkar wrote:
> On Thursday 10 May 2012 03:06 AM, Jon Hunter wrote:
>> From: Jon Hunter <jon-hunter@ti.com>
>>
>> For OMAP3+ devices, the clock domains (CLKDMs) support one or more of the
>> following transition modes ...
>>
>> NO_SLEEP (0x0) - A clock domain sleep transition is never initiated,
>> 		 irrespective of the hardware conditions.
>> SW_SLEEP (0x1) - A software-forced sleep transition. The transition is initiated
>> 		 when the associated hardware conditions are satisfied
>> SW_WKUP  (0x2) - A software-forced clock domain wake-up transition is initiated,
>> 		 irrespective of the hardware conditions.
>> HW_AUTO  (0x3) - Hardware-controlled automatic sleep and wake-up transition is
>> 		 initiated by the PRCM module when the associated hardware
>> 		 conditions are satisfied.
>>
>> For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP is equivalent
>> to SW_WKUP. For OMAP4 devices, all CLKDMs support HW_AUTO and therefore we can
>> place the CLKDMs in the HW_AUTO state instead of the SW_SLEEP mode. Hence, we
>> do not need to use the SW_SLEEP mode. With regard to NO_SLEEP and SW_WKUP it is
>> preferred to use SW_WKUP mode if the CLKDM supports it and so use this mode
>> instead of NO_SLEEP where possible.
>>
>> For a software perspective the above 4 modes are represented by the following
>> flags to indicate what modes are supported by each of the CLKDMs.
>>
>> CLKDM_CAN_DISABLE_AUTO	--> NO_SLEEP
>> CLKDM_CAN_ENABLE_AUTO	--> HW_AUTO
>> CLKDM_CAN_FORCE_SLEEP	--> SW_SLEEP
>> CLKDM_CAN_FORCE_WAKEUP	--> SW_WKUP
>>
>> By eliminating the SW_SLEEP mode the the mapping of the flags for OMAP4 devices
>> can becomes ...
>>
>> CLKDM_CAN_DISABLE_AUTO	--> NO_SLEEP
>> CLKDM_CAN_ENABLE_AUTO	--> HW_AUTO
>> CLKDM_CAN_FORCE_SLEEP	--> HW_AUTO
> Not sure if this can be entirely correct for OMAP4.
> Because HW_AUTO = "Sleep and wakeup transition are
> based upon hardware conditions"
> Where as SW_SLEEP = "Start a software forced sleep
> transition on the domain."
> 
> I will reply on the the thread where this is being discussed.

Given that feedback we received that the only difference between HW_AUTO
and SW_SLEEP is "that the PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt
status is set in case of SW_SLEEP transition, and not set in case of
HW_AUTO transition". Are you ok with this change? If so can you sign-off
on this?

I can update the series with all the comments and re-post this week.

Cheers
Jon
