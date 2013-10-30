From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
Date: Wed, 30 Oct 2013 10:23:15 +0200
Message-ID: <5270C1F3.6000409@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <526FDFF4.9030806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32997 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3J3IYe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Oct 2013 04:24:34 -0400
In-Reply-To: <526FDFF4.9030806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/29/2013 06:19 PM, Nishanth Menon wrote:
> On 10/25/2013 10:56 AM, Tero Kristo wrote:
> <snip>
>> Testing done:
>> - omap3-beagle: boot + suspend/resume (ret + off)
>> - omap4-panda-es: boot + suspend/resume
>> - omap5-uevm: boot
>> - dra7-evm: boot
>> - am335x-bone: boot
>>
>> Test branches available:
>>
>> tree: https://github.com/t-kristo/linux-pm.git
>
> <snip>
>> Fully functioning test branch: 3.12-rc6-dt-clks-v9
>>
> ^^ I tested this branch (boot testing):
> Beagle-XM: http://pastebin.com/50A1qtFq (crashes + clkdm issues, dpll5
> failed to transition)

I just sent you a private email with a patch to try out, should fix the 
boot crash at least hopefully. Basically I forgot to convert one part of 
the kernel to the new regmap stuff for omap36xx.

clkdm issues are caused by wrong data in omap_hwmod_3xxx_data.c, USB 
nodes are listing l3_init_clkdm for them, but this only exists on 
omap4+. Seems like some copy paste bug introduced by someone.

dpll5 part I am not too sure, can you check if the same happens with 
non-dt boot?

> Panda-ES: http://pastebin.com/dWMp7D1z (bandgap_fclk not found)
> OMAP5-UEVM: http://pastebin.com/pHEx6Yzg (omap-gpmc 50000000.gpmc:
> error: clk_get)

Again, I don't think this is related to this series, but rather to 
missing/wrong hwmod data.

-Tero

> DRA7-EVM: http://pastebin.com/uYNQ6Sss
> BeagleBone-Black: http://pastebin.com/biGXS2vi
> AM335x-evm: http://pastebin.com/K7qwJpCb
>
>

