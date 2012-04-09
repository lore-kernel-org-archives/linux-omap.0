From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: sram: fix BUG in dpll code for !PM case
Date: Mon, 9 Apr 2012 15:49:47 -0700
Message-ID: <20120409224946.GC6487@atomide.com>
References: <1333749201-23255-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34473 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab2DIWtt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 18:49:49 -0400
Content-Disposition: inline
In-Reply-To: <1333749201-23255-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [120406 14:56]:
> _omap3_sram_configure_core_dpll is called when SDRC is reprogrammed,
> which is done regardless of CONFIG_PM setting, so we always need it's
> setup code too. Without this, we hit a BUG() on OMAP3 when kernel is
> built without CONFIG_PM:
> 
> Reprogramming SDRC clock to 332000000 Hz
> ------------[ cut here ]------------
> kernel BUG at arch/arm/plat-omap/sram.c:342!
> Internal error: Oops - BUG: 0 [#1] ARM
> ...
> [<c001c694>] (omap3_configure_core_dpll+0x68/0x6c) from [<c001b2dc>] (omap3_core_dpll_m2_set_rate+0x1)
> [<c001b2dc>] (omap3_core_dpll_m2_set_rate+0x138/0x1b0) from [<c001a478>] (omap2_clk_set_rate+0x14/0x2)
> [<c001a478>] (omap2_clk_set_rate+0x14/0x20) from [<c001c9dc>] (clk_set_rate+0x54/0x74)
> [<c001c9dc>] (clk_set_rate+0x54/0x74) from [<c022b9c8>] (omap_sdrc_init+0x70/0x90)
> [<c022b9c8>] (omap_sdrc_init+0x70/0x90) from [<c022f178>] (omap3pandora_init+0x11c/0x164)
> [<c022f178>] (omap3pandora_init+0x11c/0x164) from [<c022849c>] (customize_machine+0x20/0x28)
> [<c022849c>] (customize_machine+0x20/0x28) from [<c0225810>] (do_one_initcall+0xa0/0x16c)
> [<c0225810>] (do_one_initcall+0xa0/0x16c) from [<c02259e0>] (kernel_init+0x104/0x1ac)
> [<c02259e0>] (kernel_init+0x104/0x1ac) from [<c0009cec>] (kernel_thread_exit+0x0/0x8)

Looks like this was caused by the added ifdef CONFIG_PM from
commit 3231fc88 (OMAP3: PM: restore SRAM functions after off-mode).

Tony
