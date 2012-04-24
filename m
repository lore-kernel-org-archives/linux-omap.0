From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/19] ARM: OMAP4: PM: update ROM return address for
 OSWR and OFF
Date: Tue, 24 Apr 2012 09:39:16 -0700
Message-ID: <20120424163916.GN3739@atomide.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-13-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48910 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab2DXQjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 12:39:18 -0400
Content-Disposition: inline
In-Reply-To: <1334914432-26456-13-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Carlos Leija <cileija@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Bryan Buckley <bryan.buckley@ti.com>

* Tero Kristo <t-kristo@ti.com> [120420 02:39]:
> @@ -384,6 +386,17 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>  	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
>  
>  	if (omap4_mpuss_read_prev_context_state()) {
> +		/*
> +		 * Dummy dispatcher call after OSWR and OFF
> +		 * Restore the right return Kernel address (with MMU on) for
> +		 * subsequent calls to secure ROM. Otherwise the return address
> +		 * will be to a PA return address and the system will hang.
> +		 */
> +		if (omap_type() != OMAP2_DEVICE_TYPE_GP)
> +			omap_secure_dispatcher(OMAP4_PPA_SERVICE_0,
> +					       FLAG_START_CRITICAL,
> +					       0, 0, 0, 0, 0);
> +
>  		restore_ivahd_tesla_regs();
>  		restore_l3instr_regs();

This SoC test here too should be only done once during init.

Tony
