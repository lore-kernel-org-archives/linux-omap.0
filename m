From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Wed, 29 Jun 2011 22:45:45 +0100
Message-ID: <20110629214545.GH23312@n2100.arm.linux.org.uk>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44055 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1F2VqB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 17:46:01 -0400
Content-Disposition: inline
In-Reply-To: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Wed, Jun 29, 2011 at 06:40:23PM +0200, jean.pihet@newoldbits.com wrote:
> @@ -309,7 +308,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  
>  static void omap34xx_do_sram_idle(unsigned long save_state)
>  {
> -	_omap_sram_idle(omap3_arm_context, save_state);
> +	omap34xx_cpu_suspend(omap3_arm_context, save_state);

Actually, this should be called omap34xx_soc_suspend() or
omap34xx_finish_suspend() - finish_suspend() reflects the naming
of other such functions elsewhere.
