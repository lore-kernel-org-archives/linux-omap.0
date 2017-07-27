From: Alex Shi <alex.shi@linaro.org>
Subject: Re: Regression with suspicious RCU usage splats with cpu_pm change
Date: Thu, 27 Jul 2017 17:55:19 +0800
Message-ID: <461af072-9b01-b08b-9ae6-09f14c9b187a@linaro.org>
References: <20170713070749.GE16509@atomide.com>
 <c00272dc-cf84-81a2-b2e2-d52cadf7bcc6@linaro.org>
 <CAJZ5v0j15uWyCRAPep4KwqSiC4UD4ZppAG++SUvN3Ok1wzDwNQ@mail.gmail.com>
 <20170713124318.GK2393@linux.vnet.ibm.com>
 <c5c6623b-ea1d-1bbf-ea80-5d93e7e81c6f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <c5c6623b-ea1d-1bbf-ea80-5d93e7e81c6f@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: paulmck@linux.vnet.ibm.com, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

Hi Rafael,

Guess you overlook my new patch in this thread. :)
Do I need to recent this patch as new? or you could pick it up here?

BTW,
it's
Tested-by: Tony Lindgren <tony@atomide.com>

Thanks!
Alex

On 07/17/2017 07:24 AM, Alex Shi wrote:
> 
> 
> On 07/13/2017 08:43 PM, Paul E. McKenney wrote:
>> On Thu, Jul 13, 2017 at 01:50:26PM +0200, Rafael J. Wysocki wrote:
>>> On Thu, Jul 13, 2017 at 11:43 AM, Alex Shi <alex.shi@linaro.org> wrote:
>>>>
>>>> On 07/13/2017 03:07 PM, Tony Lindgren wrote:
>>>>> Hi,
>>>>>
>>>>> Looks like next-20170713 gives me a bunch of "suspicious RCU usage"
>>>>> splats with cpuidle_coupled on duovero, see below. I bisected it down
>>>>> to commit 2f027e003d05 ("cpu_pm: replace raw_notifier with
>>>>> atomic_notifier").
>>>
>>> OK, so I'm dropping this commit.
>>
>> You can surround idle-loop RCU-reading code with RCU_NONIDLE().
>> This will tell RCU to pay attention even though the CPU is otherwise
>> idle.
>>
>> 							Thanx, Paul
>>
> 
> 
> Thanks a lot, Paul! :)
> I reused the rcu_irq_enter_irqson() from RCU_NONIDLE to avoid this issue. 
> It works fine.
> 
> Tony, Could you like to give a tested-by if this patch works for you.
> 
> Sebastian,
> May I keep your acked-by with new fixed patch, since the main thing remained? :)
> 
> 
> Thanks everyone!
> 
> ======
> 
> From c8ec81808d46a78e58267f6a23f2b58b48ed5725 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linaro.org>
> Date: Tue, 4 Jul 2017 21:49:23 +0800
> Subject: [PATCH] cpu_pm: replace raw_notifier to atomic_notifier
> 
> This patch replace a rwlock and raw notifier by atomic notifier which
> protected by spin_lock and rcu.
> 
> The first to reason to have this replace is due to a 'scheduling while
>  atomic' bug of RT kernel on arm/arm64 platform. On arm/arm64, rwlock
> cpu_pm_notifier_lock in cpu_pm cause a potential schedule after irq
> disable in idle call chain:
> 
> cpu_startup_entry
>   cpu_idle_loop
>     local_irq_disable()
>     cpuidle_idle_call
>       call_cpuidle
>         cpuidle_enter
>           cpuidle_enter_state
>             ->enter :arm_enter_idle_state
>               cpu_pm_enter/exit
>                 CPU_PM_CPU_IDLE_ENTER
>                   read_lock(&cpu_pm_notifier_lock); <-- sleep in idle
>                      __rt_spin_lock();
>                         schedule();
> 
> The kernel panic is here:
> [    4.609601] BUG: scheduling while atomic: swapper/1/0/0x00000002
> [    4.609608] [<ffff0000086fae70>] arm_enter_idle_state+0x18/0x70
> [    4.609614] Modules linked in:
> [    4.609615] [<ffff0000086f9298>] cpuidle_enter_state+0xf0/0x218
> [    4.609620] [<ffff0000086f93f8>] cpuidle_enter+0x18/0x20
> [    4.609626] Preemption disabled at:
> [    4.609627] [<ffff0000080fa234>] call_cpuidle+0x24/0x40
> [    4.609635] [<ffff000008882fa4>] schedule_preempt_disabled+0x1c/0x28
> [    4.609639] [<ffff0000080fa49c>] cpu_startup_entry+0x154/0x1f8
> [    4.609645] [<ffff00000808e004>] secondary_start_kernel+0x15c/0x1a0
> 
> Daniel Lezcano said this notification is needed on arm/arm64 platforms.
> Sebastian suggested using atomic_notifier instead of rwlock, which is not
> only removing the sleeping in idle, but also getting better latency
> improvement.
> 
> Tony Lezcano found a miss use that rcu_read_lock used after rcu_idle_enter
> Paul E. McKenney suggested trying RCU_NONIDLE.
> 
> Thanks everyone! :)
> 
> This patch passed Fengguang's 0day testing.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/cpu_pm.c | 50 +++++++++++++-------------------------------------
>  1 file changed, 13 insertions(+), 37 deletions(-)
> 
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 009cc9a..67b02e1 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -22,15 +22,21 @@
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
>  
> -static DEFINE_RWLOCK(cpu_pm_notifier_lock);
> -static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
> +static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
>  
>  static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
>  {
>  	int ret;
>  
> -	ret = __raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
> +	/*
> +	 * __atomic_notifier_call_chain has a RCU read critical section, which
> +	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
> +	 * RCU know this.
> +	 */
> +	rcu_irq_enter_irqson();
> +	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
>  		nr_to_call, nr_calls);
> +	rcu_irq_exit_irqson();
>  
>  	return notifier_to_errno(ret);
>  }
> @@ -47,14 +53,7 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
>   */
>  int cpu_pm_register_notifier(struct notifier_block *nb)
>  {
> -	unsigned long flags;
> -	int ret;
> -
> -	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
> -	ret = raw_notifier_chain_register(&cpu_pm_notifier_chain, nb);
> -	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
> -
> -	return ret;
> +	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
>  
> @@ -69,14 +68,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
>   */
>  int cpu_pm_unregister_notifier(struct notifier_block *nb)
>  {
> -	unsigned long flags;
> -	int ret;
> -
> -	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
> -	ret = raw_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
> -	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
> -
> -	return ret;
> +	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
>  
> @@ -100,7 +92,6 @@ int cpu_pm_enter(void)
>  	int nr_calls;
>  	int ret = 0;
>  
> -	read_lock(&cpu_pm_notifier_lock);
>  	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
>  	if (ret)
>  		/*
> @@ -108,7 +99,6 @@ int cpu_pm_enter(void)
>  		 * PM entry who are notified earlier to prepare for it.
>  		 */
>  		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
> -	read_unlock(&cpu_pm_notifier_lock);
>  
>  	return ret;
>  }
> @@ -128,13 +118,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
>   */
>  int cpu_pm_exit(void)
>  {
> -	int ret;
> -
> -	read_lock(&cpu_pm_notifier_lock);
> -	ret = cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
> -	read_unlock(&cpu_pm_notifier_lock);
> -
> -	return ret;
> +	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_exit);
>  
> @@ -159,7 +143,6 @@ int cpu_cluster_pm_enter(void)
>  	int nr_calls;
>  	int ret = 0;
>  
> -	read_lock(&cpu_pm_notifier_lock);
>  	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
>  	if (ret)
>  		/*
> @@ -167,7 +150,6 @@ int cpu_cluster_pm_enter(void)
>  		 * PM entry who are notified earlier to prepare for it.
>  		 */
>  		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
> -	read_unlock(&cpu_pm_notifier_lock);
>  
>  	return ret;
>  }
> @@ -190,13 +172,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
>   */
>  int cpu_cluster_pm_exit(void)
>  {
> -	int ret;
> -
> -	read_lock(&cpu_pm_notifier_lock);
> -	ret = cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
> -	read_unlock(&cpu_pm_notifier_lock);
> -
> -	return ret;
> +	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
>  
> 
