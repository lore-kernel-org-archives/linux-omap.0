From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
Date: Mon, 4 Nov 2013 09:15:28 +0200
Message-ID: <52774990.8000104@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <526FDFF4.9030806@ti.com> <5270C1F3.6000409@ti.com> <52711F12.1090008@ti.com> <52716799.6040002@ti.com> <52721E95.4080806@ti.com> <52726134.8040505@ti.com> <52741C2C.4060209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3KDHP7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Nov 2013 02:15:59 -0500
In-Reply-To: <52741C2C.4060209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/01/2013 11:25 PM, Nishanth Menon wrote:
> On 10/31/2013 08:55 AM, Nishanth Menon wrote:
>> On 10/31/2013 04:10 AM, Tero Kristo wrote:
>>> On 10/30/2013 10:10 PM, Nishanth Menon wrote:
>>>> On 10/30/2013 10:00 AM, Nishanth Menon wrote:
>>>>> On 10/30/2013 03:23 AM, Tero Kristo wrote:
>>>>>> On 10/29/2013 06:19 PM, Nishanth Menon wrote:
>>>>>>> On 10/25/2013 10:56 AM, Tero Kristo wrote:
>>>>>>> <snip>
>>>>>>>> Testing done:
>>>>>>>> - omap3-beagle: boot + suspend/resume (ret + off)
>>>>>>>> - omap4-panda-es: boot + suspend/resume
>>>>>>>> - omap5-uevm: boot
>>>>>>>> - dra7-evm: boot
>>>>>>>> - am335x-bone: boot
>>>>>>>>
>>>>>>>> Test branches available:
>>>>>>>>
>>>>>>>> tree: https://github.com/t-kristo/linux-pm.git
>>>>>>>
>>>>>>> <snip>
>>>>>>>> Fully functioning test branch: 3.12-rc6-dt-clks-v9
>>>>>>>>
>>>>>>> ^^ I tested this branch (boot testing):
>>>>>>> Beagle-XM: http://pastebin.com/50A1qtFq (crashes + clkdm issues, dpll5
>>>>>>> failed to transition)
>>>>>>
>>>>>> I just sent you a private email with a patch to try out, should fix the
>>>>>> boot crash at least hopefully. Basically I forgot to convert one part of
>>>>>> the kernel to the new regmap stuff for omap36xx.
>>>>>
>>>>> it does bootup yes.
>>>>>>
>>>>>> clkdm issues are caused by wrong data in omap_hwmod_3xxx_data.c, USB
>>>>>> nodes are listing l3_init_clkdm for them, but this only exists on
>>>>>> omap4+. Seems like some copy paste bug introduced by someone.
>>>>>>
>>>>>> dpll5 part I am not too sure, can you check if the same happens with
>>>>>> non-dt boot?
>>>>>
>>>>> no-dt: http://pastebin.com/bYP9fTzH
>>>>> dt: http://pastebin.com/xHup4L9Y
>>>>>
>>>>> dpll5 warning seems to be only in dt-boot?
>>>>>
>>>>
>>>> Tracked this down: you were missing the following - looks like the
>>>> conversion script might be missing converting the flags clock data
>>>> over to dts?
>>>>
>>>> diff --git
>>>> a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
>>>> b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
>>>> index 7e37e3e..c9b77c8 100644
>>>> --- a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
>>>> +++ b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
>>>> @@ -30,6 +30,7 @@
>>>>                   compatible = "ti,omap3-dpll-clock";
>>>>                   clocks = <&sys_ck>, <&sys_ck>;
>>>>                   reg = <0x0d04>, <0x0d24>, <0x0d34>, <0x0d4c>;
>>>> +               ti,low-power-stop;
>>>>           };
>>>>
>>>>           dpll5_m2_ck: dpll5_m2_ck {
>>>>
>>>>
>>>>
>>>
>>> Yea, seems I introduced the problem with the conversion script changes.
>>> The valid fix for this is actually at the end of this mail (this fixes
>>> both of the problems introduced, and also completes the fix you did), I
>>> will add the fixes to the next rev.
>>
>> One debug feedback:
>> reg = <0x0d04>, <0x0d24>, <0x0d34>, <0x0d4c>;
>> clocks = <&sys_ck>, <&sys_ck>;
>>
>> we used indexing for varied register and clocks. however the register
>> meaning per index changes based on type of DPLL. This was one painful
>> thing to track down when debugging. the only robust option to debug
>> was to use prints as part of register write/reads to ensure that right
>> sequence was being followed.
>>
>> I understand based on review comments for dtb size, we have removed
>> the names, but we lost sane debug capability as well with that.
>>
>
> I dont have any further feedback at this point beyond what is already
> shared and so far my minimal tests have been good..
>
> I have the following warnings:
> sparse build warnings: http://pastebin.com/HZ1TWzyh
> kernel-doc warnings: http://pastebin.com/JQwFEuaC
>
> Hopefully, the next rev will not introducing nothing newer that what
> we have in mainline.

I will have a look at those for the next rev, will most likely post next 
against 3.13-rc1, there's no much point posting before.

-Tero
