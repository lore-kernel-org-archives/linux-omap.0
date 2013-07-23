From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Tue, 23 Jul 2013 14:35:17 +0530
Message-ID: <51EE474D.5070804@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53258 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3GWJFw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 05:05:52 -0400
In-Reply-To: <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 23 July 2013 12:37 PM, Paul Walmsley wrote:
> Hi Rajendra,
> 
> On Tue, 23 Jul 2013, Rajendra Nayak wrote:
> 
>> On Tuesday 23 July 2013 01:37 AM, Paul Walmsley wrote:
>>> On Mon, 22 Jul 2013, Russell King - ARM Linux wrote:
>>>
>>>> Bear in mind that I'm almost at the point of not boot-testing anything
>>>> I sent to Linus because of the uselessness of the SDP4430 board now
>>>> that it's DT only - the only platform which boot-tests anything I send
>>>> is the 3430LDP board now.  If people care about that, maybe they can
>>>> assist with sorting out the issues I've raised on these lists about
>>>> the SDP4430 - and why the SDP4430 build remains disabled in my build
>>>> and boot system.
>>>
>>> I understand completely...
>>>
>>>> Looking at the boot log, it just stops after uboot hands over control.
>>>> With the lack of output from the decompressor, it's not possible to
>>>> tell whether it's a decompressor problem or a kernel problem.
>>>>
>>>> I think you need to turn on the LL_DEBUG option, select the appropriate
>>>> output option, and also get the decompressor to use the kernel's debug
>>>> io functions to output it's stuff (I think the option is DEBUG_UNCOMPRESS).
>>>
>>> OK, will dig deeper here at the next opportunity.
>>
>> Paul, I can take a look at the 4430sdp issue. Are you also seeing this also on
>> 2430sdp as the subject says, or was that a typo?
> 
> Thanks for the offer.  The issue that I'm seeing is on the 2430SDP in my 
> testbed.
> 
> I don't have a 4430SDP, so you might consider touching base with rmk for 
> that one.

So I tried commit 'fb2af00' on the 4430SDP and it did boot fine, though I see
the below errors. (I am using the mainline bootloaders which do not lock any
additional DPLLs like USB)

[    0.000000] clock: dpll_usb_ck failed transition to 'locked'
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] clock: trace_clk_div_ck: could not find divisor for target rate 0 for parent pmd_trace_clk_mux_ck
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-03445-gfb2af00-dirty #7
[    0.000000] [<c001bfe8>] (unwind_backtrace+0x0/0xf4) from [<c001868c>] (show_stack+0x10/0x14)
[    0.000000] [<c001868c>] (show_stack+0x10/0x14) from [<c02deb28>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02deb28>] (Ldiv0+0x8/0x10) from [<c0477030>] (clk_divider_set_rate+0x10/0x114)
[    0.000000] [<c0477030>] (clk_divider_set_rate+0x10/0x114) from [<c0476ef4>] (clk_change_rate+0x38/0xb8)
[    0.000000] [<c0476ef4>] (clk_change_rate+0x38/0xb8) from [<c0476f5c>] (clk_change_rate+0xa0/0xb8)
[    0.000000] clock: dpll_per_m7x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck
[    0.000000] clock: dpll_per_m6x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck
[    0.000000] clock: dpll_per_m5x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck
[    0.000000] clock: dpll_per_m4x2_ck: could not find divisor for target rate 0 for parent dpll_per_x2_ck

> 
> 
> - Paul
> 

