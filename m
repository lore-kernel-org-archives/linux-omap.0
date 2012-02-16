From: Kevin Hilman <khilman@ti.com>
Subject: SMP local timers and their CPUfreq notifiers setup on OMAP3
Date: Thu, 16 Feb 2012 10:24:40 -0800
Message-ID: <8739aahc0n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:41523 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752773Ab2BPSYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 13:24:41 -0500
Received: by dakp5 with SMTP id p5so2685825dak.22
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 10:24:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Santosh,

Using v3.3-rc3 and building an OMAP2+ kernel I noticed that CPUfreq
transitions fault because of the TWD cpufreq notifiers being called even
on OMAP3.

Of course, the TWD doesn't exist on OMAP3, but the TWD init is still
setting up notifiers.  I tried just adding a !cpu_is_omap44xx() check
in local_timer_setup(), but that didn't do it, so there's more timer
init that needs to be fixed up.  Can you have a look at this?

It's easy to reproduce by just manually triggering a frequency change
with the userspace governor.  Here's what I did on my 3430/n900:

# cd /sys/devices/system/cpu/cpu0/cpufreq
# cat scaling_available_frequencies
# echo 250000 > scaling_setspeed           
[   13.785797] Unable to handle kernel paging request at virtual address 007e900
[   13.793426] pgd = cdc20000                                                   
[   13.796295] [007e9000] *pgd=00000000                                         
[   13.800079] Internal error: Oops: 5 [#1] SMP                                 
[   13.804595] Modules linked in:                                               
[   13.807830] CPU: 0    Not tainted  (3.3.0-rc3-pm+debug+initramfs #9)         
[   13.814544] PC is at twd_update_frequency+0x34/0x48                          
[   13.819671] LR is at twd_update_frequency+0x10/0x48                          
[   13.824829] pc : [<c001382c>]    lr : [<c0013808>]    psr: 60000093          
[   13.824829] sp : ce311dd8  ip : 00000000  fp : 00000000                      
[   13.836914] r10: 00000000  r9 : 00000001  r8 : ce310000                      
[   13.842437] r7 : c0440458  r6 : c00137f8  r5 : 00000000  r4 : c0947a74       
[   13.849304] r3 : 00000000  r2 : 007e9000  r1 : 00000000  r0 : 00000000       
[   13.856201] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment usr
[   13.863800] Control: 10c5387d  Table: 8dc20019  DAC: 00000015                
[   13.869842] Process sh (pid: 599, stack limit = 0xce3102f8)                  
[   13.875732] Stack: (0xce311dd8 to 0xce312000)                                
[   13.880310] 1dc0:                                                       6000c
[   13.888946] 1de0: 00000001 00000002 00000000 00000000 00000000 00000000 00000
[   13.897583] 1e00: ffffffff c093d8f0 00000000 ce311ebc 00000001 00000001 ce310
[   13.906188] 1e20: c001386c c0437c4c c0e95b60 c0e95ba8 00000001 c0e95bf8 ffff4
[   13.914825] 1e40: 00000000 00000000 c005ef74 ce310000 c0435cf0 ce311ebc 00000
[   13.923431] 1e60: ce352b40 0007a120 c08d5108 c08ba040 c08ba040 c005f030 00000
[   13.932067] 1e80: c08bc554 c032fe2c 0007a120 c08d4b64 ce352b40 c08d8618 ffff8
[   13.940673] 1ea0: c08ba040 c033364c ce311ecc c0433b50 00000002 ffffffea c0330
[   13.949310] 1ec0: 0007a120 0007a120 22222201 00000000 22222222 00000000 ce357
[   13.957946] 1ee0: ce3d6000 cdc2aed8 ce352ba0 c0470164 00000002 c032f47c 00034
[   13.966552] 1f00: c0331cac ce352b40 00000007 c032f6d0 ce352bbc 0003d090 c0930
[   13.975189] 1f20: c093d8bc c03306a4 00000007 ce311f80 00000007 cdc2aec0 ce358
[   13.983795] 1f40: ce8d20c0 00000007 b6fe5000 ce311f80 00000007 ce310000 0000c
[   13.992431] 1f60: c000de74 ce987400 ce8d20c0 b6fe5000 00000000 00000000 0000c
[   14.001037] 1f80: 00000000 00000000 001fbac8 00000000 00000007 001fbac8 00004
[   14.009674] 1fa0: c000df04 c000dd60 00000007 001fbac8 00000001 b6fe5000 00000
[   14.018280] 1fc0: 00000007 001fbac8 00000007 00000004 b6fe5000 00000000 00202
[   14.026916] 1fe0: 00000000 beb565f8 00101ffc 00008e8c 60000010 00000001 00000
[   14.035552] [<c001382c>] (twd_update_frequency+0x34/0x48) from [<c008ac4c>] )
[   14.046478] [<c008ac4c>] (smp_call_function_single+0x17c/0x1c8) from [<c0013)
[   14.057586] [<c0013890>] (twd_cpufreq_transition+0x24/0x30) from [<c0437c4c>)
[   14.068054] [<c0437c4c>] (notifier_call_chain+0x44/0x84) from [<c005efe4>] ()
[   14.078887] [<c005efe4>] (__srcu_notifier_call_chain+0x70/0xa4) from [<c005f)
[   14.090179] [<c005f030>] (srcu_notifier_call_chain+0x18/0x20) from [<c032fe2)
[   14.101470] [<c032fe2c>] (cpufreq_notify_transition+0xc8/0x1b0) from [<c0333)
[   14.111755] [<c033364c>] (omap_target+0x1b4/0x28c) from [<c032f47c>] (__cpuf)
[   14.121765] [<c032f47c>] (__cpufreq_driver_target+0x50/0x64) from [<c0331d24)
[   14.131561] [<c0331d24>] (cpufreq_set+0x78/0x98) from [<c032f6d0>] (store_sc)
[   14.141296] [<c032f6d0>] (store_scaling_setspeed+0x5c/0x74) from [<c03306a4>)
[   14.150482] [<c03306a4>] (store+0x58/0x74) from [<c014d868>] (sysfs_write_fi)
[   14.159118] [<c014d868>] (sysfs_write_file+0x80/0xb4) from [<c00f2c2c>] (vfs)
[   14.168212] [<c00f2c2c>] (vfs_write+0xa8/0x138) from [<c00f2e9c>] (sys_write)
[   14.176666] [<c00f2e9c>] (sys_write+0x40/0x6c) from [<c000dd60>] (ret_fast_s)
[   14.185577] Code: e594300c e792210c e1a01000 e5840004 (e7930002)             
[   14.192169] ---[ end trace 5da3b5167c1ecdda ]---     
