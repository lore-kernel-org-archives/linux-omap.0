From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: remove custom abort handler for t410
Date: Wed, 14 Oct 2015 09:53:06 -0700
Message-ID: <20151014165306.GD10113@atomide.com>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
 <1444834113-18122-3-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1444834113-18122-3-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Hauke Mehrtens <hauke@hauke-m.de>, patchwork-lst@pengutronix.de, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Lucas Stach <l.stach@pengutronix.de> [151014 07:52]:
> This is not needed anymore. Handling a potentially pending imprecise external
> abort left behind by the bootloader is now done in a slightly safer way inside
> the common ARM startup code.

With commit bbeb92095159 ("ARM: 8422/1: enable imprecise aborts during early
kernel startup") we now see where it breaks :) It seems to be related to
misconfigured SRAM size or something in the t410 case:

[    0.363485] Unhandled fault: imprecise external abort (0xc06) at 0xc08b156c
[    0.370732] pgd = c0004000
[    0.373598] [c08b156c] *pgd=8080040e(bad)
[    0.377817] Internal error: : c06 [#1] SMP ARM
[    0.382470] Modules linked in:
[    0.385702] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.3.0-rc5-00001-g3b6348b #1672
[    0.394999] Hardware name: Generic ti814x (Flattened Device Tree)
[    0.401348] task: ee08ed40 ti: ee090000 task.ti: ee090000
[    0.406988] PC is at omap_rev+0x0/0x10
[    0.410930] LR is at omap_sram_init+0xf8/0x3e0
[    0.415586] pc : [<c00259c8>]    lr : [<c08b12e0>]    psr: 60000013
[    0.415586] sp : ee091eb0  ip : f004a800  fp : 00000099
[    0.427563] r10: c08f1858  r9 : 00000000  r8 : c08a57c4
[    0.433019] r7 : c09d0000  r6 : ee0e8980  r5 : 00000000  r4 : c09d08dc
[    0.439812] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : f004a000
[    0.446609] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    0.454030] Control: 10c5387d  Table: 80004019  DAC: 00000051
[    0.460024] Process swapper/0 (pid: 1, stack limit = 0xee090218)
[    0.466283] Stack: (0xee091eb0 to 0xee092000)
[    0.470849] 1ea0:                                     c08efa48 00000000 00000000 ee0e8980
[    0.479347] 1ec0: c09d0000 c08aca0c c08efa48 c08faf44 c0904844 c08b581c c08efa48 c091a3b0
[    0.487847] 1ee0: c091a3b0 c08b5478 c08efa48 c08a57e0 00000000 c00098a4 ee08ed40 c0951e2c
[    0.496346] 1f00: ee08f280 00000000 ee08ed00 00000004 00000006 00000000 ef7fcb3d c066c6b8
[    0.504843] 1f20: 00000099 c005eba0 00000001 00000000 c086e2b4 ef7fcb51 00000003 00000003
[    0.513340] 1f40: c090ab00 c090ac0c c090ac14 00000003 c09d0000 c09d0000 c08f1840 00000000
[    0.521841] 1f60: c08f1858 c08a2ec4 00000003 00000003 00000000 c08a2594 ffffffff 00000000
[    0.530340] 1f80: c063a54c 00000000 c063a54c 00000000 00000000 00000000 00000000 00000000
[    0.538837] 1fa0: 00000000 c063a554 00000000 c000f890 00000000 00000000 00000000 00000000
[    0.547333] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.555832] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[    0.564333] [<c00259c8>] (omap_rev) from [<c08b12e0>] (omap_sram_init+0xf8/0x3e0)
[    0.572118] [<c08b12e0>] (omap_sram_init) from [<c08aca0c>] (omap_sdrc_init+0x10/0xb0)
[    0.580349] [<c08aca0c>] (omap_sdrc_init) from [<c08b581c>] (pdata_quirks_init+0x18/0x44)
[    0.588850] [<c08b581c>] (pdata_quirks_init) from [<c08b5478>] (omap_generic_init+0x10/0x1c)
[    0.597619] [<c08b5478>] (omap_generic_init) from [<c08a57e0>] (customize_machine+0x1c/0x40)
[    0.606390] [<c08a57e0>] (customize_machine) from [<c00098a4>] (do_one_initcall+0x80/0x1dc)
[    0.615068] [<c00098a4>] (do_one_initcall) from [<c08a2ec4>] (kernel_init_freeable+0x218/0x2e8)
[    0.624107] [<c08a2ec4>] (kernel_init_freeable) from [<c063a554>] (kernel_init+0x8/0xec)
[    0.632522] [<c063a554>] (kernel_init) from [<c000f890>] (ret_from_fork+0x14/0x24)
[    0.640397] Code: e3a03000 e5843064 e8bd8010 c0959e3c (e59f3004)
[    0.646756] ---[ end trace cb88537fdc8fa202 ]---

Your patch does not affect this, I need to fix up things for t410 anyways. So
please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
