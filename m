From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Wed, 27 May 2015 16:19:23 -0700
Message-ID: <7hy4k9libo.fsf@deeprootsystems.com>
References: <20150527215545.GA30984@atomide.com>
	<7h7frtmzoh.fsf@deeprootsystems.com>
	<20150527225553.GC30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34527 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbE0XT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2015 19:19:26 -0400
Received: by pdbki1 with SMTP id ki1so27615606pdb.1
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2015 16:19:26 -0700 (PDT)
In-Reply-To: <20150527225553.GC30984@atomide.com> (Tony Lindgren's message of
	"Wed, 27 May 2015 15:55:53 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, tyler.baker@linaro.org, Stephen Boyd <sboyd@codeaurora.org>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@kernel.org> [150527 15:20]:
>> [ fix email for Dave Martin, +Tyler ]
>> 
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > The power management related assembly needs to interact with
>> > ARM mode bootrom code, so we need to keep most of the related
>> > assembly in ARM mode.
>> >
>> > Currently we are entering into and ARM mode assembly function
>> > from thumb2 mode, so we need to make sure we switch to ARM
>> > mode. And we need to do that again after the cache flush.
>> >
>> > ---
>> >
>> > Kevin told me about this earlier today.. 
>> 
>> 
>> And for full boot log/panics, see the kernelci.org thumb2 kernel boots
>> that fail: http://kernelci.org/boot/?THUMB2_KERNEL&fail
>> 
>> > Anybody got better ideas for a fix here?
>> 
>> FWIW, a quick test of this patch makes my omap3-beagle-xm pass a simple
>> boot test, but it fails with off idle.
>
> Thanks to Stephen Boyd's suggestion of checking the missing ENDPROC,
> here's a better fix :) Now off idle works too.
>
> Regards,
>
> Tony
>
> 8 <----------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 27 May 2015 15:33:57 -0700
> Subject: [PATCH] ARM: OMAP3: Fix booting with thumb2 kernel
>
> We get a NULL pointer dereference on omap3 for thumb2 compiled kernels:
>
> Internal error: Oops: 80000005 [#1] SMP THUMB2
> ...
> [<c046497b>] (_raw_spin_unlock_irqrestore) from [<c0024375>]
> (omap3_enter_idle_bm+0xc5/0x178)
> [<c0024375>] (omap3_enter_idle_bm) from [<c0374e63>]
> (cpuidle_enter_state+0x77/0x27c)
> [<c0374e63>] (cpuidle_enter_state) from [<c00627f1>]
> (cpu_startup_entry+0x155/0x23c)
> [<c00627f1>] (cpu_startup_entry) from [<c06b9a47>]
> (start_kernel+0x32f/0x338)
> [<c06b9a47>] (start_kernel) from [<8000807f>] (0x8000807f)
>
> The power management related assembly on moaps needs to interact with
> ARM mode bootrom code, so we need to keep most of the related assembly
> in ARM mode.
>
> Turns out this error is because of missing ENDPROC for assembly code
> as suggested by Stephen Boyd <sboyd@codeaurora.org>. Let's add the
> missing ENDPROC in two places to sleep34xx.S, and also remove the
> earlier mystery code that was probably also caused by missing ENDPROC
> for earlier kernels.
>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Yup, boot test is now passing for me on omap3-beagle, omap3-beagle-xm,
omap3-n900, omap3-overo-tobi, omap3-overo-storm-tobi.

Tested-by: Kevin Hilman <khilman@linaro.org>

Thanks for the quick fix.

Next step is to look at the exynos4412-odroidu3 failure which probably
has a similar cause.

Kevin
