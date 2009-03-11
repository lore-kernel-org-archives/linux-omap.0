From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
Date: Wed, 11 Mar 2009 10:27:32 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037B763A5A@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF48FEA4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38156 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbZCKP1m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:27:42 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF48FEA4@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: ext Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Wednesday, March 11, 2009 9:51 AM

> With the latest linux-omap pm + gitorious bridge changes on SDP3430, enabling
> BRIDGE_DVFS and SRF seems to cause an issue with clock notifier.. I am not
> entirely of the cause of the issue(don't have a debugger handy at the
> moment :( ): The condition is reproducible on exactly the third insmod of the
> driver as explained below. Looking for any advice to fix this issue :(

Does it need DVFS enabled to fail? Is voltage high enough (to current DM)? There were some issues there.

Regards,
Richard W.

A side and possibly related note is the below 0x800 is way too high and will likely result in screen or other fifo related effects. The delay target should be around 5uS (for 26Mhz sysclk) and half of that for 13MHz sysclk.

Given a value of 0xC8 with ARM at 125MHz, a vdd2-opp2 -> vdd2-opp3 takes 105uS using current code.  This it self is too high for some display fifos.  0x800 is out of the park high.

End note is needs tuning for DVFS.

configure_core_dpll:
        ldr     r4, omap3_cm_clksel1_pll
        ldr     r5, [r4]
        ldr     r6, core_m2_mask_val    @ modify m2 for core dpll
        and     r5, r5, r6
        orr     r5, r5, r3, lsl #0x1B   @ r3 contains the M2 val
        str     r5, [r4]
        mov     r5, #0x800              @ wait for the clock to stabilise
        cmp     r3, #2
        bne     wait_clk_stable
        bx      lr

