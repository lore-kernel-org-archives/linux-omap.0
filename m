From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Thu, 9 Jan 2014 15:22:03 -0600
Message-ID: <52CF12FB.6000602@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37367 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756089AbaAIVWb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 16:22:31 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 01/09/2014 08:00 AM, Tero Kristo wrote:
> Hi,
> 
> So, bad luck number release for this, as v12 wasn't sufficient still.
> 
> Changes compared to previous version:
> - Dropped any changes to generic clock drivers, as it seems impossible
>   to agree anything in short term, this means the patch set shrank in
>   size from 49 patches to 40 (first 9 patches were dropped).
> - Copy pasted implementation for clk-divider and clk-mux from drivers/clk
>   to drivers/clk/ti, and made the modifications needed to the TI version
>   of the clock drivers only (based on discussions with Mike, this is fine)
> - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
>   with any generic implementation we might have at some point, migrating
>   this to the generic version should be easy enough also.
> - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
>   versions and resulted into an orphan clock node
> - Fixed compile problem for omap5 only build reported by Felipe
> - Fixed a couple of sparse warnings
> - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
>   instead of __raw_readl / __raw_writel
> 
> Testing done:
> - omap3-beagle: boot / suspend-resume (RET) / suspend-resume (OFF)
> - omap4-panda-es: boot / suspend-resume (RET)
> - omap5-uevm: boot
> - am335x-bone: boot
> - dra7-evm: boot
> 
> Maintainer friendly branches also available:
> 
> tree: https://github.com/t-kristo/linux-pm.git
> 
> clk driver only (Mike): clk-next-dt-clks-v13
> DTS data only (Benoit): dts_for_3.14-dt-clks-v13
> full-branch (Tony/Paul): 3.13-rc7-dt-clks-v13
> 
> -Tero
> 

Maintainer branches conflicts (using 3.13-rc7-dt-clks-v13):
=============================
Conflict resolution during rebase to maintainer's -14 branches:

1. (trivial) Against mike's clk-next dbdf6ff Merge branch
'clk-next-unregister' into clk-next

Could not apply 2edf7ad... CLK: TI: add DT alias clock registration
mechanism
conflict drivers/clk/Makefile (trivial fix)

2. (manual, but changes are easy) Against Tony's omap-for-v3.14/be
fc6ca98 ARM: OMAP: debug-leds: raw read and write endian fix

ARM: OMAP2+: clock: use driver API instead of direct memory read/write

conflicts with be changes on Tony's be branch.
commit 80f304dd2360cf5d50953c4eb4e902536f6a1263
    ARM: OMAP2+: raw read and write endian fix

Conflict:
arch/arm/mach-omap2/clkt_clksel.c
arch/arm/mach-omap2/clkt_dpll.c
arch/arm/mach-omap2/clkt_iclk.c
arch/arm/mach-omap2/clock.c
arch/arm/mach-omap2/clock36xx.c
arch/arm/mach-omap2/dpll3xxx.c
arch/arm/mach-omap2/dpll44xx.c

Both change raw_readls -> should now be just clk api instead which
already does readl_relaxed etc.. If Tony feels like, then we should
probably post a branch based on 'be' branch for easy merge.

3. I could not detect any merge conflict against Benoit's queued up
series (but maybe he has'nt pushed everything to remote tree)..


Patch verification report:
==========================
Report: http://pastebin.mozilla.org/3976492


* sparse warning added in [PATCH 06/40] CLK: ti: add support for ti
divider-clock, [PATCH 10/40] clk: ti: add support for basic mux clock
+drivers/clk/ti/divider.c: warning: context imbalance in
'ti_clk_divider_set_rate' - different lock contexts for basic block
+drivers/clk/ti/mux.c: warning: context imbalance in
'ti_clk_mux_set_parent' - different lock contexts for basic block

* checkpatch warning [PATCH 16/40] CLK: TI: add am33xx clock init
file, [PATCH 18/40] CLK: TI: add omap3 clock init file
WARNING: static const char * array should probably be static const
char * const


Boot reports:
=============
- previous orphan clocks seem solved.
- All available platforms seem to boot fine and no regression could be
seen on initial view

OMAP2430:
  1. SDP2430
    before: http://pastebin.mozilla.org/3976359
    after: http://pastebin.mozilla.org/3976467

AM335x:
  2. am335x-evm
    before: http://pastebin.mozilla.org/3976284
    after: http://pastebin.mozilla.org/3976374
  3. am335x-sk
    before: http://pastebin.mozilla.org/3976295
    after: http://pastebin.mozilla.org/3976375
  4. BeagleBone Black:
    before: http://pastebin.mozilla.org/3976321
    after: http://pastebin.mozilla.org/3976441

AM3517:
  5. am3517-evm
    before: http://pastebin.mozilla.org/3976297
    after: http://pastebin.mozilla.org/3976397
  6. craneboard
    before: http://pastebin.mozilla.org/3976322
    after: http://pastebin.mozilla.org/3976452

OMAP3430:
  7. ldp
    before: http://pastebin.mozilla.org/3976356
    after: http://pastebin.mozilla.org/3976455
  8. sdp3430
    before: http://pastebin.mozilla.org/3976360
    after: http://pastebin.mozilla.org/3976468

OMAP3630/DM3730:
  9. am37x-evm
    before: http://pastebin.mozilla.org/3976300
    after: http://pastebin.mozilla.org/3976398
  10. beagle-XM
    before: http://pastebin.mozilla.org/3976319
    after: http://pastebin.mozilla.org/3976440

OMAP4430:
  11. SDP4430
    before: http://pastebin.mozilla.org/3976361
    after: http://pastebin.mozilla.org/3976470

OMAP4460:
  12. PandaBoard-ES
    before: http://pastebin.mozilla.org/3976358
    after: http://pastebin.mozilla.org/3976456

OMAP5432:
  13. OMAP5uEVM
    before: http://pastebin.mozilla.org/3976362 (no boot)
    after: http://pastebin.mozilla.org/3976471 (boot)

DRA7:
  14. dra7evm
    before: http://pastebin.mozilla.org/3976354 (no boot)
    after: http://pastebin.mozilla.org/3976453 (boot)

AM437x:
  15. am43xx-epos + out-of-tree patches for engineering samples
    before: http://pastebin.mozilla.org/3976306 (no boot)
    after: http://pastebin.mozilla.org/3976399 (boot)

-- 
Regards,
Nishanth Menon
