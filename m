From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
Date: Wed, 30 Oct 2013 15:10:01 -0500
Message-ID: <52716799.6040002@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <526FDFF4.9030806@ti.com> <5270C1F3.6000409@ti.com> <52711F12.1090008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab3J3UKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Oct 2013 16:10:40 -0400
In-Reply-To: <52711F12.1090008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/30/2013 10:00 AM, Nishanth Menon wrote:
> On 10/30/2013 03:23 AM, Tero Kristo wrote:
>> On 10/29/2013 06:19 PM, Nishanth Menon wrote:
>>> On 10/25/2013 10:56 AM, Tero Kristo wrote:
>>> <snip>
>>>> Testing done:
>>>> - omap3-beagle: boot + suspend/resume (ret + off)
>>>> - omap4-panda-es: boot + suspend/resume
>>>> - omap5-uevm: boot
>>>> - dra7-evm: boot
>>>> - am335x-bone: boot
>>>>
>>>> Test branches available:
>>>>
>>>> tree: https://github.com/t-kristo/linux-pm.git
>>>
>>> <snip>
>>>> Fully functioning test branch: 3.12-rc6-dt-clks-v9
>>>>
>>> ^^ I tested this branch (boot testing):
>>> Beagle-XM: http://pastebin.com/50A1qtFq (crashes + clkdm issues, dpll5
>>> failed to transition)
>>
>> I just sent you a private email with a patch to try out, should fix the 
>> boot crash at least hopefully. Basically I forgot to convert one part of 
>> the kernel to the new regmap stuff for omap36xx.
> 
> it does bootup yes.
>>
>> clkdm issues are caused by wrong data in omap_hwmod_3xxx_data.c, USB 
>> nodes are listing l3_init_clkdm for them, but this only exists on 
>> omap4+. Seems like some copy paste bug introduced by someone.
>>
>> dpll5 part I am not too sure, can you check if the same happens with 
>> non-dt boot?
> 
> no-dt: http://pastebin.com/bYP9fTzH
> dt: http://pastebin.com/xHup4L9Y
> 
> dpll5 warning seems to be only in dt-boot?
> 

Tracked this down: you were missing the following - looks like the
conversion script might be missing converting the flags clock data
over to dts?

diff --git
a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
index 7e37e3e..c9b77c8 100644
--- a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
@@ -30,6 +30,7 @@
                compatible = "ti,omap3-dpll-clock";
                clocks = <&sys_ck>, <&sys_ck>;
                reg = <0x0d04>, <0x0d24>, <0x0d34>, <0x0d4c>;
+               ti,low-power-stop;
        };

        dpll5_m2_ck: dpll5_m2_ck {



-- 
Regards,
Nishanth Menon
