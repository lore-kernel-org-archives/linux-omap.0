From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 5/5] ARM: OMAP3+: DPLL: use determine_rate() and set_rate_and_parent()
Date: Thu, 11 Dec 2014 09:31:25 +0200
Message-ID: <5489484D.60403@ti.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>	<1412344634-2798-6-git-send-email-t-kristo@ti.com> <CAMAWPa9CYTtn-VmSNu18HrAmG-WOj20ADAMrsFGEKxR0e_FObg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43537 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932171AbaLKHai (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2014 02:30:38 -0500
In-Reply-To: <CAMAWPa9CYTtn-VmSNu18HrAmG-WOj20ADAMrsFGEKxR0e_FObg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On 12/10/2014 09:41 PM, Kevin Hilman wrote:
> Hi Tero,
>
> On Fri, Oct 3, 2014 at 6:57 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> Currently, DPLLs are hiding the gory details of switching parent
>> within set_rate, which confuses the common clock code and is wrong.
>> Fixed by applying the new determine_rate() and set_rate_and_parent()
>> functionality to any clock-ops previously using the broken approach.
>> This patch also removes the broken legacy code.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> This patch arrived in linux-next (as commit 2e1a7b014f9c) and broke
> the omap2plus_defconfig, non-DT boot for the omap3-beagle-xm.  By
> default, there's no output on the console, but turning on DEBUG_LL, I
> got the crash below[1].
>
> Reverting this commit on next-20141210 gets things booting again for me.

Interesting... I'll pull latest linux-next today and try this out.

-Tero

>
> Kevin
>
>
> [1]
> [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
> [    0.000000] Unable to handle kernel paging request at virtual
> address 5f737973
> [    0.000000] pgd = c0004000
> [    0.000000] [5f737973] *pgd=00000000
> [    0.000000] Internal error: Oops: 5 [#1] SMP ARM
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 3.18.0-11367-g6791358f417e #85
> [    0.000000] Hardware name: OMAP3 Beagle Board
> [    0.000000] task: c08da288 ti: c08ce000 task.ti: c08ce000
> [    0.000000] PC is at strcmp+0x4/0x30
> [    0.000000] LR is at clk_fetch_parent_index+0x80/0xd8
> [    0.000000] pc : [<c032f3dc>]    lr : [<c04d81c0>]    psr: 600001d3
> [    0.000000] sp : c08cff20  ip : 00000000  fp : 00000000
> [    0.000000] r10: c08ec168  r9 : 5f737973  r8 : 00000001
> [    0.000000] r7 : de00d280  r6 : c0770eb4  r5 : de00d284  r4 : 00000000
> [    0.000000] r3 : 00000073  r2 : 00000000  r1 : 5f737973  r0 : c0770eb5
> [    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
> Segment kernel
> [    0.000000] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    0.000000] Process swapper/0 (pid: 0, stack limit = 0xc08ce240)
> [    0.000000] Stack: (0xc08cff20 to 0xc08d0000)
> [    0.000000] ff20: c08ec168 c0770eb4 c08ebbf0 23c34600 07270e00
> 413fc082 dfeff140 c04d82b0
> [    0.000000] ff40: c08ebbf0 07270e00 c08ec168 c08ec168 07270e00
> 0000001a 23c34600 c08ab890
> [    0.000000] ff60: dfeff140 c04d8bfc 34300133 00000190 c08ec168
> c086ffc8 34300133 00000190
> [    0.000000] ff80: 00000000 c0870318 00000258 c09768c4 c09768c4
> c09768c4 00000001 ffffffff
> [    0.000000] ffa0: c0976480 c08681a8 00000000 c086a114 c08aa1e8
> c0862684 00000002 c085eb08
> [    0.000000] ffc0: ffffffff ffffffff c085e670 00000000 00000000
> c08ab890 00000000 c0976694
> [    0.000000] ffe0: c08d6968 c08ab88c c08dbc2c 80004059 00000000
> 80008074 00000000 00000000
> [    0.000000] [<c032f3dc>] (strcmp) from [<c04d81c0>]
> (clk_fetch_parent_index+0x80/0xd8)
> [    0.000000] [<c04d81c0>] (clk_fetch_parent_index) from [<c04d82b0>]
> (clk_calc_new_rates+0x98/0x194)
> [    0.000000] [<c04d82b0>] (clk_calc_new_rates) from [<c04d8bfc>]
> (clk_set_rate+0x50/0x90)
> [    0.000000] [<c04d8bfc>] (clk_set_rate) from [<c086ffc8>]
> (omap3_clk_lock_dpll5+0x1c/0xb4)
> [    0.000000] [<c086ffc8>] (omap3_clk_lock_dpll5) from [<c0870318>]
> (omap3xxx_clk_init+0x2b8/0x398)
> [    0.000000] [<c0870318>] (omap3xxx_clk_init) from [<c08681a8>]
> (omap_clk_init+0x3c/0x50)
> [    0.000000] [<c08681a8>] (omap_clk_init) from [<c086a114>]
> (omap3_secure_sync32k_timer_init+0x8/0x58)
> [    0.000000] [<c086a114>] (omap3_secure_sync32k_timer_init) from
> [<c0862684>] (time_init+0x1c/0x30)
> [    0.000000] [<c0862684>] (time_init) from [<c085eb08>]
> (start_kernel+0x25c/0x3fc)
> [    0.000000] [<c085eb08>] (start_kernel) from [<80008074>] (0x80008074)
> [    0.000000] Code: e12fff1e e1a03000 eafffff7 e4d03001 (e4d12001)
> [
>

