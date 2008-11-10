From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/08] OMAP3 SRF: OPP and Frequency resources
Date: Mon, 10 Nov 2008 16:57:48 +0530
Message-ID: <00be01c94327$5d4e2e00$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40066 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbYKJL17 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:27:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Hi,

I am posting the patch-set which implement the OPP and Frequency resources in Shared Resource F/w.
And also implement's the following APIs in OMAP-PM layer using SRF
1) void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
2) void omap_pm_dsp_set_min_opp(u8 opp_id)
3) u8 omap_pm_dsp_get_opp(void)
4) void omap_pm_cpu_set_freq(unsigned long f)
 
These are validated on the 3430SDP (with omap_3430sdp_min_defconfig) and apply on the latest 
pm branch (pm-20081106, commit 0994b2df775ac04806ed).
Note that I had to disable pmidle to validate these patches as idle/suspend seems to be broken
on pm-20081106 on the SDP.

Make sure you have this selected if you plan to use these patches.
System Type-> TI OMAP Implementations->OMAP PM layer selection (PM layer implemented using SRF)

There are additional sysfs hooks provided to manually switch OPP's on vdd1 as well as vdd2 in the absense 
of a CPUFreq driver/governor.

Use /sys/power/vdd1_opp to switch VDD1 OPP's
Use /sys/power/vdd2_opp to switch VDD2 OPP's

Paul,
I am still having issues with low level clock f/w calls to switch CORE DPLL rate. 
Would you be able to have a look at these? See the crash log below.

regards,
Rajendra


Crash trying to switch to 83Mhz on 3430SDP
-----------------------------------
# echo -n 2 > /sys/power/vdd2_opp
<4>SR2: VDD autocomp is not active
SR2: VDD autocomp is not active
<6>clock: clksel_round_rate_div: dpll3_m2_ck target_rate 83000000
clock: clksel_round_rate_div: dpll3_m2_ck target_rate 83000000
<6>clock: new_div = 4, new_rate = 83000000
clock: new_div = 4, new_rate = 83000000
<1>Unable to handle kernel paging request at virtual address c8000008
Unable to handle kernel paging request at virtual address c8000008
<1>pgd = c785c000
pgd = c785c000
<1>[c8000008] *pgd=00000000[c8000008] *pgd=00000000

Internal error: Oops: 5 [#1]
Internal error: Oops: 5 [#1]
Modules linked in:Modules linked in:

CPU: 0    Not tainted  (2.6.27-omap1-00073-g0994b2d-dirty #30)
CPU: 0    Not tainted  (2.6.27-omap1-00073-g0994b2d-dirty #30)
PC is at omap2_sdrc_get_params+0x1c/0x3c
PC is at omap2_sdrc_get_params+0x1c/0x3c
LR is at omap3_core_dpll_m2_set_rate+0x98/0x12c
LR is at omap3_core_dpll_m2_set_rate+0x98/0x12c
pc : [<c002ca8c>]    lr : [<c003347c>]    psr: 80000093
sp : c796fdc0  ip : c796fdd0  fp : c796fdcc
pc : [<c002ca8c>]    lr : [<c003347c>]    psr: 80000093
sp : c796fdc0  ip : c796fdd0  fp : c796fdcc
r10: 00000002  r9 : c7914b78  r8 : c02d2a08
r10: 00000002  r9 : c7914b78  r8 : c02d2a08
r7 : c02dd964  r6 : 04f27ac0  r5 : 04f27ac0  r4 : 09e4f580
r7 : c02dd964  r6 : 04f27ac0  r5 : 04f27ac0  r4 : 09e4f580
r3 : 00000000  r2 : c8000008  r1 : 13c9eb00  r0 : 013c9eb0
r3 : 00000000  r2 : c8000008  r1 : 13c9eb00  r0 : 013c9eb0


