From: Anand Gadiyar <gadiyar@ti.com>
Subject: linux-next 20101115 fails to boot on zoom3
Date: Mon, 15 Nov 2010 18:59:20 +0530
Message-ID: <4CE135B0.8070405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42337 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754535Ab0KON32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 08:29:28 -0500
Received: by mail-yw0-f41.google.com with SMTP id 6so1129220ywi.28
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 05:29:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

Hi all,

Linux-next as of 20101115 fails to boot up on a zoom3. earlyprintk throws
the following crash.

[    0.000000] MUX: Add partition: #1: core, flags: 0
[    0.000000] Unable to handle kernel paging request at virtual address 01000268
[    0.000000] pgd = c0004000
[    0.000000] [01000268] *pgd=00000000
[    0.000000] Internal error: Oops: 805 [#1]
[    0.000000] last sysfs file:
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Tainted: G        W    (2.6.37-rc1-mode1-debug+ #8)
[    0.000000] PC is at omap_mux_write+0x1c/0x28
[    0.000000] LR is at omap_mux_write_array+0x30/0x44
[    0.000000] pc : [<c04a9798>]    lr : [<c04a97d4>]    psr: 40000013
[    0.000000] sp : c7819ee0  ip : c7819ef0  fp : c7819eec
[    0.000000] r10: 00000002  r9 : c786b9c8  r8 : c048e078
[    0.000000] r7 : c782a480  r6 : fa002030  r5 : c048ec14  r4 : 00000004
[    0.000000] r3 : 01000100  r2 : 00000168  r1 : 0000011c  r0 : fa002030
[    0.000000] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387f  Table: 80004019  DAC: 00000017
[    0.000000] Process swapper (pid: 1, stack limit = 0xc78182f0)
[    0.000000] Stack: (0xc7819ee0 to 0xc781a000)
[    0.000000] 9ee0: c7819f0c c7819ef0 c04a97d4 c04a9788 0000ffff c782a480 c786b9c0 c097b3a8
[    0.000000] 9f00: c7819f64 c7819f10 c000f1a4 c04a97b0 c07f3b48 c07f3a50 c09708b0 00000000
[    0.000000] 9f20: c08d0300 c782a494 c7819f44 c7819f38 00000000 c09708b0 c7819f6c c002f600
[    0.000000] 9f40: c000ba2c c04c7434 00000000 00000000 00000000 00000000 c7819f84 c7819f68
[    0.000000] 9f60: c0010364 c000ed38 c048b7c8 c048aad8 c048ec14 c048a160 c7819f94 c7819f88
[    0.000000] 9f80: c0013224 c00102d8 c7819fa4 c7819f98 c000ba4c c0013218 c7819fdc c7819fa8
[    0.000000] 9fa0: c04943d4 c000ba38 00000191 c0008644 c04c7434 00000013 c002f600 c0008644
[    0.000000] 9fc0: c04c7434 00000013 00000000 00000000 c7819ff4 c7819fe0 c00086e0 c049430c
[    0.000000] 9fe0: 00000000 00000000 00000000 c7819ff8 c04c7434 c0008650 fdffffff fffffffe
[    0.000000] Backtrace:
[    0.000000] [<c04a977c>] (omap_mux_write+0x0/0x28) from [<c04a97d4>] (omap_mux_write_array+0x30/0x44)
[    0.000000] [<c04a97a4>] (omap_mux_write_array+0x0/0x44) from [<c000f1a4>] (omap_mux_init+0x478/0x4e4)
[    0.000000]  r6:c097b3a8 r5:c786b9c0 r4:c782a480 r3:0000ffff
[    0.000000] [<c000ed2c>] (omap_mux_init+0x0/0x4e4) from [<c0010364>] (omap3_mux_init+0x98/0xc4)
[    0.000000] [<c00102cc>] (omap3_mux_init+0x0/0xc4) from [<c0013224>] (omap_zoom_init+0x18/0x54)
[    0.000000] [<c001320c>] (omap_zoom_init+0x0/0x54) from [<c000ba4c>] (customize_machine+0x20/0x2c)
[    0.000000] [<c000ba2c>] (customize_machine+0x0/0x2c) from [<c04943d4>] (do_one_initcall+0xd4/0x1a8)
[    0.000000] [<c0494300>] (do_one_initcall+0x0/0x1a8) from [<c00086e0>] (kernel_init+0x9c/0x154)
[    0.000000] [<c0008644>] (kernel_init+0x0/0x154) from [<c04c7434>] (do_exit+0x0/0x5f0)
[    0.000000]  r4:00000000 r3:00000000
[    0.000000] Code: e5903004 e3130001 e5903010 16ef1071 (018210b3)
[    0.000000] ---[ end trace 1b75b31a2719ed1e ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill init!

I've bisected it down to this commit:

commit 78b017cab9338a015d8c20d6b1e35f276073a35a
Author: Benoit Cousson <b-cousson@ti.com>
Date:   Thu Nov 11 22:35:16 2010 +0100

    OMAP: mux: Add support for control module split in several partitions


Just reporting for now. I'll take a stab at fixing this tomorrow,
unless someone beats me to it.

- Anand
