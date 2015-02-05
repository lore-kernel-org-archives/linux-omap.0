From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Thu, 05 Feb 2015 20:44:03 +0100
Message-ID: <54D3C803.30706@samsung.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:25202 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbbBEToK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 14:44:10 -0500
In-reply-to: <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomeu,

On 23/01/15 12:03, Tomeu Vizoso wrote:
>  int __clk_get(struct clk *clk)
>  {
> -	if (clk) {
> -		if (!try_module_get(clk->owner))
> +	struct clk_core *core = !clk ? NULL : clk->core;
> +
> +	if (core) {
> +		if (!try_module_get(core->owner))
>  			return 0;
>  
> -		kref_get(&clk->ref);
> +		kref_get(&core->ref);
>  	}
>  	return 1;
>  }
>  
> -void __clk_put(struct clk *clk)
> +static void clk_core_put(struct clk_core *core)
>  {
>  	struct module *owner;
>  
> -	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> -		return;
> +	owner = core->owner;
>  
>  	clk_prepare_lock();
> -	owner = clk->owner;
> -	kref_put(&clk->ref, __clk_release);
> +	kref_put(&core->ref, __clk_release);
>  	clk_prepare_unlock();
>  
>  	module_put(owner);
>  }
>  
> +void __clk_put(struct clk *clk)
> +{
> +	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +		return;
> +
> +	clk_core_put(clk->core);
> +	kfree(clk);

Why do we have kfree() here? clk_get() doesn't allocate the data structure 
being freed here. What happens if we do clk_get(), clk_put(), clk_get() 
on same clock?

I suspect __clk_free_clk() should be called in __clk_release() callback
instead, but then there is an issue of safely getting reference to
struct clk from struct clk_core pointer.

I tested linux-next on Odroid U3 and booting fails with oopses as below.
There is no problems when the above kfree() is commented out.

> +}

[    1.345850] Unable to handle kernel paging request at virtual address 00200200
[    1.349319] pgd = c0004000
[    1.352072] [00200200] *pgd=00000000
[    1.355574] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[    1.361035] Modules linked in:
[    1.364078] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc1-00104-ga251361a-dirty #992
[    1.372405] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    1.378483] task: ee00b000 ti: ee088000 task.ti: ee088000
[    1.383879] PC is at __clk_put+0x24/0xd0
[    1.387773] LR is at clk_prepare_lock+0xc/0xec
[    1.392198] pc : [<c03eef38>]    lr : [<c03ec1f4>]    psr: 20000153
[    1.392198] sp : ee089de8  ip : 00000000  fp : 00000000
[    1.403653] r10: ee02f480  r9 : 00000001  r8 : 00000000
[    1.408862] r7 : ee031cc0  r6 : ee089e08  r5 : 00000000  r4 : ee02f480
[    1.415373] r3 : 00100100  r2 : 00200200  r1 : 0000091e  r0 : 00000001
[    1.421884] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    1.429261] Control: 10c5387d  Table: 4000404a  DAC: 00000015
[    1.434989] Process swapper/0 (pid: 1, stack limit = 0xee088238)
[    1.440978] Stack: (0xee089de8 to 0xee08a000)
[    1.445321] 9de0:                   ee7c8f14 c03f0ec8 ee089e08 00000000 c0718dc8 00000001
[    1.453480] 9e00: 00000000 c04ee0f0 ee7e0844 00000001 00000181 c04edb58 ee2bd320 00000000
[    1.461639] 9e20: 00000000 c011dc5c ee16a1e0 00000000 00000000 c0718dc8 ee16a1e0 ee2bd1e0
[    1.469798] 9e40: c0641740 ee16a1e0 00000000 ee2bd320 c0718dc8 ee1d3e10 ee1d3e10 00000000
[    1.477957] 9e60: c0769a88 00000000 c0718dc8 00000000 00000000 c02c3124 c02c310c ee1d3e10
[    1.486117] 9e80: c07b4eec 00000000 c0769a88 c02c1d0c ee1d3e10 c0769a88 ee1d3e44 00000000
[    1.494276] 9ea0: c07091dc c02c1eb8 00000000 c0769a88 c02c1e2c c02c0544 ee005478 ee1676c0
[    1.502435] 9ec0: c0769a88 ee3a4e80 c0760ce8 c02c150c c0669b90 c0769a88 c0746cd8 c0769a88
[    1.510594] 9ee0: c0746cd8 ee2bc4c0 c0778c00 c02c24e0 00000000 c0746cd8 c0746cd8 c07091f0
[    1.518753] 9f00: 00000000 c0008944 c04f405c 00000025 ee00b000 60000153 c074ab00 00000000
[    1.526913] 9f20: 00000000 c074ab90 60000153 00000000 ef7fca5d c050860c 000000b6 c0036b88
[    1.535071] 9f40: c065ecc4 c06bc728 00000006 00000006 c074ab30 ef7fca40 c0739bdc 00000006
[    1.543231] 9f60: c0718dbc c0778c00 000000b6 c0718dc8 c06ed598 c06edd64 00000006 00000006
[    1.551390] 9f80: c06ed598 c003b438 00000000 c04e64f4 00000000 00000000 00000000 00000000
[    1.559549] 9fa0: 00000000 c04e64fc 00000000 c000e838 00000000 00000000 00000000 00000000
[    1.567708] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.575867] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 c0c0c0c0 c0c0c0c0
[    1.584045] [<c03eef38>] (__clk_put) from [<c03f0ec8>] (of_clk_set_defaults+0xe0/0x2c0)
[    1.592024] [<c03f0ec8>] (of_clk_set_defaults) from [<c02c3124>] (platform_drv_probe+0x18/0xa4)
[    1.600698] [<c02c3124>] (platform_drv_probe) from [<c02c1d0c>] (driver_probe_device+0x10c/0x22c)
[    1.609549] [<c02c1d0c>] (driver_probe_device) from [<c02c1eb8>] (__driver_attach+0x8c/0x90)
[    1.617968] [<c02c1eb8>] (__driver_attach) from [<c02c0544>] (bus_for_each_dev+0x54/0x88)
[    1.626128] [<c02c0544>] (bus_for_each_dev) from [<c02c150c>] (bus_add_driver+0xd4/0x1d0)
[    1.634286] [<c02c150c>] (bus_add_driver) from [<c02c24e0>] (driver_register+0x78/0xf4)
[    1.642275] [<c02c24e0>] (driver_register) from [<c07091f0>] (fimc_md_init+0x14/0x30)
[    1.650089] [<c07091f0>] (fimc_md_init) from [<c0008944>] (do_one_initcall+0x80/0x1d0)
[    1.657989] [<c0008944>] (do_one_initcall) from [<c06edd64>] (kernel_init_freeable+0x108/0x1d4)
[    1.666675] [<c06edd64>] (kernel_init_freeable) from [<c04e64fc>] (kernel_init+0x8/0xec)
[    1.674743] [<c04e64fc>] (kernel_init) from [<c000e838>] (ret_from_fork+0x14/0x3c)
[    1.682287] Code: ebfff4ae e5943014 e5942018 e3530000 (e5823000) 
[    1.688606] ---[ end trace bb367704ce3168e1 ]---

-- 
Regards,
Sylwester
