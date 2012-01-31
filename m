From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
Date: Mon, 30 Jan 2012 16:14:23 -0800
Message-ID: <878vkopw2o.fsf@ti.com>
References: <20120130093931.11027.31048.stgit@dusk>
	<20120130094312.11027.31050.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54994 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752903Ab2AaAO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 19:14:28 -0500
Received: by yhoo47 with SMTP id o47so2595460yho.24
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 16:14:26 -0800 (PST)
In-Reply-To: <20120130094312.11027.31050.stgit@dusk> (Paul Walmsley's message
	of "Mon, 30 Jan 2012 02:43:17 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
> pwrdm_pre_transition(), which appears a few lines after these calls,
> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
> need to do it twice.

It looks like these two for OMAP4 are surpurfluous since the immediately
follow a call to pwrdm_pre_transition() as well.

Santosh/Rajendra, please confirm/ack.

Kevin


diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 1d5d010..bbabe1d 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -263,12 +263,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	pwrdm_clear_all_prev_pwrst(mpuss_pd);
 	if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
 		(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
 		save_state = 2;
 
-	clear_cpu_prev_pwrst(cpu);
 	cpu_clear_prev_logic_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
