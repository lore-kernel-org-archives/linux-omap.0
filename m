From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP2+: CM cleanup series
Date: Sat, 12 Oct 2013 13:18:47 +0300
Message-ID: <52592207.4070508@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1310120139280.27397@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56957 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab3JLKTN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Oct 2013 06:19:13 -0400
In-Reply-To: <alpine.DEB.2.02.1310120139280.27397@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On 10/12/2013 05:19 AM, Paul Walmsley wrote:
> Hi
>
> On Fri, 11 Oct 2013, Tero Kristo wrote:
>
>> A small cleanup set for CM. This basically gets rid of the omap2_cm_*
>> register accesses from the random code locations, and gathers these
>> under cm2xxx.c and cm3xxx.c. This is done in preparation for creating
>> a separate CM driver. The set also contains a couple of PRM cleanups
>> which I decided to take care of at the same time due to overlapping
>> code (PRCM interrupt handler + DSP reset.)
>>
>> TODO: cleanup dsp bridge code (arch/arm/mach-omap2/dsp.c.)
>>
>> Tested on OMAP3 beagle + 3.12-rc3.
>
> Looks like at least one patch has a dependency on your DT clk patches:
>
> Importing patch "clk-ti-add-dt-alias-clock" ...
> error: drivers/clk/ti/Makefile: does not exist in index
> error: include/linux/clk/ti.h: does not exist in index
> stg import: Diff does not apply cleanly

Hmm what? No it doesn't have any dependency. At most, there could be 
merge conflicts between the two, as this is completely separated set.

-Tero

>
> Tried compiling the rest, but the build broke:
>
> arch/arm/mach-omap2/mcbsp.c: In function 'omap3_enable_st_clock':
> arch/arm/mach-omap2/mcbsp.c:46:3: error: implicit declaration of function 'omap2_clk_deny_idle'
> arch/arm/mach-omap2/mcbsp.c:48:3: error: implicit declaration of function 'omap2_clk_allow_idle'
> make[1]: *** [arch/arm/mach-omap2/mcbsp.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> make: *** Waiting for unfinished jobs....
>
>
> - Paul
>

