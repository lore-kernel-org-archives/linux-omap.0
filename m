From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 2/6] Serial: Add UART4 hwmod data.
Date: Fri, 21 May 2010 16:48:50 -0700
Message-ID: <87y6fcerz1.fsf@deeprootsystems.com>
References: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:53604 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab0EUXsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 19:48:53 -0400
Received: by pzk6 with SMTP id 6so687169pzk.1
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 16:48:52 -0700 (PDT)
In-Reply-To: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Thu\, 20 May 2010 19\:08\:24 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Introduce UART4 hwmod data for OMAP3630
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Just FYI...

After adding UART4 to the master list, it hangs on 3630/Zoom3 (log below)

I didn't dig into this one yet.

Kevin

[...]
Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz                              
omap_hwmod: uart4: cannot clk_get main_clk uart4_fck                            
omap_hwmod: uart4: cannot clk_get interface_clk uart4_ick                       
omap_hwmod: l3_hwmod: cannot be enabled (3)                                     
omap_hwmod: l4_core_hwmod: cannot be enabled (3)                                
omap_hwmod: l4_per_hwmod: cannot be enabled (3)                                 
omap_hwmod: l4_wkup_hwmod: cannot be enabled (3)                                
Unhandled fault: external abort on non-linefetch (0x1028) at 0xfb042054         
Internal error: : 1028 [#1] PREEMPT                                             
last sysfs file:                                                                
Modules linked in:                                                              
CPU: 0    Not tainted  (2.6.34-pm-next-default-10673-g60b93ed #3)               
PC is at omap_hwmod_readl+0x10/0x18                                             
LR is at _update_sysc_cache+0x44/0x74                                           
pc : [<c0523adc>]    lr : [<c05240bc>]    psr: a00001d3                         
sp : c08c5f10  ip : c08c5f20  fp : c08c5f1c                                     
r10: 0000001f  r9 : 413fc082  r8 : 80028340                                     
r7 : c08c82cc  r6 : c0524c98  r5 : 00000001  r4 : c08dcc2c                      
r3 : fb042000  r2 : 00000004  r1 : 00000054  r0 : c08dcc2c                      
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel           
Control: 10c5387f  Table: 80004019  DAC: 00000017                               
Process swapper (pid: 0, stack limit = 0xc08c42e8)                              
Stack: (0xc08c5f10 to 0xc08c6000)                                               
5f00:                                     c08c5f34 c08c5f20 c05240bc c0523ad8   
5f20: 00000000 c08dcc2c c08c5f4c c08c5f38 c0524740 c0524084 00000012 c08dcc2c   
5f40: c08c5f64 c08c5f50 c0524d28 c052463c c08dcc2c 00000000 c08c5f84 c08c5f68   
5f60: c0523e14 c0524ca4 c090ae5c c08e4e30 c08e4e30 c050c014 c08c5f94 c08c5f88   
5f80: c05241d0 c0523df0 c08c5fac c08c5f98 c000e530 c052417c c090a200 c050c018   
5fa0: c08c5fbc c08c5fb0 c0013894 c000e460 c08c5fcc c08c5fc0 c000b438 c001386c   
5fc0: c08c5ff4 c08c5fd0 c0008a6c c000b40c c00086b8 00000000 00000000 c050c018   
5fe0: 10c53c7d c090a5a0 00000000 c08c5ff8 80008034 c0008914 00000000 00000000   
Backtrace:                                                                      
[<c0523acc>] (omap_hwmod_readl+0x0/0x18) from [<c05240bc>] (_update_sysc_cache+)
[<c0524078>] (_update_sysc_cache+0x0/0x74) from [<c0524740>] (_enable+0x110/0x1)
 r4:c08dcc2c r3:00000000                                                        
[<c0524630>] (_enable+0x0/0x134) from [<c0524d28>] (_setup+0x90/0x100)          
 r4:c08dcc2c r3:00000012                                                        
[<c0524c98>] (_setup+0x0/0x100) from [<c0523e14>] (omap_hwmod_for_each+0x30/0x7)
 r5:00000000 r4:c08dcc2c                                                        
[<c0523de4>] (omap_hwmod_for_each+0x0/0x78) from [<c05241d0>] (omap_hwmod_late_)
 r6:c050c014 r5:c08e4e30 r4:c08e4e30 r3:c090ae5c                                
[<c0524170>] (omap_hwmod_late_init+0x0/0x8c) from [<c000e530>] (omap2_init_comm)
[<c000e454>] (omap2_init_common_hw+0x0/0x194) from [<c0013894>] (omap_zoom_init)
 r5:c050c018 r4:c090a200                                                        
[<c0013860>] (omap_zoom_init_irq+0x0/0x50) from [<c000b438>] (init_IRQ+0x38/0x4)
[<c000b400>] (init_IRQ+0x0/0x48) from [<c0008a6c>] (start_kernel+0x164/0x2d0)   
[<c0008908>] (start_kernel+0x0/0x2d0) from [<80008034>] (0x80008034)            
 r5:c090a5a0 r4:10c53c7d                                                        
Code: e1a0c00d e92dd800 e24cb004 e5903038 (e7910003)                            

