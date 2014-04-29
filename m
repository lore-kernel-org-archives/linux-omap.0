From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Boot fixes
Date: Tue, 29 Apr 2014 09:47:25 -0500
Message-ID: <535FBB7D.9000807@ti.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com> <20140422190132.GA12204@atomide.com> <5356C8AE.3090907@ti.com> <20140423145904.GB4833@atomide.com> <5357F78A.5000406@ti.com> <20140425164141.GD20807@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53625 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbaD2Orv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 10:47:51 -0400
In-Reply-To: <20140425164141.GD20807@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, bcousson@baylibre.com, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

On 04/25/2014 11:41 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [140423 10:25]:
>> On 04/23/2014 09:59 AM, Tony Lindgren wrote:
>>> * Dave Gerlach <d-gerlach@ti.com> [140422 12:53]:
>>>> On 04/22/2014 02:01 PM, Tony Lindgren wrote:
>>>>> * Dave Gerlach <d-gerlach@ti.com> [140422 11:52]:
>>>>>> This patch, along with patch here [1], fixes boot for am437x-gp-evm. The
>>>>>> bootloader configures gpio5_7 to control the DDR3 termination regulator,
>>>>>> the linked patch prevents that gpio bank from being reset and losing
>>>>>> the previously configured state, and this patch binds the gpio to a
>>>>>> regulator so the kernel is aware of the state of the gpio.
>>>>>>
>>>>>> [1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg102941.html
>>>>>
>>>>> Setting up the GPIO regulator makes sense to me. But the hack in the
>>>>> link above is potentially a nasty time bomb for anybody trying to
>>>>> use GPIO bank 5 on that board.
>>>>>
>>>>> What tests have been done that the GPIO bank behaves properly when
>>>>> it's not reset?
>>>>
>>>> We've been using this configuration on this board for a while without any
>>>> apparent issues. Also, am335x-evmsk already uses the same idea for the VTT
>>>> regulator on board from commit 6046adb6ad701026c10adeac8d6a4138895f12e5
>>>> [ARM: dts: am335x-evmsk: Do not reset gpio0] and I am unaware of any issues
>>>> with that either.
>>>
>>> OK. Do you have other GPIOs in use as interrupts for devices in these
>>> banks and do they work fine?
>>
>> I dont see any interrupts in use from gpio5 bank but as a quick test if I
>> add ti,no-reset-on-init to gpio3 and gpio4 I see no issue with matrix-keypad
>> operation which uses gpios from each of those banks.
>
> OK thanks for testing. I'll apply the ti,no-reset-on-init patch from [1]
> above into omap-for-v3.15/fixes-v2.
>
> The regulator patch can wait for v3.16, and should be also implemented
> for the am335x-evmsk the same way, so maybe add that too to your patch?

Alright thanks, yes I can do that as well for v2.

Regards,
Dave

>
>>> Also, can you please test to make sure this works with the most recent
>>> Javier's GPIO patches that had the issue of not booting on am335x-evmsk?
>>>
>>
>> Yes, when using Javier's patches in addition to this patch [1], which was
>> found to be necessary through this discussion [2], the AM437x GP EVM boots
>> fine with linux-next with my regulator patch and gpio5 no reset patch
>> applied.
>
> OK good to hear.
>
> Tony
>
>> [1] https://patchwork.kernel.org/patch/4041881/
>> [2] http://marc.info/?t=139817273800014&r=1&w=2
>>
>>> Regards,
>>>
>>> Tony
>>>
>>

