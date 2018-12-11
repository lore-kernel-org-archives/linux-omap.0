From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next-20181211 with fsverity changes
Date: Tue, 11 Dec 2018 11:12:20 -0800
Message-ID: <20181211191220.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>, Theodore Ts'o <tytso@mit.edu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 4de97efb578a ("fsverity: Move verity status check
to fsverity_file_open") causes a boot regression for me with root
on ext4 SDIO card, see below.

Any ideas what goes wrong?

Regards,

Tony

8< ----------------------
Starting init: /bin/sh exists but couldn't execute it (error -95)
Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.20.0-rc6-next-20181211 #1080
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0112a18>] (unwind_backtrace) from [<c010d090>] (show_stack+0x10/0x14)
[<c010d090>] (show_stack) from [<c08eb854>] (dump_stack+0xb0/0xe8)
[<c08eb854>] (dump_stack) from [<c0110da4>] (handle_IPI+0x318/0x380)
[<c0110da4>] (handle_IPI) from [<c0534930>] (gic_handle_irq+0x94/0xa8)
[<c0534930>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0x70/0x98)
Exception stack(0xee911ef8 to 0xee911f40)
1ee0:                                                       00000001 00000001
1f00: 00000000 ee90a180 00000000 c0e13fc4 00000000 ef6afbb8 c0ec8830 de03d29f
1f20: 00000000 00000000 00000000 ee911f48 c01a4120 c06f8fb4 20000153 ffffffff
[<c01019f0>] (__irq_svc) from [<c06f8fb4>] (cpuidle_enter_state+0x270/0x46c)
[<c06f8fb4>] (cpuidle_enter_state) from [<c06fb0a4>] (cpuidle_enter_state_coupled+0x148/0x3e0)
[<c06fb0a4>] (cpuidle_enter_state_coupled) from [<c0173398>] (do_idle+0x234/0x2b8)
[<c0173398>] (do_idle) from [<c01737b4>] (cpu_startup_entry+0x18/0x1c)
[<c01737b4>] (cpu_startup_entry) from [<8010274c>] (0x8010274c)
---[ end Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance. ]---
