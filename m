From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix compilation error observed when cpufreq is disabled
Date: Thu, 29 Apr 2010 07:02:42 -0700
Message-ID: <87hbmu73wd.fsf@deeprootsystems.com>
References: <1268995606-32018-1-git-send-email-ranjithl@ti.com>
	<87bpd3cliv.fsf@deeprootsystems.com> <4BD9093E.7010600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:57552 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab0D3W47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 18:56:59 -0400
Received: by qyk13 with SMTP id 13so1009780qyk.1
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 15:56:58 -0700 (PDT)
In-Reply-To: <4BD9093E.7010600@ti.com> (Ranjith Lohithakshan's message of "Thu\, 29 Apr 2010 09\:51\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> On Thu, 29-Apr-10 3:00 AM +0530, Kevin Hilman wrote:
>> Ranjith Lohithakshan <ranjithl@ti.com> writes:
>> 
>>> Currently on PM branch, compilation fails when cpufreq is disabled
>>>
>>> arch/arm/mach-omap2/clock3xxx_data.c: In function 'omap3xxx_clk_init':
>>> arch/arm/mach-omap2/clock3xxx_data.c:3563: error: 'struct clk_functions'
>>> has no member named 'clk_init_cpufreq_table'
>>> arch/arm/mach-omap2/clock3xxx_data.c:3564: error:
>>> 'omap3_clk_init_cpufreq_table' undeclared (first use
>>> in this function)
>>> arch/arm/mach-omap2/clock3xxx_data.c:3564: error: (Each undeclared
>>> identifier is reported only once
>>> arch/arm/mach-omap2/clock3xxx_data.c:3564: error: for each function it
>>> appears in.)
>>> make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1
>>> make: *** [arch/arm/mach-omap2] Error 2
>>>
>>> This patch fixes the issue by avoiding runtime init of
>>> clk_init_cpufreq_table in omap3xxx_clk_init and instead doing it when
>>> omap2_clk_functions are defined.
>>>
>>> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
>> 
>> Do you still have this problem?  I'm unable to reproduce on current PM branch.
>
> No, I don't see this now. Might have got fixed in some of the recent
> changes.
>
> Just FYI, I now see a linkage error with omap3_evm_defconfig
>
> arch/arm/mach-omap2/built-in.o: In function `sr_configure_vp':
> /tmp/ranjith/l-o-new/arch/arm/mach-omap2/smartreflex.c:315: undefined
> reference to `omap_twl_uv_to_vsel'
> /tmp/ranjith/l-o-new/arch/arm/mach-omap2/smartreflex.c:364: undefined
> reference to `omap_twl_uv_to_vsel'
> arch/arm/mach-omap2/built-in.o: In function `sr_enable':
> /tmp/ranjith/l-o-new/arch/arm/mach-omap2/smartreflex.c:609: undefined
> reference to `omap_twl_uv_to_vsel'
> arch/arm/mach-omap2/built-in.o: In function `sr_reset_voltage':
> /tmp/ranjith/l-o-new/arch/arm/mach-omap2/smartreflex.c:478: undefined
> reference to `omap_twl_uv_to_vsel'
> /tmp/ranjith/l-o-new/arch/arm/mach-omap2/smartreflex.c:496: undefined
> reference to `omap_twl_uv_to_vsel'
> make: *** [.tmp_vmlinux1] Error 1
>

Yes, I saw that too when trying to reproduce your problem.

SmartReflex currently has a dependency on SRF where these OPP functions
are defined, and this needs to be fixed.

Kevin

