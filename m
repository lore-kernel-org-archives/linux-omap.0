From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] cbus-retu: Add locking around register access in irq
 handler
Date: Tue, 1 Mar 2011 15:11:49 -0800
Message-ID: <20110301231149.GR20560@atomide.com>
References: <1298909168.16391.6.camel@marge>
 <20110228190931.GS2459@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:44551 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749Ab1CAXL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 18:11:57 -0500
Content-Disposition: inline
In-Reply-To: <20110228190931.GS2459@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Michael Buesch <mb@bu3sch.de>, linux-omap <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110228 11:07]:
> On Mon, Feb 28, 2011 at 05:06:08PM +0100, Michael Buesch wrote:
> > This adds locking around the register access in the
> > interrupt service routine.
> > 
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> > Reported-by: Felipe Balbi <balbi@ti.com>
> 
> Fine by me. Tony, you can apply.

Only applied the first two to add the register defines because of:

BUG: sleeping function called from invalid context at kernel/mutex.c:278
in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper
INFO: lockdep is turned off.
[<c0063c24>] (unwind_backtrace+0x0/0xec) from [<c0402f98>] (mutex_lock_nested+0x24/0x340)
[<c0402f98>] (mutex_lock_nested+0x24/0x340) from [<c032b4e4>] (retu_write_reg+0x20/0x3c)
[<c032b4e4>] (retu_write_reg+0x20/0x3c) from [<c032bc4c>] (_retu_modify_counter+0x28/0x34)
[<c032bc4c>] (_retu_modify_counter+0x28/0x34) from [<c032be48>] (retu_wdt_set_ping_timer+0x10/0x50)
[<c032be48>] (retu_wdt_set_ping_timer+0x10/0x50) from [<c00a2000>] (run_timer_softirq+0x260/0x368)
[<c00a2000>] (run_timer_softirq+0x260/0x368) from [<c009bdb8>] (__do_softirq+0xe8/0x1e0)
[<c009bdb8>] (__do_softirq+0xe8/0x1e0) from [<c009bf04>] (irq_exit+0x54/0xa0)
[<c009bf04>] (irq_exit+0x54/0xa0) from [<c0052090>] (asm_do_IRQ+0x90/0xcc)
[<c0052090>] (asm_do_IRQ+0x90/0xcc) from [<c0404adc>] (__irq_svc+0x3c/0x100)

Tony
