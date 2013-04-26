From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [net-next PATCH 1/1] drivers: net: cpsw: fix kernel warn on cpsw
 irq enable
Date: Fri, 26 Apr 2013 17:48:08 +0400
Message-ID: <517A8598.3090602@cogentembedded.com>
References: <1366975848-31503-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:51939 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261Ab3DZNt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 09:49:28 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so3726392lbc.41
        for <linux-omap@vger.kernel.org>; Fri, 26 Apr 2013 06:49:26 -0700 (PDT)
In-Reply-To: <1366975848-31503-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, Sebastian Siewior <bigeasy@linutronix.de>

Hello.

On 26-04-2013 15:30, Mugunthan V N wrote:

> With the commit id a11fbba

    Please also specify that commit's summary line in parens.

> from Sebastian Siewior, a kernel warning is
> generated as below. This warning is generated as the irq_enabled is not
> initialized for the primary interface and in probe it is initialized for
> the secondary interface. This patch moves irq_enabled initialization from
> second interface to primary interface.

    s/second/secondary/?

> [    3.049173] net eth0: phy found : id is : 0x4dd074
> [    3.054552] net eth0: phy found : id is : 0x4dd074
> [    3.070421] ------------[ cut here ]------------
> [    3.075308] WARNING: at kernel/irq/manage.c:437 enable_irq+0x3c/0x74()
> [    3.082173] Unbalanced enable for IRQ 56
> [    3.086299] Modules linked in:
> [    3.089557] [<c001abcc>] (unwind_backtrace+0x0/0xf0) from [<c004294c>] (warn_slowpath_common+0x4c/0x68)
> [    3.099450] [<c004294c>] (warn_slowpath_common+0x4c/0x68) from [<c00429fc>] (warn_slowpath_fmt+0x30/0x40)
> [    3.109521] [<c00429fc>] (warn_slowpath_fmt+0x30/0x40) from [<c00a29fc>] (enable_irq+0x3c/0x74)
> [    3.118681] [<c00a29fc>] (enable_irq+0x3c/0x74) from [<c03a7818>] (cpsw_ndo_open+0x61c/0x684)
> [    3.127669] [<c03a7818>] (cpsw_ndo_open+0x61c/0x684) from [<c0445c08>] (__dev_open+0x9c/0xf8)
> [    3.136646] [<c0445c08>] (__dev_open+0x9c/0xf8) from [<c0445e34>] (__dev_change_flags+0x78/0x13c)
> [    3.145988] [<c0445e34>] (__dev_change_flags+0x78/0x13c) from [<c0445f64>] (dev_change_flags+0x10/0x48)
> [    3.155884] [<c0445f64>] (dev_change_flags+0x10/0x48) from [<c0736d88>] (ip_auto_config+0x198/0x111c)
> [    3.165592] [<c0736d88>] (ip_auto_config+0x198/0x111c) from [<c00086a4>] (do_one_initcall+0x34/0x180)
> [    3.175309] [<c00086a4>] (do_one_initcall+0x34/0x180) from [<c07078f8>] (kernel_init_freeable+0xfc/0x1c8)
> [    3.185393] [<c07078f8>] (kernel_init_freeable+0xfc/0x1c8) from [<c04f36ec>] (kernel_init+0x8/0xe4)
> [    3.194929] [<c04f36ec>] (kernel_init+0x8/0xe4) from [<c00133d0>] (ret_from_fork+0x14/0x24)
> [    3.203712] ---[ end trace d6f979da080bc391 ]---

> Cc: Sebastian Siewior <bigeasy@linutronix.de>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

WBR, Sergei


