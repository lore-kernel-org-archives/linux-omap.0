From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
Date: Wed, 11 Mar 2009 11:32:43 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF490055@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF48FEA4@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162037B763A5A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39662 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbZCKQcx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 12:32:53 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037B763A5A@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: ext Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Richard,

> -----Original Message-----
> From: Woodruff, Richard
> Sent: Wednesday, March 11, 2009 5:28 PM
> To: Menon, Nishanth; linux-omap@vger.kernel.org
> Cc: ext Paul Walmsley; Nayak, Rajendra; Gupta, Ramesh
> Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
> 
> 
> > driver as explained below. Looking for any advice to fix this issue :(
> 
> Does it need DVFS enabled to fail? Is voltage high enough (to current DM)?
> There were some issues there.
Yes, Rajendra's VDD change is merged in [1] pm branch.
> 
> A side and possibly related note is the below 0x800 is way too high and
> will likely result in screen or other fifo related effects. The delay
> target should be around 5uS (for 26Mhz sysclk) and half of that for 13MHz
> sysclk.
> 
> Given a value of 0xC8 with ARM at 125MHz, a vdd2-opp2 -> vdd2-opp3 takes
> 105uS using current code.  This it self is too high for some display
> fifos.  0x800 is out of the park high.
> 
> End note is needs tuning for DVFS.
> 
> configure_core_dpll:
>         ldr     r4, omap3_cm_clksel1_pll
>         ldr     r5, [r4]
>         ldr     r6, core_m2_mask_val    @ modify m2 for core dpll
>         and     r5, r5, r6
>         orr     r5, r5, r3, lsl #0x1B   @ r3 contains the M2 val
>         str     r5, [r4]
>         mov     r5, #0x800              @ wait for the clock to stabilise
>         cmp     r3, #2
>         bne     wait_clk_stable
>         bx      lr
It does not make sense for clock notifier_registration to oops out.. it has'nt come out of init even..

This looks like list_del missing in clock_notifier unregistration function :(. I have a patch in place.. sending in a few mins
Regards,
Nishanth Menon
[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=pm
