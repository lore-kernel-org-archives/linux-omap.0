From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
Date: Wed, 30 Oct 2013 10:00:34 -0500
Message-ID: <52711F12.1090008@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <526FDFF4.9030806@ti.com> <5270C1F3.6000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45477 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab3J3PBD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Oct 2013 11:01:03 -0400
In-Reply-To: <5270C1F3.6000409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/30/2013 03:23 AM, Tero Kristo wrote:
> On 10/29/2013 06:19 PM, Nishanth Menon wrote:
>> On 10/25/2013 10:56 AM, Tero Kristo wrote:
>> <snip>
>>> Testing done:
>>> - omap3-beagle: boot + suspend/resume (ret + off)
>>> - omap4-panda-es: boot + suspend/resume
>>> - omap5-uevm: boot
>>> - dra7-evm: boot
>>> - am335x-bone: boot
>>>
>>> Test branches available:
>>>
>>> tree: https://github.com/t-kristo/linux-pm.git
>>
>> <snip>
>>> Fully functioning test branch: 3.12-rc6-dt-clks-v9
>>>
>> ^^ I tested this branch (boot testing):
>> Beagle-XM: http://pastebin.com/50A1qtFq (crashes + clkdm issues, dpll5
>> failed to transition)
> 
> I just sent you a private email with a patch to try out, should fix the 
> boot crash at least hopefully. Basically I forgot to convert one part of 
> the kernel to the new regmap stuff for omap36xx.

it does bootup yes.
> 
> clkdm issues are caused by wrong data in omap_hwmod_3xxx_data.c, USB 
> nodes are listing l3_init_clkdm for them, but this only exists on 
> omap4+. Seems like some copy paste bug introduced by someone.
> 
> dpll5 part I am not too sure, can you check if the same happens with 
> non-dt boot?

no-dt: http://pastebin.com/bYP9fTzH
dt: http://pastebin.com/xHup4L9Y

dpll5 warning seems to be only in dt-boot?

> 
>> Panda-ES: http://pastebin.com/dWMp7D1z (bandgap_fclk not found)
>> OMAP5-UEVM: http://pastebin.com/pHEx6Yzg (omap-gpmc 50000000.gpmc:
>> error: clk_get)
> 
> Again, I don't think this is related to this series, but rather to 
> missing/wrong hwmod data.

seems the bandgap_fclk stuff is generated from
drivers/thermal/ti-soc-thermal/omap4-thermal-data.c

anyways..
> 
> -Tero
> 
>> DRA7-EVM: http://pastebin.com/uYNQ6Sss
>> BeagleBone-Black: http://pastebin.com/biGXS2vi
>> AM335x-evm: http://pastebin.com/K7qwJpCb
>>
>>
> 

Btw, I also noticed the following section mimatches:
WARNING: vmlinux.o(.text+0x2abd4): Section mismatch in reference from
the function prcm_probe() to the (unknown reference) .init.data:(unknown)
The function prcm_probe() references
the (unknown reference) __initdata (unknown).
This is often because prcm_probe lacks a __initdata
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.data+0x3e30): Section mismatch in reference from
the variable prcm_driver to the (unknown reference) .init.data:(unknown)
The variable prcm_driver references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console


-- 
Regards,
Nishanth Menon
