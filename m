From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 23:20:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F56@dbde02.ent.ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
 <20110624140142.GM9449@n2100.arm.linux.org.uk>
 <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
 <20110624141402.GN9449@n2100.arm.linux.org.uk>
 <20110624151201.GO9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39196 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab1FXRvB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 13:51:01 -0400
In-Reply-To: <20110624151201.GO9449@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Friday, June 24, 2011 8:42 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation
> 
> Right, thanks for the file.  Here's the patch.
> 
> --- omap2plus-cpufreq.c~	2011-06-24 15:50:32.000000000 +0100
> +++ omap2plus-cpufreq.c	2011-06-24 16:00:08.000000000 +0100
> @@ -44,6 +44,16 @@
>  static char *mpu_clk_name;
>  static struct device *mpu_dev;
>  
> +#ifdef CONFIG_SMP
> +struct lpj_info {
> +	unsigned long	ref;
> +	unsigned int	freq;
> +};
> +
> +static DEFINE_PER_CPU(struct lpj_info, lpj_ref);
> +static struct lpj_info global_lpj_ref;
> +#endif
> +
>  static int omap_verify_speed(struct cpufreq_policy *policy)
>  {
>  	if (!freq_table)
> @@ -109,14 +119,25 @@
>  	freqs.new = omap_getspeed(policy->cpu);
>  
>  #ifdef CONFIG_SMP
> -	/* Adjust jiffies before transition */
> +	/* Adjust per-cpu loops_per_jiffy before transition */
>  	for_each_cpu(i, policy->cpus) {
> -		unsigned long lpj = per_cpu(cpu_data, 
> i).loops_per_jiffy;
> -
> -		per_cpu(cpu_data, i).loops_per_jiffy = 
> cpufreq_scale(lpj,
> -							freqs.old,
> -							freqs.new);
> +		struct lpj_info *lpj = &per_cpu(lpj_ref, i);
> +		if (!lpj->freq) {
> +			lpj->ref = per_cpu(cpu_data, i).loops_per_jiffy;
> +			lpj->freq = freqs.old;
> +		}
> +
> +		per_cpu(cpu_data, i).loops_per_jiffy =
> +			cpufreq_scale(lpj->ref, lpj->freq, freqs.new);
> +	}
> +
> +	/* And don't forget to adjust the global one */
> +	if (!global_lpj_ref.freq) {
> +		global_lpj_ref.ref = loops_per_jiffy;
> +		global_lpj_ref.freq = freqs.old;
>  	}
> +	loops_per_jiffy = cpufreq_scale(global_lpj_ref.ref, 
> global_lpj_ref.freq,
> +					freqs.new);
>  #endif
>  
>  	/* Notify transitions */
> 
> 
> Notice how we adjust _both_ the per-cpu loops_per_jiffy, and that we
> adjust them with reference to the initial values.
> 
> If you adjust lpj with reference to the last, then you _will_ build up
> a progressively bigger and bigger error in the value over time.
> 

Russell,

I was able to test BogoMIPS calculations via /proc/cpuinfo for
both with & without CONFIG_SMP selected.

For most part things work fine - but I do notice occassional Oops
and segmentation faults while doing "cat /proc/cpuinfo"

With CONFIG_SMP enabled, system doesn't recover from the Oops;
but without SMP - I noticed segmentation faults/ BUG but system
does recover.

They could be unrelated - but i didn't see any of these earlier
today. I will continue debug on MON.

Here are details:

[1] This log comes corresponds to CONFIG_SMP enabled.

[2] This corresponds to running "cat /proc/cpuinfo" in a tight
    loop. (CONFIG_SMP disabled).
    
[3] Saw only once today - but had seen it few days ago. None
    of my local changes included. (CONFIG_SMP disabled).
    [http://marc.info/?l=linux-omap&m=130884641524123&w=2]

~sanjeev

=== [1]

[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
[   73.832366] Internal error: Oops - undefined instruction: 0 [#1] SMP
[   73.839019] Modules linked in:
[   73.842193] CPU: 0    Not tainted  (3.0.0-rc3-14002-g40b6752-dirty #21)
[   73.849121] PC is at __do_fault+0x1c0/0x450
[   73.853485] LR is at __do_fault+0x2b0/0x450
[   73.857879] pc : [<c010fa18>]    lr : [<c010fb08>]    psr: 00000113
[   73.857879] sp : c7907d48  ip : 00000000  fp : c5d518c0
[   73.869873] r10: 00000200  r9 : 40214000  r8 : 00000000
[   73.875335] r7 : c2692f98  r6 : c0ad7600  r5 : 87fb018f  r4 : 00000000
[   73.882141] r3 : 87fb0a3e  r2 : 00000800  r1 : 87fb01cf  r0 : c5d518c0
[   73.888977] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   73.896423] Control: 10c5387d  Table: 8795c019  DAC: 00000015
[   73.902435] Process cat (pid: 449, stack limit = 0xc79062f8)
[   73.908355] Stack: (0xc7907d48 to 0xc7908000)
[   73.912902] 7d40:                   00000008 c795d008 00000000 00000000 c5d4d050 c5d518f4
[   73.921447] 7d60: 00000000 0000000c 40214000 c0ad7600 00000002 0000000c c795d008 00000000
[   73.929992] 7d80: 40214000 c5d518c0 40214000 c2692f98 be91579c c0110760 0000000c 00000000
[   73.938537] 7da0: 00000000 c00bb088 00000002 c5d518c0 00000000 c03111a0 00000000 c795c000
[   73.947113] 7dc0: c795d008 00000201 40214000 c5d518c0 00000000 c2692f98 be91579c c0111184
[   73.955657] 7de0: c795d008 00000000 c2692f98 c7907fb0 00000017 402140ea c5d518c0 402140ea
[   73.964202] 7e00: c5d51914 c031138c c78c6180 00000000 00000002 0000002f 00000017 c78c6180
[   73.972747] 7e20: c08da030 c00b9184 c08da030 c00b9184 c5d518c4 c00b7860 c78c6180 c78c6180
[   73.981292] 7e40: c04787dc 00000000 c04af0e0 0000013e 00000000 00000000 00000002 c00b9184
[   73.989868] 7e60: 00000000 00000000 c78c6180 00000001 c78c6180 00000000 a2217a4d 3caba335
[   73.998413] 7e80: 89831c46 a201fb19 4c802a1d c78c65e0 0000002f 00000000 0895e1ee 8cafea22
[   74.006958] 7ea0: 2f5807fc 70396d1c 752baa3e 00000001 c78c6180 00000007 00000006 000080d0
[   74.015502] 7ec0: c2692b78 00000000 00000000 00000000 00000000 c5d51928 00000002 60000093
[   74.024047] 7ee0: 00000000 c00bb088 00000002 c044d374 0001b900 00000017 c7907fb0 402140ea
[   74.032592] 7f00: 402140ea 4032d068 be91579c c003e480 60000013 00001000 c5d51914 00000003
[   74.041168] 7f20: be915a14 c030e788 00000002 00000000 c021e1b4 00000000 c048cb1c c7906000
[   74.049713] 7f40: 4008e000 00000000 c78c6180 c030ecf4 00000000 00000000 00001000 c00b7ba0
[   74.058258] 7f60: c5d51918 60000013 00000000 c030ecf4 c78c6180 c030f1d8 000004b0 4021051c
[   74.066802] 7f80: 4021c998 c00b7ba0 ffffffff 0001b900 000004b0 c030f1d8 ffffffff 0001b900
[   74.075347] 7fa0: 000004b0 4021051c 4021c998 c030f50c 402140ea 4005c950 be91587c 4005cb08
[   74.083892] 7fc0: 00000015 0001b900 000004b0 4021051c 4021c998 402140ea 4032d068 be91579c
[   74.092468] 7fe0: 00000000 be9156d0 400403f8 4003e6f4 20000010 ffffffff ffffffff ffffffff
[   74.101013] [<c010fa18>] (__do_fault+0x1c0/0x450) from [<c0110760>] (handle_pte_fault+0x74/0x674)
[   74.110290] [<c0110760>] (handle_pte_fault+0x74/0x674) from [<c0111184>] (handle_mm_fault+0x94/0xc4)
[   74.119842] [<c0111184>] (handle_mm_fault+0x94/0xc4) from [<c031138c>] (do_page_fault+0x2b8/0x358)
[   74.129211] [<c031138c>] (do_page_fault+0x2b8/0x358) from [<c003e480>] (do_DataAbort+0x38/0x98)
[   74.138336] [<c003e480>] (do_DataAbort+0x38/0x98) from [<c030f50c>] (ret_from_exception+0x0/0x10)
[   74.147613] Exception stack(0xc7907fb0 to 0xc7907ff8)
[   74.152862] 7fa0:                                     402140ea 4005c950 be91587c 4005cb08
[   74.161437] 7fc0: 00000015 0001b900 000004b0 4021051c 4021c998 402140ea 4032d068 be91579c
[   74.169982] 7fe0: 00000000 be9156d0 400403f8 4003e6f4 20000010 ffffffff
[   74.176879] Code: e1a01005 e3a02000 ebfd1694 e59d0014 (eb07fcba)
[   74.183380] ---[ end trace 9fe8ca36c9812c43 ]---
[   86.665679] BUG: spinlock lockup on CPU#0, cat/449, c5d518f4
[   86.671661] [<c00509c4>] (unwind_backtrace+0x0/0xf8) from [<c0227320>] (do_raw_spin_lock+0xec/0x178)
[   86.681213] [<c0227320>] (do_raw_spin_lock+0xec/0x178) from [<c0112578>] (unmap_vmas+0x188/0x620)
[   86.690521] [<c0112578>] (unmap_vmas+0x188/0x620) from [<c0114fd4>] (exit_mmap+0x10c/0x23c)
[   86.699279] [<c0114fd4>] (exit_mmap+0x10c/0x23c) from [<c007f4bc>] (mmput+0x54/0x118)
[   86.707489] [<c007f4bc>] (mmput+0x54/0x118) from [<c00838a0>] (exit_mm+0x13c/0x194)
[   86.715545] [<c00838a0>] (exit_mm+0x13c/0x194) from [<c0085864>] (do_exit+0x660/0x714)
[   86.723846] [<c0085864>] (do_exit+0x660/0x714) from [<c004dafc>] (die+0x2d8/0x2f4)
[   86.731781] [<c004dafc>] (die+0x2d8/0x2f4) from [<c003e204>] (do_undefinstr+0x14c/0x150)
[   86.740264] [<c003e204>] (do_undefinstr+0x14c/0x150) from [<c030f0e4>] (__und_svc+0x44/0x60)
[   86.749114] Exception stack(0xc7907cc0 to 0xc7907d08)
[   86.754394] 7cc0: c5d518c0 87fb01cf 00000800 87fb0a3e 00000000 87fb018f c0ad7600 c2692f98
[   86.762969] 7ce0: 00000000 40214000 00000200 c5d518c0 00000000 c7907d48 c010fb08 c010fa18
[   86.771514] 7d00: 00000113 ffffffff
[   86.775177] [<c030f0e4>] (__und_svc+0x44/0x60) from [<c010fa18>] (__do_fault+0x1c0/0x450)
[   86.783752] [<c010fa18>] (__do_fault+0x1c0/0x450) from [<c0110760>] (handle_pte_fault+0x74/0x674)
[   86.793060] [<c0110760>] (handle_pte_fault+0x74/0x674) from [<c0111184>] (handle_mm_fault+0x94/0xc4)
[   86.802612] [<c0111184>] (handle_mm_fault+0x94/0xc4) from [<c031138c>] (do_page_fault+0x2b8/0x358)
[   86.812011] [<c031138c>] (do_page_fault+0x2b8/0x358) from [<c003e480>] (do_DataAbort+0x38/0x98)
[   86.821136] [<c003e480>] (do_DataAbort+0x38/0x98) from [<c030f50c>] (ret_from_exception+0x0/0x10)
[   86.830444] Exception stack(0xc7907fb0 to 0xc7907ff8)
[   86.835723] 7fa0:                                     402140ea 4005c950 be91587c 4005cb08
[   86.844299] 7fc0: 00000015 0001b900 000004b0 4021051c 4021c998 402140ea 4032d068 be91579c
[   86.852874] 7fe0: 00000000 be9156d0 400403f8 4003e6f4 20000010 ffffffff


=== [2]

[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
[   99.083923] Unable to handle kernel paging request at virtual address 85d44831
[   99.091583] pgd = c5d30000
[   99.094390] [85d44831] *pgd=00000000
[   99.098175] Internal error: Oops: 5 [#1]
[   99.102264] Modules linked in:
[   99.105468] CPU: 0    Not tainted  (3.0.0-rc3-14002-g40b6752-dirty #22)
[   99.112365] PC is at find_get_pages+0xd8/0x170
[   99.117004] LR is at 0x2
[   99.119659] pc : [<c00d3cc4>]    lr : [<00000002>]    psr: 60000113
[   99.119659] sp : c7945d08  ip : 00000001  fp : c7945d58
[   99.131652] r10: c759b89c  r9 : c5d3e860  r8 : c7945d58
[   99.137115] r7 : 00000013  r6 : 00000000  r5 : c5d37900  r4 : c5d31000
[   99.143951] r3 : c759b758  r2 : 85d44831  r1 : 00000001  r0 : c759b89c
[   99.150756] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   99.158203] Control: 10c5387d  Table: 85d30019  DAC: 00000015
[   99.164215] Process sh (pid: 446, stack limit = 0xc79442f0)
[   99.170043] Stack: (0xc7945d08 to 0xc7946000)
[   99.174591] 5d00:                   c78cc280 c78cc6c0 00000001 00000001 c759b758 00000001
[   99.183135] 5d20: c5d472b4 c5d31000 00000000 00000000 c5d3e860 c7945d58 400d3000 c5d3e860
[   99.191680] 5d40: c5d47280 c00edf20 00000129 00000000 00000000 c5d472e8 00000000 00000013
[   99.200256] 5d60: 400d3000 00000000 00000002 00000013 c5d31000 00000000 400d3000 c5d47280
[   99.208801] 5d80: 400d3000 c5d3e860 00000000 c00eedf8 00000013 00000000 00000000 c00a1114
[   99.217346] 5da0: 00000002 c5d47280 00000000 c02e4760 00000000 c5d30000 c5d31000 00000200
[   99.225891] 5dc0: 400d3000 c5d47280 00000000 c5d3e860 00000000 c00ef89c c5d31000 00000000
[   99.234436] 5de0: c5d3e860 c7945fb0 00000007 400d3c6c c5d47280 400584b0 c5d472d4 c02e4948
[   99.242980] 5e00: 00000000 c02e47d0 c0413fc0 c043f468 80000007 c78cc280 0000081f c78cc280
[   99.251525] 5e20: 00000002 60000093 00000000 c00a1114 00000000 c042c204 00000000 00000001
[   99.260070] 5e40: c045d510 00000044 00000006 c5e3c000 00000000 00000000 c78cc280 00000001
[   99.268646] 5e60: c78cc280 c02e258c 00000000 c781e8c0 c5e3c000 c009dd48 c5e3c0ac 60000013
[   99.277191] 5e80: 00000000 c78cc6c0 00000044 00000000 beacd7ec c0229940 00000001 00000000
[   99.285736] 5ea0: c0229894 0000000b 20000113 00000000 00000002 00000000 c78cc280 00000000
[   99.294281] 5ec0: 00000000 00000000 00000000 c5e32694 00000002 60000093 00000000 c00a1114
[   99.302825] 5ee0: 00000002 c03fff0c 000d72cc 00000007 c03fff7c c7945fb0 400584b0 400d3c6c
[   99.311370] 5f00: 00000000 c0034208 000d7008 c00342a4 c78cc280 c02e2554 c7945f84 c78cc280
[   99.319915] 5f20: c5e321ac c009dd48 c5e32684 00000003 c7945f84 c02e2554 0000000a c007b0a8
[   99.328491] 5f40: c7944000 00000000 000d7008 00000000 c7945f84 00000003 00000000 c7945f84
[   99.337036] 5f60: 000000ae c003f8a8 00000000 c007b26c c78cc280 c02e2c7c 00000000 000d727c
[   99.345581] 5f80: 400584b0 c009dd48 ffffffff 000d72cc 00000000 ffffffff 000d72cc 00000000
[   99.354125] 5fa0: 000d727c 400584b0 000d727c c02e2c8c 000d72cc 000d726c 000d727c 000d6dfc
[   99.362670] 5fc0: 000d726c 000d72cc 00000000 000d727c 400584b0 400584b0 000d727c 00000000
[   99.371215] 5fe0: 000d450c beacd804 000d4104 400d3c6c 60000010 ffffffff 00000000 00000000
[   99.379791] [<c00d3cc4>] (find_get_pages+0xd8/0x170) from [<c5d3e860>] (0xc5d3e860)
[   99.387786] Code: e1a0c001 eafffff2 e5942000 e5903000 (e5923000)
[   99.394195] ---[ end trace a04771993a740cbe ]---
Segmentation fault
[root@OMAP3EVM cpufreq]#

=== [3]

[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
[   90.313537] BUG: looking up invalid subclass: 3348054496
[   90.319122] turning off the locking correctness validator.
[   90.324859] [<c00509c4>] (unwind_backtrace+0x0/0xf8) from [<c00ba6b4>] (__lock_acquire+0x1984/0x1d90)
[   90.334503] [<c00ba6b4>] (__lock_acquire+0x1984/0x1d90) from [<c00bb088>] (lock_acquire+0xd4/0xf8)
[   90.343902] [<c00bb088>] (lock_acquire+0xd4/0xf8) from [<c030e780>] (_raw_spin_lock_irqsave+0x44/0x58)
[   90.353637] [<c030e780>] (_raw_spin_lock_irqsave+0x44/0x58) from [<c021e44c>] (__down_read_trylock+0x14/0x54)
[   90.364013] [<c021e44c>] (__down_read_trylock+0x14/0x54) from [<c00a69a4>] (down_read_trylock+0x14/0x54)
[   90.373931] [<c00a69a4>] (down_read_trylock+0x14/0x54) from [<c03111a0>] (do_page_fault+0xcc/0x358)
[   90.383392] [<c03111a0>] (do_page_fault+0xcc/0x358) from [<c003e480>] (do_DataAbort+0x38/0x98)
[   90.392395] [<c003e480>] (do_DataAbort+0x38/0x98) from [<c030f50c>] (ret_from_exception+0x0/0x10)
[   90.401672] Exception stack(0xc796ffb0 to 0xc796fff8)
