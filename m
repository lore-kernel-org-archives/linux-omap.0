From: Alex Shi <alex.shi@linaro.org>
Subject: Re: RCU stall on panda
Date: Tue, 13 May 2014 14:36:25 +0800
Message-ID: <5371BD69.8010600@linaro.org>
References: <53675C5F.10509@linaro.org> <20140505180617.GM8754@linux.vnet.ibm.com> <20140512212102.GF5668@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:63687 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbaEMGgi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 02:36:38 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so630833pbb.3
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 23:36:37 -0700 (PDT)
In-Reply-To: <20140512212102.GF5668@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "naresh.kamboju@linaro.org Kamboju" <naresh.kamboju@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, LAK <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@linaro.org>, linux-omap@vger.kernel.org

On 05/13/2014 05:21 AM, Tony Lindgren wrote:
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [140505 11:11]:
>> On Mon, May 05, 2014 at 05:39:43PM +0800, Alex Shi wrote:
>>> I keep seeing the RCU stall problem on panda board from 3.10 kernel to latest upstream kernel
>>> and google find some one report it before: https://lkml.org/lkml/2012/9/20/519
>>>
>>> Is it the hardware issue or a real software problem?
>>
>> I cannot distinguish between hardware and software from the trace below,
>> but given that you are also seeing a soft lockup, either way you do
>> appear to have a real problem as opposed to an RCU CPU stall warning
>> false positive.
> 
> Looks like you have CPU_IDLE enabled on panda. Hangs with current linux
> next with CPU_IDLE are currently being discussed on the linux-omap list
> in thread "omap4-panda-es boot issues with v3.15-rc4"
> 
> I've seen occasional system hangs, and I've also noticed that doing
> ctrl-a-f h or ctrl-a-f l for sysrq backtrace can unlock the system
> producing similar errors to the below.
> 

Thanks a lot for the info.
In fact, the oops keeps in upstream kernel from 3.10 to latest.

