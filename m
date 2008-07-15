From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean
 up SDRC
Date: Tue, 15 Jul 2008 01:58:44 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807150152020.467@utopia.booyaka.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain> <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com> <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162035BD67429@dlee02.ent.ti.com>
 <alpine.DEB.1.00.0807081730590.12684@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162035BD67456@dlee02.ent.ti.com> <alpine.DEB.1.00.0807081830010.12684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38370 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbYGOH6p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2008 03:58:45 -0400
In-Reply-To: <alpine.DEB.1.00.0807081830010.12684@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 'Igor Stoppa' <igor.stoppa@nokia.com>


Hello,

A quick update on the CORE DPLL M2 divider change patches; they seem to 
work okay on the BeagleBoard here.  (The rate tables need minor tweaks to 
match the Beagle DPLL clock rates set up by u-boot.)

Not sure what's going on with the 3430SDP.  I suspect there are some PRCM 
register contents that are not being properly reset during the FPGA-driven 
warm reboots used here.


- Paul


root@(none):~# mount -t debugfs none /mnt
root@(none):~# cd /mnt/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll3_ck/dpll3_m2_ck
root@(none):/mnt/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll3_ck/dpll3_m2_ck#
echo -n 166000000 > rate
clock: clksel_round_rate_div: dpll3_m2_ck target_rate 166000000
clock: new_div = 2, new_rate = 166000000
clock: changing CORE DPLL rate from 332000000 to 166000000
clock: current SDRC timing params: 0004dc01 aa9db4c6 00011517
clock: new SDRC timing params: 00025501 51512283 0001120c
clk: clk_set_rate(dpll3_m2_ck, 166000000) returns 0

root@(none):/mnt/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll3_ck/dpll3_m2_ck#
echo -n 332000000 > rate
clock: clksel_round_rate_div: dpll3_m2_ck target_rate 332000000
clock: new_div = 1, new_rate = 332000000
clock: changing CORE DPLL rate from 166000000 to 332000000
clock: current SDRC timing params: 00025501 51512283 0001120c
clock: new SDRC timing params: 0004dc01 9a9db4c6 00011217
clk: clk_set_rate(dpll3_m2_ck, 332000000) returns 0
root@(none):/mnt/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll3_ck/dpll3_m2_ck#
