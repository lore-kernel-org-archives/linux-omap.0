From: Paolo Pisati <p.pisati@gmail.com>
Subject: 3.8rc4+ and cpu_freq omap: hangs, oopses, etcetc
Date: Wed, 23 Jan 2013 17:24:08 +0100
Message-ID: <20130123162408.GB4123@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36758 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab3AWQYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 11:24:13 -0500
Received: by mail-wi0-f172.google.com with SMTP id o1so876427wic.11
        for <linux-omap@vger.kernel.org>; Wed, 23 Jan 2013 08:24:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi,

i can't boot my pandaes with 3.8rc4 + cpu_freq + ehci/ohci enabled, as it usually
hangs with:

[   26.718322] INFO: rcu_sched detected stalls on CPUs/tasks: { 1} (detected by 0, t=2690 jiffies, g=4294967100, c=4294967099, q=749)
[   26.730682] Task dump for CPU 1:
[   26.734069] udevd           R running      0   772      1 0x00000002
[   26.740783] [<c04e287c>] (__schedule+0x34c/0x728) from [<eebbaa70>] (0xeebbaa70)

complete dmesg with clks warnings and a "BUG: spinlock wrong CPU on CPU#1"
here:

http://paste.ubuntu.com/1563384/

sometimes it randomly oopses around usb:

[    4.922180] hub 1-1:1.0: port 1: status 0101 change 0001
[    4.936706] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[    4.945220] pgd = c0004000
[    4.948059] [00000004] *pgd=00000000
[    4.951843] Internal error: Oops: 5 [#1] SMP ARM
[    4.956695] Modules linked in:
[    4.959899] CPU: 1    Tainted: G        W     (3.8.0-rc4-00139-g1d85490 #1)
[    4.967224] PC is at _set_bit+0x1c/0x40
[    4.971252] LR is at out_of_memory+0x7c/0x2f8
[    4.975830] pc : [<c02aacfc>]    lr : [<c00ce7d0>]    psr: 60000193
[    4.975830] sp : ee839a40  ip : 00000000  fp : 00000000
[    4.987884] r10: 0000000e  r9 : c088f5d8  r8 : c07ab33c
[    4.993377] r7 : ee8373c0  r6 : c07d1014  r5 : c1547e90  r4 : 00000000
[    5.000244] r3 : 00040000  r2 : 00000001  r1 : 00000004  r0 : 00000000
[    5.007080] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    5.014862] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
[    5.020904] Process swapper/0 (pid: 1, stack limit = 0xee838240)
[    5.023437] usb 1-1: link qh256-0001/eeda8b00 start 1 [1/0 us]
[    5.023468] hub 1-1:1.0: state 7 ports 5 chg 0002 evt 0000
[    5.023773] hub 1-1:1.0: port 1, status 0101, change 0000, 12 Mb/s

Complete dmesg here:

http://paste.ubuntu.com/1563423/

Or:

[    4.927307] Unable to handle kernel NULL pointer dereference at virtual address 00000014
[    4.935821] pgd = c0004000
[    4.938659] [00000014] *pgd=00000000
[    4.942413] Internal error: Oops: 5 [#1] SMP ARM
[    4.947265] Modules linked in:
[    4.950469] CPU: 1    Tainted: G        W     (3.8.0-rc4 #1)
[    4.956420] PC is at rcu_irq_exit+0x20/0xc4
[    4.960845] LR is at irq_enter+0x18/0x70
[    4.964965] pc : [<c00a6d74>]    lr : [<c0049a0c>]    psr: a0000193
[    4.964965] sp : ee87de90  ip : fffffff2  fp : ee87df54
[    4.977020] r10: c07491d0  r9 : 00000000  r8 : 00000001
[    4.982482] r7 : c073ae80  r6 : a0000193  r5 : 00000001  r4 : ee87c000
[    4.989349] r3 : c0745d88  r2 : 00000000  r1 : 00000560  r0 : c0049a0c
[    4.992736] usb 1-1: link qh256-0001/eedb0f80 start 1 [1/0 us]
[    4.992767] hub 1-1:1.0: state 7 ports 5 chg 0002 evt 0000
[    4.993255] hub 1-1:1.0: port 1, status 0101, change 0000, 12 Mb/s

Complete dmesg here:

http://paste.ubuntu.com/1563483/

Same happens with latest linus/master:

1d85490 Merge tag '3.8-pci-fixes-2' of ...

Config can be found here:

http://people.canonical.com/~ppisati/38rc4/config.omap2plus_cpufreq

Disabling cpufreq i can get my board to boot, and 3.7.y is working fine.

Any clue?
-- 
bye,
p.
