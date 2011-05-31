From: "stanley.miao" <stanley.miao@windriver.com>
Subject: (Bug report) the kernel crash when I run cyclictest on AM3715/DM3730
Date: Tue, 31 May 2011 10:22:54 +0800
Message-ID: <4DE450FE.1050402@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:40356 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab1EaCW5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 22:22:57 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p4V2Mu6a015782
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 19:22:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The test command :

# cyclictest -l100000000 -m -a0 -t1 -n -p99 -i200 -h200 -q
I run the following command to increase cpu's burden at the same time.
# while true; do hackbench; sleep 1;done

cyclictest and hackbench can be get in 
git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

The linux kernel version :

the kernel I used is windriver linux kernel. but this bug can also be reproduced 
on the branch OMAPPSP_03.00.01.06 in 
git://arago-project.org/git/projects/linux-omap3.git.
The kernel in linux-omap-2.6 git tree hung and didn't give any useful Oops 
messages when I ran this cyclictest.

The Oops messages (it crashed in many different places):

1,

root@localhost:/root> cyclictest -l100000000 -m -a0 -t1 -n -p99 -i200 -h200 -q
Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa3069e4
Internal error: : 1028 [#1] PREEMPT
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in: x_tables ip_tables ipv6 sctp binfmt_misc [last unloaded: 
scsi_wait_scan]
CPU: 0    Not tainted  (2.6.34.9-WR4.2.0.0_standard #3)
PC is at prm_read_mod_reg+0x34/0x44
LR is at pwrdm_wait_transition+0x40/0x90
pc : [<c004bf7c>]    lr : [<c004c76c>]    psr: a00000d3
sp : c072bec0  ip : c004bf5c  fp : c072becc
r10: 00000000  r9 : 413fc082  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : c072efe0  r4 : 00000000
r3 : fa306800  r2 : fa004948  r1 : 000000e4  r0 : 000001e4
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 86858019  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc072a2e8)
Stack: (0xc072bec0 to 0xc072c000)
bec0: c072bee4 c072bed0 c004c76c c004bf54 c072f940 00000003 c072befc c072bee8
bee0: c004ce8c c004c738 00000003 c072f940 c072bf14 c072bf00 c0054b4c c004ce6c
bf00: c072efe0 00000001 c072bf3c c072bf18 c004fa90 c0054b0c c077e6bc c077e6a0
bf20: 00000003 00000003 8002f56c 0000001f c072bf74 c072bf40 c0051a38 c004f58c
bf40: 0000492b 00000000 c6bcee00 c0731340 386d4532 2ac85836 c0731340 c07313b0
bf60: c082a350 c072e420 c072bf9c c072bf78 c046dd58 c005198c c046dca0 c072a000
bf80: c0032018 c0032014 8002f56c 413fc082 c072bfb4 c072bfa0 c003e99c c046dcac
bfa0: c07f2630 00000002 c072bfcc c072bfb8 c0557d6c c003e944 00000000 c07f4368
bfc0: c072bff4 c072bfd0 c0008a74 c0557cc0 c0008584 00000000 00000000 c0032018
bfe0: 10c53c7d c077dd70 00000000 c072bff8 80008034 c00087dc 00000000 00000000
[<c004bf7c>] (prm_read_mod_reg+0x34/0x44) from [<c004c76c>] 
(pwrdm_wait_transition+0x40/0x90)
[<c004c76c>] (pwrdm_wait_transition+0x40/0x90) from [<c004ce8c>] 
(pwrdm_clkdm_state_switch+0x2c/0x40)
[<c004ce8c>] (pwrdm_clkdm_state_switch+0x2c/0x40) from [<c0054b4c>] 
(omap2_clkdm_allow_idle+0x4c/0x50)
[<c0054b4c>] (omap2_clkdm_allow_idle+0x4c/0x50) from [<c004fa90>] 
(omap_sram_idle+0x510/0x534)
[<c004fa90>] (omap_sram_idle+0x510/0x534) from [<c0051a38>] 
(omap3_enter_idle+0xb8/0x150)
[<c0051a38>] (omap3_enter_idle+0xb8/0x150) from [<c046dd58>] 
(cpuidle_idle_call+0xb8/0x198)
[<c046dd58>] (cpuidle_idle_call+0xb8/0x198) from [<c003e99c>] (cpu_idle+0x64/0xbc)
[<c003e99c>] (cpu_idle+0x64/0xbc) from [<c0557d6c>] (rest_init+0xb8/0xd4)
[<c0557d6c>] (rest_init+0xb8/0xd4) from [<c0008a74>] (start_kernel+0x2a4/0x30c)
[<c0008a74>] (start_kernel+0x2a4/0x30c) from [<80008034>] (0x80008034)
Code: e59f0014 e3a010aa ebffd57e e0810000 (e7930000)

2,

root@localhost:/root> cyclictest -l100000000 -m -a0 -t1 -n -p99 -i200 -h200 -q
Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa318034
Internal error: : 1028 [#1] PREEMPT
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in: x_tables ip_tables ipv6 sctp binfmt_misc [last unloaded: 
scsi_wait_scan]
CPU: 0    Not tainted  (2.6.34.9-WR4.2.0.0_standard #5)
PC is at omap_dm_timer_set_load_start+0x30/0x94
LR is at omap2_gp_timer_set_next_event+0x28/0x34
pc : [<c005a0a0>]    lr : [<c0047fb0>]    psr: 20000093
sp : c0709e58  ip : c005a084  fp : c0709e74
r10: c0709f10  r9 : 00000466  r8 : 3824a2bc
r7 : 00000000  r6 : ffffff91  r5 : 00000000  r4 : c0717564
r3 : fa318000  r2 : ffffff91  r1 : 00000000  r0 : c0717564
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 864cc019  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc07082e8)
Stack: (0xc0709e58 to 0xc070a000)
9e40:                                                       c075a4a0 c070ea38
<snip the stack data>
[<c005a0a0>] (omap_dm_timer_set_load_start+0x30/0x94) from [<c0047fb0>] 
(omap2_gp_timer_set_next_event+0x28/0x34)
[<c0047fb0>] (omap2_gp_timer_set_next_event+0x28/0x34) from [<c0098fd0>] 
(clockevents_program_event+0xec/0x104)
[<c0098fd0>] (clockevents_program_event+0xec/0x104) from [<c00999e8>] 
(tick_dev_program_event+0x4c/0x160)
[<c00999e8>] (tick_dev_program_event+0x4c/0x160) from [<c0099b84>] 
(tick_program_event+0x38/0x44)
[<c0099b84>] (tick_program_event+0x38/0x44) from [<c0090a70>] 
(__hrtimer_start_range_ns+0x248/0x31c)
[<c0090a70>] (__hrtimer_start_range_ns+0x248/0x31c) from [<c0090bb4>] 
(hrtimer_start_range_ns+0x34/0x3c)
[<c0090bb4>] (hrtimer_start_range_ns+0x34/0x3c) from [<c009ad54>] 
(tick_nohz_restart_sched_tick+0x1ac/0x214)
[<c009ad54>] (tick_nohz_restart_sched_tick+0x1ac/0x214) from [<c003c9d0>] 
(cpu_idle+0x98/0xbc)
[<c003c9d0>] (cpu_idle+0x98/0xbc) from [<c0541094>] (rest_init+0xb8/0xd4)
[<c0541094>] (rest_init+0xb8/0xd4) from [<c0008a74>] (start_kernel+0x2a4/0x30c)
[<c0008a74>] (start_kernel+0x2a4/0x30c) from [<80008034>] (0x80008034)
Code: e3130004 1a000000 ea000003 e5943010 (e5933034)

3,

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa320010
Internal error: : 1028 [#2] PREEMPT
last sysfs file: /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
Modules linked in: x_tables ip_tables ipv6 sctp binfmt_misc [last unloaded: 
scsi_wait_scan]
CPU: 0    Not tainted  (2.6.34.9-WR4.2.0.0_standard #6)
PC is at omap_readl+0x18/0x20
LR is at omap34xx_32k_read+0x1c/0x38
pc : [<c0059bb4>]    lr : [<c005586c>]    psr: 600001d3
sp : c0721890  ip : c0059bb0  fp : c072189c
r10: c072f488  r9 : c0720000  r8 : 00000000
r7 : 0000026b  r6 : 0001ee12  r5 : c077a3c0  r4 : c07218e8
r3 : c0055850  r2 : 1fd67bb3  r1 : 00000000  r0 : fa320010
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 869b4019  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc07202e8)
Stack: (0xc0721890 to 0xc0722000)
1880:                                     c07218ac c07218a0 c005586c c0059ba8
<snip the stack dump>
[<c0059bb4>] (omap_readl+0x18/0x20) from [<c005586c>] (omap34xx_32k_read+0x1c/0x38)
[<c005586c>] (omap34xx_32k_read+0x1c/0x38) from [<c009b85c>] (ktime_get+0x80/0xec)
[<c009b85c>] (ktime_get+0x80/0xec) from [<c009f9d4>] (tick_check_idle+0x40/0xd4)
[<c009f9d4>] (tick_check_idle+0x40/0xd4) from [<c0079ed8>] (irq_enter+0x70/0x9c)
[<c0079ed8>] (irq_enter+0x70/0x9c) from [<c003b028>] (asm_do_IRQ+0x28/0x9c)
[<c003b028>] (asm_do_IRQ+0x28/0x9c) from [<c003bbb4>] (__irq_svc+0x54/0xbc)
Exception stack(0xc0721940 to 0xc0721988)




Analysis:

All the kernel crashes occurred at the time when registers were read. These 
register belongs to prm module, GPTIMER module and 32k sync timer module. All 
these module are in wakeup domain. I utilize a ICE to debug this problem. And I 
found all the registers in the wakeup domain cannot be read when the 
do_DataAbort() was called, whereas the registers in other domains still can be read.

Taking consideration of the wakeup domain is always active and this kernel 
crashed even when I disabled the CONFIG_PM, I think this problem could probably 
be a hardware bug. I guess there might be some problem with L4-wakeup 
interconnect which is used to read registers in wakeup domain.

Hope someone can give me advices to fix this problem or confirm this is a 
hardware bug.


Regards.

Stanley.
