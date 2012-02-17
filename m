From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: SMP local timers and their CPUfreq notifiers setup on OMAP3
Date: Fri, 17 Feb 2012 10:47:22 +0100
Message-ID: <0401fed02a58f7bc48cc274050adbac7@localhost>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F3E0655.2040702@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Hi Santosh,

On Fri, 17 Feb 2012 13:18:37 +0530, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> 
> From 3a16f7a6694c14e201fdf6ad195c821816b2de84 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 17 Feb 2012 11:11:28 +0530
> Subject: [PATCH] ARM: smp_twd: Don't register CPUFREQ notifiers if local
> timers are not initialised.
> 
> Current ARM local timer code registers CPUFREQ notifiers even in case
> the twd_timer_setup() isn't called. That seems to be wrong and
> would eventually lead to kernel crash on the CPU frequency transitions
> on the SOCs where the local timer doesn't exist or broken because of
> hardware BUG.
> 
> Fix it by uisng an initialised variable. Though the twd_timer_setup()
> is percpu, the idea here is to avoid the CPUFREQ registration. Hence
> percpu initialised variable is not used.
> 
> The issue was observed with v3.3-rc3 and building an OMAP2+ kernel
> on OMAP3 SOC which doesn't have TWD.
> 
> Below is the dump for reference :
> 
>  Unable to handle kernel paging request at virtual address 007e900
>  pgd = cdc20000
>  [007e9000] *pgd=00000000
>  Internal error: Oops: 5 [#1] SMP
>  Modules linked in:
>  CPU: 0    Not tainted  (3.3.0-rc3-pm+debug+initramfs #9)
>  PC is at twd_update_frequency+0x34/0x48
>  LR is at twd_update_frequency+0x10/0x48
>  pc : [<c001382c>]    lr : [<c0013808>]    psr: 60000093
>  sp : ce311dd8  ip : 00000000  fp : 00000000
>  r10: 00000000  r9 : 00000001  r8 : ce310000
>  r7 : c0440458  r6 : c00137f8  r5 : 00000000  r4 : c0947a74
>  r3 : 00000000  r2 : 007e9000  r1 : 00000000  r0 : 00000000
>  Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment usr
>  Control: 10c5387d  Table: 8dc20019  DAC: 00000015
>  Process sh (pid: 599, stack limit = 0xce3102f8)
>  Stack: (0xce311dd8 to 0xce312000)
>  1dc0:                                                       6000c
>  1de0: 00000001 00000002 00000000 00000000 00000000 00000000 00000
>  1e00: ffffffff c093d8f0 00000000 ce311ebc 00000001 00000001 ce310
>  1e20: c001386c c0437c4c c0e95b60 c0e95ba8 00000001 c0e95bf8 ffff4
>  1e40: 00000000 00000000 c005ef74 ce310000 c0435cf0 ce311ebc 00000
>  1e60: ce352b40 0007a120 c08d5108 c08ba040 c08ba040 c005f030 00000
>  1e80: c08bc554 c032fe2c 0007a120 c08d4b64 ce352b40 c08d8618 ffff8
>  1ea0: c08ba040 c033364c ce311ecc c0433b50 00000002 ffffffea c0330
>  1ec0: 0007a120 0007a120 22222201 00000000 22222222 00000000 ce357
>  1ee0: ce3d6000 cdc2aed8 ce352ba0 c0470164 00000002 c032f47c 00034
>  1f00: c0331cac ce352b40 00000007 c032f6d0 ce352bbc 0003d090 c0930
>  1f20: c093d8bc c03306a4 00000007 ce311f80 00000007 cdc2aec0 ce358
>  1f40: ce8d20c0 00000007 b6fe5000 ce311f80 00000007 ce310000 0000c
>  1f60: c000de74 ce987400 ce8d20c0 b6fe5000 00000000 00000000 0000c
>  1f80: 00000000 00000000 001fbac8 00000000 00000007 001fbac8 00004
>  1fa0: c000df04 c000dd60 00000007 001fbac8 00000001 b6fe5000 00000
>  1fc0: 00000007 001fbac8 00000007 00000004 b6fe5000 00000000 00202
>  1fe0: 00000000 beb565f8 00101ffc 00008e8c 60000010 00000001 00000
>  [<c001382c>] (twd_update_frequency+0x34/0x48) from [<c008ac4c>] )
>  [<c008ac4c>] (smp_call_function_single+0x17c/0x1c8) from [<c0013)
>  [<c0013890>] (twd_cpufreq_transition+0x24/0x30) from [<c0437c4c>)
>  [<c0437c4c>] (notifier_call_chain+0x44/0x84) from [<c005efe4>] ()
>  [<c005efe4>] (__srcu_notifier_call_chain+0x70/0xa4) from [<c005f)
>  [<c005f030>] (srcu_notifier_call_chain+0x18/0x20) from [<c032fe2)
>  [<c032fe2c>] (cpufreq_notify_transition+0xc8/0x1b0) from [<c0333)
>  [<c033364c>] (omap_target+0x1b4/0x28c) from [<c032f47c>] (__cpuf)
>  [<c032f47c>] (__cpufreq_driver_target+0x50/0x64) from [<c0331d24)
>  [<c0331d24>] (cpufreq_set+0x78/0x98) from [<c032f6d0>] (store_sc)
>  [<c032f6d0>] (store_scaling_setspeed+0x5c/0x74) from [<c03306a4>)
>  [<c03306a4>] (store+0x58/0x74) from [<c014d868>] (sysfs_write_fi)
>  [<c014d868>] (sysfs_write_file+0x80/0xb4) from [<c00f2c2c>] (vfs)
>  [<c00f2c2c>] (vfs_write+0xa8/0x138) from [<c00f2e9c>] (sys_write)
>  [<c00f2e9c>] (sys_write+0x40/0x6c) from [<c000dd60>] (ret_fast_s)
>  Code: e594300c e792210c e1a01000 e5840004 (e7930002)
>  ---[ end trace 5da3b5167c1ecdda ]---
> 
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/kernel/smp_twd.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 4285daa..753ae37 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -30,6 +30,7 @@ void __iomem *twd_base;
> 
>  static struct clk *twd_clk;
>  static unsigned long twd_timer_rate;
> +static bool twd_initialised;
> 
>  static struct clock_event_device __percpu **twd_evt;
> 
> @@ -129,7 +130,7 @@ static struct notifier_block twd_cpufreq_nb = {
> 
>  static int twd_cpufreq_init(void)
>  {
> -	if (!IS_ERR(twd_clk))
> +	if ((!IS_ERR(twd_clk)) && twd_initialised)
>  		return cpufreq_register_notifier(&twd_cpufreq_nb,
>  			CPUFREQ_TRANSITION_NOTIFIER);

Testing twd_evt and *__this_cpu_ptr(twd_evt) should have a similar effect,
and save the additional variable.

        M.
-- 
Fast, cheap, reliable. Pick two.
