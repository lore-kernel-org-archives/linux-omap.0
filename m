From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Wed, 7 Aug 2013 18:09:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308071807240.28993@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41773 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932943Ab3HGSJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 14:09:02 -0400
In-Reply-To: <51EE474D.5070804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On Tue, 23 Jul 2013, Rajendra Nayak wrote:

> So I tried commit 'fb2af00' on the 4430SDP and it did boot fine, though I see
> the below errors. (I am using the mainline bootloaders which do not lock any
> additional DPLLs like USB)

Could you please send patches to fix these problems, or ensure that 
someone else from TI fixes them?  Let's see if we can deal with the 
remaining bootloader dependencies here.

thanks


- Paul

> 
> [    0.000000] clock: dpll_usb_ck failed transition to 'locked'
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] clock: trace_clk_div_ck: could not find divisor for target rate 0 for parent pmd_trace_clk_mux_ck
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
> [    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
> [    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
> [    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
> [    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
> [    0.000000] clock: dpll_per_m7x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck
> [    0.000000] clock: dpll_per_m6x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck
> [    0.000000] clock: dpll_per_m5x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck
> [    0.000000] clock: dpll_per_m4x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck
> 
> > 
> > 
> > - Paul
> > 
> 


- Paul
