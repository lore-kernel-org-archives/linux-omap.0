From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Setting dss1_alwon_fck
Date: Mon, 20 Oct 2008 15:11:34 +0300
Message-ID: <1224504694.23383.11.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27183 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYJTMLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 08:11:40 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9KCB9o5022010
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 07:11:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Mans Rullgard has the patches mentioned below in his kernel tree at
http://git.mansr.com/?p=linux-omap;a=summary . I currently have those
patches and use the following sequence to set the dss1_alwon_fck clock:

/* get the rate of the parent of dpll4_m4_ck, which is dpll4_ck */
prate = clk_get_rate(clk_get_parent(dispc.dpll4_m4_ck));

/* calculate divisor so that wanted dss1_alwon_fck is prate / div * 2.
 * x2 because dss1_alwon_fck comes from dpll4_m4x2_ck */
div = ...;

/* set the rate */
clk_set_rate(dispc.dpll4_m4_ck, prate / div);

Is this the correct way to set dss1_alwon_fck? Are the patches below
needed, or can dss1_alwon_fck be set some other way?

 Tomi


commit e2de5e5578fbaa9b4b75074796da0608fc93e6ae
Author: Mans Rullgard <mans@mansr.com>
Date:   Tue Jul 22 01:58:18 2008 +0100

    ARM: OMAP: add clk_get_parent() for OMAP2/3
    
    Signed-off-by: Mans Rullgard <mans@mansr.com>

:100644 100644 577be44... 28aec36... M  arch/arm/mach-omap2/clock.c
:100644 100644 49245f7... 4aa69d5... M  arch/arm/mach-omap2/clock.h
:100644 100644 54cc6e1... ed7af21... M  arch/arm/mach-omap2/clock24xx.c
:100644 100644 04dedec... 08c8c46... M  arch/arm/mach-omap2/clock34xx.c

commit 2b7b958dc79e51127d7a4ecf88ce12dbc6c31426
Author: Mans Rullgard <mans@mansr.com>
Date:   Tue Jul 22 01:31:11 2008 +0100

    ARM: OMAP: make dpll4_m4_ck programmable with clk_set_rate()
    
    Filling the set_rate and round_rate fields of dpll4_m4_ck makes
    this clock programmable through clk_set_rate().  This is needed
    to give omapfb control over the dss1_alwon_fck rate.

:100644 100644 161da12... 876eb13... M  arch/arm/mach-omap2/clock34xx.h



