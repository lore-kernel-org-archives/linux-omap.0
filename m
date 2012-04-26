From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Thu, 26 Apr 2012 11:33:16 -0700
Message-ID: <87aa1ybaxf.fsf@ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
	<1335260749-25877-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:36695 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756893Ab2DZSdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 14:33:18 -0400
Received: by pbcwz17 with SMTP id wz17so31589pbc.27
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 11:33:17 -0700 (PDT)
In-Reply-To: <1335260749-25877-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Tue, 24 Apr 2012 15:15:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).

[...]

> +
> +	sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> +	if (!IS_ERR(sync32k_ick))
> +		clk_enable(sync32k_ick);
> +
> +	sync32k_cnt_reg = base + OMAP2_32KSYNCNT_CR_OFF;
> +
> +	/*
> +	 * 120000 rough estimate from the calculations in
> +	 * __clocksource_updatefreq_scale.
> +	 */
> +	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> +			32768, NSEC_PER_SEC, 120000);
> +
> +	ret = clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> +				clocksource_mmio_readl_up);

After discussing this a bit with Vaibhav offline, we found that 'base'
here should be sync32k_cnt_reg.

Can you guys that were seeing the hang confirm that that fixes the
issue?

If so, please reply with your Tested-by.  

Thanks,

Kevin
