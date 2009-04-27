From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Card detect IRQ errors
Date: Mon, 27 Apr 2009 12:13:13 +0300
Message-ID: <6ed0b2680904270213s6ef02ad6i26173245019bca15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:50727 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZD0JNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 05:13:15 -0400
Received: by bwz7 with SMTP id 7so2152013bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 02:13:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>

With current l-o head when I insert or remove SD card I'm getting this:

[   20.733489] ------------[ cut here ]------------
[   20.738159] WARNING: at kernel/irq/handle.c:366 handle_IRQ_event+0x4c/0x14c()
[   20.745330] BUG: IRQ handler called from non-hardirq
context!Modules linked in:
[   20.752685] [<8002b388>] (unwind_backtrace+0x0/0xdc) from
[<80048128>] (warn_slowpath+0x64/0x88)
[   20.761596] [<80048128>] (warn_slowpath+0x64/0x88) from
[<8006a80c>] (handle_IRQ_event+0x4c/0x14c)
[   20.770629] [<8006a80c>] (handle_IRQ_event+0x4c/0x14c) from
[<8006bde8>] (handle_edge_irq+0x10c/0x14c)
[   20.780029] [<8006bde8>] (handle_edge_irq+0x10c/0x14c) from
[<801862a8>] (handle_twl4030_sih+0x9c/0xd0)
[   20.789520] [<801862a8>] (handle_twl4030_sih+0x9c/0xd0) from
[<801861b0>] (twl4030_irq_thread+0x108/0x164)
[   20.799255] [<801861b0>] (twl4030_irq_thread+0x108/0x164) from
[<80059708>] (kthread+0x54/0x80)
[   20.808044] [<80059708>] (kthread+0x54/0x80) from [<8004ab68>]
(do_exit+0x0/0x56c)
[   20.815704] [<8004ab68>] (do_exit+0x0/0x56c) from [<8ecf0ae0>] (0x8ecf0ae0)
[   20.822753] ---[ end trace 2ca2d8ba630dd6b5 ]---
[   20.869415] mmc0: card 8001 removed

Has anyone else seen this?
