From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] TI814X: Create board support and enable build for
 TI8148 EVM
Date: Mon, 15 Aug 2011 18:15:12 +0300
Message-ID: <20110815151509.GT12348@atomide.com>
References: <1312479903-22909-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51815 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754427Ab1HOPPU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Aug 2011 11:15:20 -0400
Content-Disposition: inline
In-Reply-To: <1312479903-22909-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Hemant Pedanekar <hemantp@ti.com> [110804 20:39]:
> This patch adds minimal support and build configuration for TI8148 EVM. Also
> adds support for low level debugging on UART1 console on the EVM.
...


> +MACHINE_START(TI8148EVM, "ti8148evm")
> +	/* Maintainer: Texas Instruments */
> +	.boot_params	= 0x80000100,
> +	.map_io		= ti8148_evm_map_io,
> +	.init_early	= ti8148_init_early,
> +	.init_irq	= ti81xx_init_irq,
> +	.timer		= &omap3_timer,
> +	.init_machine	= ti8148_evm_init,
> +MACHINE_END

Please just combine this with board-ti8168evm.c by adding the MACHINE_START
there. It seems the files are identical otherwise?

Regards,

Tony
