From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt
 property
Date: Tue, 10 Mar 2015 19:36:37 +0200
Message-ID: <54FF2BA5.6070001@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com> <1425561211-31003-2-git-send-email-d-gerlach@ti.com> <alpine.DEB.2.02.1503051815590.5613@utopia.booyaka.com> <20150305184952.GF13520@atomide.com> <54F8B2C7.7060202@ti.com> <20150305201713.GH13520@atomide.com> <20150306004157.GI13520@atomide.com> <54F9E3BF.5010407@ti.com> <20150306174548.GW13520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54191 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121AbbCJRhG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2015 13:37:06 -0400
In-Reply-To: <20150306174548.GW13520@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, KEERTHY <j-keerthy@ti.com>

Hi Dave,

On 03/06/2015 07:45 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150306 09:28]:
>> On 03/05/2015 06:41 PM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [150305 12:24]:
>>>> * Dave Gerlach <d-gerlach@ti.com> [150305 11:53]:
>>>>> On 03/05/2015 12:49 PM, Tony Lindgren wrote:
>>>>>> * Paul Walmsley <paul@pwsan.com> [150305 10:16]:
>>>>>>> On Thu, 5 Mar 2015, Dave Gerlach wrote:
>>>>>>>
>>>>>>>> Introduce a dt property, ti,no-init, that prevents hwmod initialization.
>>>>>>>> Even if a dt node is marked as disabled, hwmod still at least enables
>>>>>>>> the hwmod and programs the sysconfig before attempting to idle it at
>>>>>>>> boot. If an IP has been disabled by the hardware configuration on a
>>>>>>>> platform, this will cause a hang due to writing to inactive registers.
>>>>>>>> This property prevents that from happening by marking the hwmod as
>>>>>>>> _HWMOD_STATE_DISABLED during init.
>>>>>>>
>>>>>>> I'm kind of wondering if hwmod should even touch a device if it's marked
>>>>>>> as disabled in the DT.  Tony, what do you think?
>>>>>>
>>>>>> Well nothing happens if a device is status = "disabled". No dev entry
>>>>>> gets created for it at all and hwmod won't have any data for the device
>>>>>> populated. The only way hwmod code could see that device if the device
>>>>>> gets it's data from the legacy omap_hwmod_*_data.c instead of DT.
>>>>>>
>>>>>
>>>>> We still need this for the sysconfig programming, correct? hwmod programs that
>>>>> regardless of dt status and then idles the IP,
>>>>
>>>> Well hwmod does not even know about the IP IO addresses if it's marked
>>>> with status = "disabled".. Which IP are you having problems with?
>>>>
>>>>> which is why I needed the ti,no-init for the epos evm. It isn't just a
>>>>> matter of we shouldnt write to it because we don't want to use it; we
>>>>> can't write to it because the module is held off so it causes an
>>>>> external abort if we do.
>>>>
>>>> Well hard to say not knowing which module this is.. Pretty much all
>>>> the modules have drivers and the driver just does pm_runtime_get()
>>>> on it?
>>>
>>> Heh OK this thread is about the RTC driver, so I assume that's the
>>> problem :) So if you set the rtc to status = "disabled" how can the
>>> hwmod code do anything as AFAIK it won't even get the rtc IO address?
>>>
>>> Or am I missing something here?
>>
>> Perhaps I am mistaken, but from what I understand, all hwmods have _init and
>> _setup called on them, and all hwmods read the IO address regardless of DT
>> status at this point with _init_mpu_rt_base. In _setup, _setup_reset gets called
>> which calls _enable for the hwmod, and this calls both _enable_sysc and
>> _update_sysc_cache which touch the sysconfig register of the IP.
> 
> Oh OK, I think you're right. I was thinking of omap_device_build_from_dt(),
> sorry. Looks like the hwmod IO address data does get populated even
> for status = "disabled" although the dev entry won't get created and
> omap_device_build_from_dt() never gets called.
> 
>> Normally this is fine regardless of whether or not we are using an IP because
>> the module will wake up for a moment, have it's sysc programmed, and then be put
>> back to sleep later, potentially never to be woken again if we bind no driver
>> for it, which is fine for 99% of cases. In the case of am43x epos evm, you can
>> take the same piece of silicon that will boot happily on the gp evm with the rtc
>> hwmod in place and it will hang during boot on the epos evm because the board
>> uses a pin to hold the RTC IP in reset. There is no way to detect this in
>> software, the module can be turned on as normal using the clk_ctrl, but if you
>> touch any of the IP registers you get an abort.
> 
> OK sounds like some dts property is needed to signal this.

As I understand, there is device "RTC" and this device has status 'disabled',
so there is reasonable question why do we need to touch it at all?
The HWMOD is some kind of SoC description, which was needed before DT.
Now with DT in place it seems unreasonable to touch any IP block which:
- are not defined in DT
- has status 'disabled'.
in above cases the u-boot has to dial with IP block if it's invisible for Kernel.

The HWMOD framework intended to reset and put in some predefined states IPs which are
visible for the Kernel, so then proper driver can start working with IP or IP will be
kept in some low-power state if there is no driver.

Such kind of changes really confused :(, because when I'm looking on DT and see - status='disabled'
I suppose that such IP will not be touched by Kernel. But it's NOT really 'disabled'.
It's kinda 'partially disabled' or 'not present' or 'unused' ..
(if someone will decide to continue with such approach - it could be more
useful to define new value for 'status' parameter :P).
Also, just imaging that OMAP kernel is used with Xen as DomU and how hard will
it be to find and cut off all such tricks :( 

Did I miss something?

>   
>> So we need to prevent this from happening but of course we can't selectively
>> choose when the rtc hwmod gets added based on which board we are using so it
>> seemed a DT flag was appropriate to indicate that we do not want to init the rtc
>> IP at all only on this board.
>>
>> Without this flag in place but with the rtc hwmod added, the am43x-epos-evm
>> fails booting with an imprecise abort.
> 
> OK thanks for explaining it. I'm fine with this patch, Paul may have
> other issues. The other option would be to use status = "disabled" to
> not touch the device at all like Paul suggested. I wonder if that's
> going to break PM on some devices though..
> 

Regards,
-grygorii

