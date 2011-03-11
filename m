From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri, 11 Mar 2011 01:07:07 +0100
Message-ID: <4D7967AB.1030404@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>	 <1299764643.2017.177.camel@deskari>  <4D78E3F5.2090600@openelec.tv> <1299768675.2017.230.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail04.solnet.ch ([212.101.4.138]:60598 "EHLO mail04.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab1CKAHL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 19:07:11 -0500
In-Reply-To: <1299768675.2017.230.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

Am 10.03.2011 15:51, schrieb Tomi Valkeinen:
> On Thu, 2011-03-10 at 08:45 -0600, Stephan Raue wrote:
>> Hi,
>>
>> if i try this patch series the boot stops after (seeing via serial console):
>>
>>     Starting kernel ...
>>
>>     Uncompressing Linux... done, booting the kernel.
>>
>> without this patch series i can see the boot to th OS. I am using this
>> patches on top of
>>
>>     http://gitorious.org/linux-omap-dss2/linux/commits/master
>>
>> Do i anything wrong or do i use a wrong git repo (the patches apply
>> cleanly)? Her my kernel config: http://fpaste.org/9Esw/
> Ah, I guess you hit one yet unsolved problem on on omap4: VENC register
> access fails.
>
> Can you try switching this off: CONFIG_OMAP2_DSS_VENC.
>
> I need to make some quick hack to get VENC disabled on OMAP4 until we
> find the solution for this.
>
>   Tomi
>
thanks, this helps to boot the kernel. but now i get:

[    3.281127] Power Management for TI OMAP4.
[    3.291870] mmc0: host does not support reading read-only switch. assuming write-enable.
[    3.312957] clock: disabling unused clocks to save power
[    3.318695] mmc0: new high speed SDHC card at address 0001
[    3.325622] mmcblk0: mmc0:0001 00000 7.46 GiB
[    3.333618]  mmcblk0: p1 p2
[    3.335540] Unhandled fault: imprecise external abort (0x1406) at 0xffed6a6a
[    3.335571] Internal error: : 1406 [#1] PREEMPT SMP
[    3.335571] last sysfs file:
[    3.335571] Modules linked in:
[    3.335571] CPU: 0    Not tainted  (2.6.38-rc8 #1)
[    3.335601] PC is at dss_clk_disable_no_ctx+0x0/0xa4
[    3.335632] LR is at omap_dispc_register_isr+0xa4/0xcc
[    3.335632] pc : [<c066b4f8>]    lr : [<c066c65c>]    psr: 20000093
[    3.335632] sp : ef845e20  ip : c0e6ffd0  fp : c09fbb90
[    3.335632] r10: c0f774ac  r9 : 00000088  r8 : c0673644
[    3.335662] r7 : 0004000e  r6 : a0000093  r5 : 00000000  r4 : 00000000
[    3.335662] r3 : f08c4000  r2 : f08c4000  r1 : 0006964a  r0 : 00000003
[    3.335662] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    3.335693] Control: 10c5387d  Table: 8000404a  DAC: 00000015
[    3.335693] Process swapper (pid: 1, stack limit = 0xef8442f8)
[    3.335693] Stack: (0xef845e20 to 0xef846000)
[    3.335693] 5e20: 00001887 c0f78588 00000000 c0f78588 00000044 00000001 eed70b40 c06735d8
[    3.335723] 5e40: c0f785f4 f0a00000 c0f785b4 60000013 00000080 ef814000 c09fd630 00000000
[    3.335723] 5e60: ef814698 ef814264 eeeae6e0 00000003 eeeae400 c067a528 00000000 c082f738
[    3.335723] 5e80: eeeae6e0 c09fd628 ef814694 eee26fc0 ef845ed8 c0537e70 00000001 bf600000
[    3.335754] 5ea0: f0a00000 02800280 000001e0 00000080 00000000 00000000 00000000 02800000
[    3.335754] 5ec0: 00ff01e0 c0538780 ef848000 c0830e38 ef804ac4 00000003 ef8ad4c0 00000000
[    3.335784] 5ee0: c09fd664 c09fd630 c09fd664 c0a0f540 c0a0f540 00000000 00000000 c09e776c
[    3.335784] 5f00: 00000000 c06bc470 c06bc45c c06bb670 00000000 c09fd630 c09fd664 c0a0f540
[    3.335784] 5f20: 00000000 c06bb794 c0a0f540 ef845f38 c06bb72c c06ba8c4 ef804a5c ef8ae054
[    3.335815] 5f40: c0a0f540 c0a0f540 eee24680 c0a19328 00000000 c06baf78 c092c550 00000480
[    3.335815] 5f60: ef845f50 c0a0f540 c002d640 c09e7680 c001edd8 00000000 c09e776c c06bb9dc
[    3.335815] 5f80: 00000000 c002d624 c002d640 c09e7680 c001edd8 00000000 c09e776c c001edfc
[    3.335845] 5fa0: ef844000 c041e644 c0933524 00000198 c0a01b8c c09e7680 c09e7770 c002d624
[    3.335845] 5fc0: c002d640 c09e7680 c09e7770 00000002 c09e776c c0008b2c 00000004 00000000
[    3.335876] 5fe0: c00089d4 c0423f1c 00000013 00000000 00000000 c0423f1c faffd73f 00100e0a
[    3.335876] [<c066b4f8>] (dss_clk_disable_no_ctx+0x0/0xa4) from [<c0f78588>] (num_managers+0x0/0x4)
[    3.335906] Code: e8bd8070 c0f77254 c0954a8a 000218de (e92d4038)
[    3.335906] ---[ end trace b7597bb719140d9a ]---
[    3.335906] note: swapper[1] exited with preempt_count 2
[    3.335937] Kernel panic - not syncing: Attempted to kill init!
[    3.588439] CPU1: stopping
[    3.591308] [<c0428bec>] (unwind_backtrace+0x0/0xe4) from [<c041e2d8>] (do_IPI+0xe4/0x15c)
[    3.600036] [<c041e2d8>] (do_IPI+0xe4/0x15c) from [<c08314cc>] (__irq_svc+0x4c/0xcc)
[    3.608184] Exception stack(0xef861b60 to 0xef861ba8)
[    3.613494] 1b60: c04582a0 ef861ba8 ef861b98 00000000 ef860000 00000282 00000002 ef861c00
[    3.622100] 1b80: 00000001 ef860000 00000001 0000000a 005b820e ef861ba8 c04582a0 c04582a4
[    3.630706] 1ba0: 60000113 ffffffff
[    3.634399] [<c08314cc>] (__irq_svc+0x4c/0xcc) from [<c04582a4>] (__do_softirq+0x6c/0x250)
[    3.643096] [<c04582a4>] (__do_softirq+0x6c/0x250) from [<c0458988>] (irq_exit+0x58/0xb0)
[    3.651733] [<c0458988>] (irq_exit+0x58/0xb0) from [<c041e29c>] (do_IPI+0xa8/0x15c)
[    3.659790] [<c041e29c>] (do_IPI+0xa8/0x15c) from [<c08314cc>] (__irq_svc+0x4c/0xcc)
[    3.667938] Exception stack(0xef861c00 to 0xef861c48)
[    3.673248] 1c00: 00000001 00000001 00000000 ef84a800 00000025 00000001 c09fe67c c0a32340
[    3.681854] 1c20: c6b2f9f3 00000001 00000001 00000036 60000113 ef861c48 c0452e18 c0452e20
[    3.690460] 1c40: 60000113 ffffffff
[    3.694152] [<c08314cc>] (__irq_svc+0x4c/0xcc) from [<c0452e20>] (vprintk+0x3d8/0x468)
[    3.702484] [<c0452e20>] (vprintk+0x3d8/0x468) from [<c082d2cc>] (printk+0x18/0x24)
[    3.710571] [<c082d2cc>] (printk+0x18/0x24) from [<c0533800>] (rescan_partitions+0x1e4/0x47c)
[    3.719543] [<c0533800>] (rescan_partitions+0x1e4/0x47c) from [<c050f7a8>] (__blkdev_get+0x230/0x2f4)
[    3.729248] [<c050f7a8>] (__blkdev_get+0x230/0x2f4) from [<c050fa20>] (blkdev_get+0x1b4/0x2bc)
[    3.738342] [<c050fa20>] (blkdev_get+0x1b4/0x2bc) from [<c06410bc>] (register_disk+0xdc/0x158)
[    3.747406] [<c06410bc>] (register_disk+0xdc/0x158) from [<c064121c>] (add_disk+0xe4/0x28c)
[    3.756225] [<c064121c>] (add_disk+0xe4/0x28c) from [<c0762dd8>] (mmc_blk_probe+0x2a8/0x2f4)
[    3.765106] [<c0762dd8>] (mmc_blk_probe+0x2a8/0x2f4) from [<c075bab8>] (mmc_bus_probe+0x14/0x18)
[    3.774383] [<c075bab8>] (mmc_bus_probe+0x14/0x18) from [<c06bb670>] (driver_probe_device+0xc8/0x184)
[    3.784088] [<c06bb670>] (driver_probe_device+0xc8/0x184) from [<c06ba5f8>] (bus_for_each_drv+0x4c/0x84)
[    3.794067] [<c06ba5f8>] (bus_for_each_drv+0x4c/0x84) from [<c06bb4c4>] (device_attach+0x68/0x94)
[    3.803405] [<c06bb4c4>] (device_attach+0x68/0x94) from [<c06bae28>] (bus_probe_device+0x24/0x40)
[    3.812774] [<c06bae28>] (bus_probe_device+0x24/0x40) from [<c06b91bc>] (device_add+0x394/0x524)
[    3.822021] [<c06b91bc>] (device_add+0x394/0x524) from [<c075be24>] (mmc_add_card+0xf4/0x134)
[    3.830993] [<c075be24>] (mmc_add_card+0xf4/0x134) from [<c075e7e8>] (mmc_attach_sd+0x158/0x1dc)
[    3.840270] [<c075e7e8>] (mmc_attach_sd+0x158/0x1dc) from [<c075b7f0>] (mmc_rescan+0x204/0x264)
[    3.849426] [<c075b7f0>] (mmc_rescan+0x204/0x264) from [<c0468790>] (process_one_work+0x2d8/0x510)
[    3.858856] [<c0468790>] (process_one_work+0x2d8/0x510) from [<c046aa60>] (worker_thread+0x1c0/0x2b8)
[    3.868591] [<c046aa60>] (worker_thread+0x1c0/0x2b8) from [<c046e3e4>] (kthread+0x80/0x88)
[    3.877288] [<c046e3e4>] (kthread+0x80/0x88) from [<c0423f1c>] (kernel_thread_exit+0x0/0x8)

see also: http://paste.pocoo.org/show/351648/

if i remove this patchserie again it boots, see here: http://paste.pocoo.org/show/351650/

thanks

Stephan


