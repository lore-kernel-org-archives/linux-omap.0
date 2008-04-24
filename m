From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Thu, 24 Apr 2008 21:54:31 +0200
Message-ID: <372691CB-3FF8-43FE-9E0D-F771DD8996FE@student.utwente.nl>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl> <200804220957.43599.david-b@pacbell.net> <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl> <20080422170758.GB10347@kedavra.cpe.vivax.com.br> <BF39A517-6A64-4B10-B595-CBBF2F6BF5D0@student.utwente.nl> <20080424002120.GE27546@atomide.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:33202 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757808AbYDXTyj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2008 15:54:39 -0400
Received: from [172.20.1.5] (vpn006030.vpn.utwente.nl [130.89.6.30])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m3OJsXlg006740
          for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 21:54:33 +0200
In-Reply-To: <20080424002120.GE27546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 24 apr 2008, om 02:21 heeft Tony Lindgren het volgende geschreven:
> Hi,
>
> * Koen Kooi <k.kooi@student.utwente.nl> [080423 00:42]:
>> From dac3cdc5952ab39fa7ae0545d43e2daa95329b07 Mon Sep 17 00:00:00  
>> 2001
>> From: Koen Kooi <koen@openembedded.org>
>> Date: Wed, 23 Apr 2008 09:38:31 +0200
>> Subject: [PATCH] omap3beagle: register SD interface
>
> Thanks for updating it. I've pushed it now, but I had to apply some
> parts manually because of recent changes. Can you please check it
> got applied OK?

I compiled an booted latest git and see this:

6>TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
<1>Unable to handle kernel NULL pointer dereference at virtual address  
00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.25-omap1 #11)
PC is at __rcu_process_callbacks+0x1ac/0x244
LR is at free_task+0x38/0x40
pc : [<c0073924>]    lr : [<c0048b04>]    psr: 80000113
sp : c7c1dda8  ip : c7c085c0  fp : c7c1ddc4
r10: 00000000  r9 : c0405678  r8 : 00000001
r7 : c0400d80  r6 : 00000005  r5 : 00000000  r4 : c040563c
r3 : 00000000  r2 : 00000027  r1 : c7c78340  r0 : c7c085c0
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc7c1c2e0)
Stack: (0xc7c1dda8 to 0xc7c1e000)
dda0:                   c02fae30 c0400e04 00000001 00000008 c7c1ddd4  
c7c1ddc8
ddc0: c00739d4 c0073784 c7c1de04 c7c1ddd8 c004f6f4 c00739c8 c7c1de04  
c03dd4e0
dde0: 00000025 00000000 c03fc8f5 c7c1df14 c03ece00 00000049 c7c1de1c  
c7c1de08
de00: c004f79c c004f6a0 c03dd4e0 c03dd4e0 c7c1de3c c7c1de20 c002c050  
c004f760
de20: 00000010 ffffffff d8200000 00000000 c7c1defc c7c1de40 c002c630  
c002c00c
de40: c03daec8 000007f0 00000000 40000013 c03fc8ac c03ed158 00000000  
c03fc8f5
de60: c7c1df14 c03ece00 00000049 c7c1defc c7c1de58 c7c1de88 c004ab10  
c004b228
de80: 60000013 ffffffff c7c1dea4 c7c1dea4 c7c1dee4 40000013 c02faabc  
c0067800
dea0: c0194a14 22222222 22222222 22222222 22222222 c7ca0470 c7c1dee4  
c7c1dec8
dec0: c02fadd0 c0067534 00000000 c7ca0470 c03ece58 c03ecff8 c03ed158  
00000000
dee0: 00000001 c7ca0438 c03ece00 c7ca05ac c7c1df0c c7c1df00 c03b2c00  
c004af70
df00: c7c1df54 c7c1df20 c01ad5e0 c03b2bf4 c03989af c03ed158 c7ca05ac  
00000001
df20: c03ece00 00000000 00000000 c7ca0438 c03ece00 c03ec870 00000000  
c7c1c000
df40: 00000000 c0027404 c7c1df74 c7c1df58 c01aa41c c01ad524 00000000  
c00260bc
df60: 00000000 00000000 c7c1df84 c7c1df78 c001c870 c01aa37c c7c1dff4  
c7c1df88
df80: c0008620 c001c864 c7c1dfac c7c1df98 c004801c c0047ea4 307ffe12  
00000000
dfa0: 00000000 c7c1dfb0 c002cb04 c0048004 00000000 00000000 c0008550  
c004d8f8
dfc0: 00000000 00000001 00000000 00000000 00000000 00000000 00000000  
00000000
dfe0: 00000000 00000000 00000000 c7c1dff8 c004d8f8 c000855c 002ffe02  
0073ecca
Backtrace:
[<c0073778>] (__rcu_process_callbacks+0x0/0x244) from [<c00739d4>]  
(rcu_process_callbacks+0x18/0x38)
  r6:00000008 r5:00000001 r4:c0400e04
[<c00739bc>] (rcu_process_callbacks+0x0/0x38) from [<c004f6f4>]  
(__do_softirq+0x60/0xc0)
[<c004f694>] (__do_softirq+0x0/0xc0) from [<c004f79c>] (irq_exit 
+0x48/0x88)
[<c004f754>] (irq_exit+0x0/0x88) from [<c002c050>]  
(__exception_text_start+0x50/0x68)
  r4:c03dd4e0
[<c002c000>] (__exception_text_start+0x0/0x68) from [<c002c630>]  
(__irq_svc+0x30/0x80)
Exception stack(0xc7c1de40 to 0xc7c1de88)
de40: c03daec8 000007f0 00000000 40000013 c03fc8ac c03ed158 00000000  
c03fc8f5
de60: c7c1df14 c03ece00 00000049 c7c1defc c7c1de58 c7c1de88 c004ab10  
c004b228
de80: 60000013 ffffffff
  r6:00000000 r5:d8200000 r4:ffffffff
[<c004af64>] (vprintk+0x0/0x30c) from [<c03b2c00>] (printk+0x1c/0x24)
[<c03b2be4>] (printk+0x0/0x24) from [<c01ad5e0>]  
(twl4030_attach_adapter+0xc8/0x69c)
  r3:00000001 r2:c7ca05ac r1:c03ed158 r0:c03989af
[<c01ad518>] (twl4030_attach_adapter+0x0/0x69c) from [<c01aa41c>]  
(i2c_register_driver+0xac/0xf8)
[<c01aa370>] (i2c_register_driver+0x0/0xf8) from [<c001c870>]  
(twl4030_init+0x18/0x20)
  r7:00000000 r6:00000000 r5:c00260bc r4:00000000
[<c001c858>] (twl4030_init+0x0/0x20) from [<c0008620>] (kernel_init 
+0xd0/0x29c)
[<c0008550>] (kernel_init+0x0/0x29c) from [<c004d8f8>] (do_exit 
+0x0/0x5ec)
Code: e5943024 e3530000 099da870 e3a06000 (e5935000)
<0>Kernel panic - not syncing: Fatal exception in interrupt

More bootlogs at http://amethyst.openembedded.net/~koen/beagleboard/beagle-i2c-crash.txt

I suspect it's somewhere in i2c, but I have no proof for that. Any  
quick guesses what might be causing this?

regards,

Koen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIEOV5MkyGM64RGpERAoIlAKCl71J80g7O8yLnmQC53DPIrNYmwQCfV9kq
PRME+NAiBykLP575dTjMocM=
=1y57
-----END PGP SIGNATURE-----
