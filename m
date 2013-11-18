From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq
Date: Mon, 18 Nov 2013 13:58:55 -0800
Message-ID: <20131118215855.GW10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56219 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424Ab3KRV66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 16:58:58 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
or dra7xx, we can get the following error:

arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
:(.text+0x7ab0): undefined reference to `set_cntfreq'

Fix the issue by not trying to initalize the realtime counter
unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -65,12 +65,14 @@ static void omap4_secondary_init(unsigned int cpu)
 		omap_secure_dispatcher(OMAP4_PPA_CPU_ACTRL_SMP_INDEX,
 							4, 0, 0, 0, 0, 0);
 
+#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 	/*
 	 * Configure the CNTFRQ register for the secondary cpu's which
 	 * indicates the frequency of the cpu local timers.
 	 */
 	if (soc_is_omap54xx() || soc_is_dra7xx())
 		set_cntfreq();
+#endif
 
 	/*
 	 * Synchronise with the boot thread.
