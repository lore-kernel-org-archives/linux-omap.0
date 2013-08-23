From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
Date: Fri, 23 Aug 2013 23:11:06 +0530
Message-ID: <52179EB2.2050800@ti.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com> <51FBC610.9030900@arm.com> <51FBCEC3.4030207@ti.com> <51FBD42A.9040901@arm.com> <20130802154857.GD5292@mudshark.cambridge.arm.com> <52092AA5.3090005@ti.com> <20130813111943.GE30280@mudshark.cambridge.arm.com> <520A3518.3030301@ti.com> <52179719.3080609@ti.com> <52179927.1020906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33508 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755921Ab3HWRlm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Aug 2013 13:41:42 -0400
In-Reply-To: <52179927.1020906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 8/23/2013 10:47 PM, Santosh Shilimkar wrote:
> On Friday 23 August 2013 01:08 PM, Sekhar Nori wrote:
>> On 8/13/2013 7:01 PM, Santosh Shilimkar wrote:
>>> On Tuesday 13 August 2013 07:19 AM, Will Deacon wrote:
>>>> On Mon, Aug 12, 2013 at 07:34:13PM +0100, Santosh Shilimkar wrote:
>>>>> On Friday 02 August 2013 11:48 AM, Will Deacon wrote:
>>>>>> I think this an A9-specific register, which reads as 0 on UP A9 and reads as
>>>>>> some form of PERIPH_BASE for SMP parts. The issue I have is when PERIPH_BASE
>>>>>> is zero.
>>>>>>
>>>>> What do we do here ? Should we document this in the code and proceed ?
>>>>> Mostly there is no platform with PERIPH_BASE = 0, so its should be fine but
>>>>> I am open for any other alternative.
>>>>
>>>> The only other alternative I can think of is forcing people to have
>>>> CONFIG_SMP=n, but that blows away single zImage for your platform.
>>>>
>>> Yep which surely we don't want considering after so much effort we
>>> have it working first place. How about going ahead with assumption
>>> that PERIPH_BASE = 0 case doesn't work.
>>
>> I must be missing something but why cannot we use the SCU configuration
>> register "CPU number" field to determine that its a UP? I do not have an
>> OMAP4 board, but on AM437x, it certainly indicates only CPU0 present.
>>
> Thats what patch does. Yes, you are missing the point of dicussion. 

Right, I see that now after actually reading the complete patch :)

> On real UP Cortex-A9, the base address read will return '0' which is
> treated as invalid address in the patch. Will D pointed out that one

Is this something defined by spec for all UP Cortex-A9 or just an
observation on AM437x implementation? It sounds like the later?

Thanks,
Sekhar
