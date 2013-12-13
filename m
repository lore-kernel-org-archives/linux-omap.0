From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3: Pinmux: DT: missing irq domain
Date: Fri, 13 Dec 2013 14:45:57 -0800
Message-ID: <20131213224557.GJ28184@atomide.com>
References: <20131213212843.GA25312@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55633 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754099Ab3LMWp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 17:45:59 -0500
Received: from [64.17.244.34] (helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)
	(envelope-from <tony@atomide.com>)
	id 1VrbUc-000AnN-NB
	for linux-omap@vger.kernel.org; Fri, 13 Dec 2013 22:45:58 +0000
Content-Disposition: inline
In-Reply-To: <20131213212843.GA25312@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>

* Sebastian Reichel <sre@ring0.de> [131213 13:30]:
> Hi,
> 
> I get the stacktrace from below two times during booting my Nokia N900 via DT.
> Everything seems to work, but its annoying.
> 
> [    0.279571] irq: no irq domain found for /ocp/pinmux@48002030 !
> [    0.285827] ------------[ cut here ]------------
> [    0.290710] WARNING: CPU: 0 PID: 1 at drivers/of/platform.c:171 of_device_alloc+0x114/0x158()
> [    0.299621] Modules linked in:
> [    0.302856] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc2+ #477
> [    0.309753] [<c00158b4>] (unwind_backtrace+0x0/0xe0) from [<c0011b24>] (show_stack+0x10/0x14)
> [    0.318695] [<c0011b24>] (show_stack+0x10/0x14) from [<c051e9f8>] (dump_stack+0x68/0x84)
> [    0.327178] [<c051e9f8>] (dump_stack+0x68/0x84) from [<c003db64>] (warn_slowpath_common+0x64/0x88)
> [    0.336547] [<c003db64>] (warn_slowpath_common+0x64/0x88) from [<c003dba0>] (warn_slowpath_null+0x18/0x1c)
> [    0.346618] [<c003dba0>] (warn_slowpath_null+0x18/0x1c) from [<c03b4254>] (of_device_alloc+0x114/0x158)
> [    0.356445] [<c03b4254>] (of_device_alloc+0x114/0x158) from [<c03b42c8>] (of_platform_device_create_pdata+0x30/0x8c)
> [    0.367401] [<c03b42c8>] (of_platform_device_create_pdata+0x30/0x8c) from [<c03b440c>] (of_platform_bus_create+0xe8/0x168)
> [    0.378936] [<c03b440c>] (of_platform_bus_create+0xe8/0x168) from [<c03b4458>] (of_platform_bus_create+0x134/0x168)
> [    0.389801] [<c03b4458>] (of_platform_bus_create+0x134/0x168) from [<c03b44e8>] (of_platform_populate+0x5c/0x8c)
> [    0.400451] [<c03b44e8>] (of_platform_populate+0x5c/0x8c) from [<c075b5c0>] (pdata_quirks_init+0x2c/0x70)
> [    0.410430] [<c075b5c0>] (pdata_quirks_init+0x2c/0x70) from [<c074e648>] (customize_machine+0x1c/0x40)
> [    0.420166] [<c074e648>] (customize_machine+0x1c/0x40) from [<c0008920>] (do_one_initcall+0x98/0x140)
> [    0.429779] [<c0008920>] (do_one_initcall+0x98/0x140) from [<c074cc64>] (kernel_init_freeable+0x16c/0x23c)
> [    0.439880] [<c074cc64>] (kernel_init_freeable+0x16c/0x23c) from [<c051a520>] (kernel_init+0x8/0x100)
> [    0.449523] [<c051a520>] (kernel_init+0x8/0x100) from [<c000dfb8>] (ret_from_fork+0x14/0x3c)
> [    0.458374] ---[ end trace 9ca308e4d03a2990 ]---

Yeah.. Please see this thread on LAKML:

[PATCH] of/platform: Fix no irq domain found errors when populating interrupts
http://lkml.org/lkml/2013/11/22/520

Tony
