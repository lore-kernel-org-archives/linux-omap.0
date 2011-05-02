From: AJ ONeal <coolaj86@gmail.com>
Subject: WARNING: at handle_irq_event_percpu
Date: Mon, 2 May 2011 14:43:29 -0600
Message-ID: <BANLkTi=Zn=T6QpzXv=BtdRLbCW2U1dMKbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53014 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1EBUnt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 16:43:49 -0400
Received: by pwi15 with SMTP id 15so2827799pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 02 May 2011 13:43:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

I've got a Gumstix Overo with linux-2.6.39-rc5 (pulled from Sakoman's tree).

Every boot I get this message. I'm not sure whether I should be
worried about it or not.

[    1.996582] ------------[ cut here ]------------
[    2.001586] WARNING: at kernel/irq/handle.c:130
handle_irq_event_percpu+0xf8/0x220()
[    2.010101] irq 379 handler twl_rtc_interrupt+0x0/0x94 enabled interrupts
[    2.017272] Modules linked in:
[    2.020538] [<c00471ec>] (unwind_backtrace+0x0/0xe0) from
[<c006aa4c>] (warn_slowpath_common+0x4c/0x64)
[    2.030456] [<c006aa4c>] (warn_slowpath_common+0x4c/0x64) from
[<c006aae4>] (warn_slowpath_fmt+0x2c/0x3c)
[    2.040557] [<c006aae4>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c00a5880>] (handle_irq_event_percpu+0xf8/0x220)
[    2.051025] [<c00a5880>] (handle_irq_event_percpu+0xf8/0x220) from
[<c00a59e4>] (handle_irq_event+0x3c/0x5c)
[    2.061401] [<c00a59e4>] (handle_irq_event+0x3c/0x5c) from
[<c00a76b8>] (handle_edge_irq+0x104/0x13c)
[    2.071166] [<c00a76b8>] (handle_edge_irq+0x104/0x13c) from
[<c02a4eb4>] (handle_twl4030_sih+0xac/0xd4)
[    2.081085] [<c02a4eb4>] (handle_twl4030_sih+0xac/0xd4) from
[<c02a4d98>] (twl4030_irq_thread+0xb4/0x108)
[    2.091186] [<c02a4d98>] (twl4030_irq_thread+0xb4/0x108) from
[<c008546c>] (kthread+0x7c/0x84)
[    2.100311] [<c008546c>] (kthread+0x7c/0x84) from [<c00429b8>]
(kernel_thread_exit+0x0/0x8)
[    2.109161] ---[ end trace 041d11a82aa47d13 ]---


There are few differences between `omap2plus_defconfig` and my config
(only enough to get it to boot on the overo)

I only enable the board features that my board has (and disable
everything else) and I turn on devtmpfs :

System Type --->
  TI OMAP2/3/4 Specific Features --->
     * Typical OMAP configuration
     * TI OMAP3
     * Gumstix Overo Board

Device Drivers -->
  Generic Driver Options --->
    * Maintain a devtmpfs filesystem to mount at /dev
      * Automount devtmpfs at /dev, after the kernel mounted the rootfs


Also, I'm not loading any modules either.


Is this an expected / okay failure?

AJ ONeal