> Regards,
> 
> Tony
>  
>>>   95.519653] INFO: rcu_sched self-detected stall on CPU^M
>>> [   95.519866]  1: (1 GPs behind) idle=2e7/1/0 softirq=4404/4405 ^M
>>> [   95.526489] INFO: rcu_sched detected stalls on CPUs/tasks:^M
>>> [   95.526489]  1: (1 GPs behind) idle=2e7/1/0 softirq=4404/4405 ^M
>>> [   95.526489]  (detected by 0, t=4229 jiffies, g=800, c=799, q=440)^M
>>> [   95.526519] Task dump for CPU 1:^M
>>> [   95.526519] swapper/1       R running      0     0      1 0x00000000^M
>>> [   95.559844]   (t=4229 jiffies g=800 c=799 q=440)^M
>>> [   95.564727] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.15.0-rc4 #93^M
>>> [   95.571502] [<c00133fd>] (unwind_backtrace) from [<c001076d>] (show_stack+0x11/0x14)^M
>>> [   95.579711] [<c001076d>] (show_stack) from [<c0570465>] (dump_stack+0x75/0x88)^M
>>> [   95.587371] [<c0570465>] (dump_stack) from [<c0084383>] (rcu_check_callbacks+0x353/0x79c)^M
>>> [   95.596038] [<c0084383>] (rcu_check_callbacks) from [<c003e99f>] (update_process_times+0x33/0x4c)^M
>>> [   95.605438] [<c003e99f>] (update_process_times) from [<c008e5a3>] (tick_sched_handle.isra.18+0x1f/0x48)^M
>>> [   95.615386] [<c008e5a3>] (tick_sched_handle.isra.18) from [<c008e609>] (tick_sched_timer+0x3d/0x5c)^M
>>> [   95.624969] [<c008e609>] (tick_sched_timer) from [<c0051a23>] (__run_hrtimer+0x67/0x310)^M
>>> [   95.633544] [<c0051a23>] (__run_hrtimer) from [<c00525fd>] (hrtimer_interrupt+0xe1/0x214)^M
>>> [   95.642211] [<c00525fd>] (hrtimer_interrupt) from [<c008cecb>] (tick_receive_broadcast+0x1f/0x30)^M
>>> [   95.651611] [<c008cecb>] (tick_receive_broadcast) from [<c0011e4f>] (handle_IPI+0xb3/0x120)^M
>>> [   95.660461] [<c0011e4f>] (handle_IPI) from [<c00085e5>] (gic_handle_irq+0x51/0x54)^M
>>> [   95.668487] [<c00085e5>] (gic_handle_irq) from [<c057603f>] (__irq_svc+0x3f/0x64)^M
>>> [   95.676391] Exception stack(0xee0dbf10 to 0xee0dbf58)^M
>>> [   95.681762] bf00:                                     00000001 00000001 00000000 ee0d8c40^M
>>> [   95.690429] bf20: 3c6bd296 00000016 3c6f8c43 00000016 eefab540 c08e0c84 00000000 c0fc7114^M
>>> [   95.699066] bf40: 00000010 ee0dbf58 c006ef4d c0443890 40000033 ffffffff^M
>>> [   95.706085] [<c057603f>] (__irq_svc) from [<c0443890>] (cpuidle_enter_state+0xc0/0xc4)^M
>>> [   95.714477] [<c0443890>] (cpuidle_enter_state) from [<c0444d11>] (cpuidle_enter_state_coupled+0xe1/0x290)^M
>>> [   95.724639] [<c0444d11>] (cpuidle_enter_state_coupled) from [<c0067cd1>] (cpu_startup_entry+0x1a5/0x494)^M
>>> [   95.734680] [<c0067cd1>] (cpu_startup_entry) from [<80008685>] (0x80008685)^M
>>> [   95.742095] BUG: soft lockup - CPU#1 stuck for 40s! [swapper/1:0]^M
>>> [   95.748535] Modules linked in:^M
>>> [   95.751770] irq event stamp: 128730^M
>>> [   95.755462] hardirqs last  enabled at (128727): [<c044388f>] cpuidle_enter_state+0xbf/0xc4^M
>>> [   95.764221] hardirqs last disabled at (128728): [<c0576033>] __irq_svc+0x33/0x64^M
>>> [   95.772064] softirqs last  enabled at (128730): [<c00386cd>] irq_enter+0x59/0x60^M
>>> [   95.779907] softirqs last disabled at (128729): [<c00386ba>] irq_enter+0x46/0x60^M
>>> [   95.787750] ^M
>>>
>>>
>>> my RCU and IDLE related kernel config as blow:
>>>
>>> CONFIG_TREE_RCU=y
>>> CONFIG_RCU_STALL_COMMON=y
>>> CONFIG_RCU_FANOUT=32
>>> CONFIG_RCU_FANOUT_LEAF=16
>>> CONFIG_TREE_RCU_TRACE=y
>>> CONFIG_PROVE_RCU=y
>>> CONFIG_PROVE_RCU_REPEATEDLY=y
>>> CONFIG_SPARSE_RCU_POINTER=y
>>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
>>> CONFIG_RCU_CPU_STALL_INFO=y
>>> CONFIG_RCU_TRACE=y
>>> alexs@alex-panda:~$ cat /proc/config.gz | gunzip | grep IDLE
>>> CONFIG_NO_HZ_IDLE=y
>>> CONFIG_GENERIC_SMP_IDLE_THREAD=y
>>> CONFIG_GENERIC_IDLE_POLL_SETUP=y
>>> CONFIG_CPU_IDLE=y
>>> CONFIG_CPU_IDLE_GOV_LADDER=y
>>> CONFIG_CPU_IDLE_GOV_MENU=y
>>> CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y
>>>
>>> -- 
>>> Thanks
>>>     Alex
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Thanks
    Alex
