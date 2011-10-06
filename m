From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3 3/4] arm:omap:am33xx: Create board support and
 enable build for AM335XEVM
Date: Thu, 6 Oct 2011 16:07:51 -0700
Message-ID: <20111006230751.GZ6324@atomide.com>
References: <hvaibhav@ti.com>
 <1316529142-27564-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46708 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759260Ab1JFXHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:07:54 -0400
Content-Disposition: inline
In-Reply-To: <1316529142-27564-4-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

* hvaibhav@ti.com <hvaibhav@ti.com> [110920 06:59]:
> From: Afzal Mohammed <afzal@ti.com>
> 
> This patch adds minimal support and build configuration for
> AM335X EVM.
...

> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-am335xevm.c
> +
> +MACHINE_START(AM335XEVM, "am335xevm")
> +	/* Maintainer: Texas Instruments */
> +	.boot_params	= 0x80000100,
> +	.map_io		= am335x_evm_map_io,
> +	.init_early	= am335x_init_early,
> +	.init_irq	= ti816x_init_irq,
> +	.timer		= &omap3_timer,
> +	.init_machine	= am335x_evm_init,
> +MACHINE_END

Please just add the support into board-am3517evm.c, the board-*.c
files will be going away with device tree.

Regards,

Tony
