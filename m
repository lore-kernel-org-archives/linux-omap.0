From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Add basic support for Pandora handheld console
Date: Sat, 18 Oct 2008 08:29:14 -0700
Message-ID: <20081018152914.GR18573@atomide.com>
References: <1224341130-2666-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63815 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbYJRP3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 11:29:16 -0400
Content-Disposition: inline
In-Reply-To: <1224341130-2666-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [081018 07:45]:
> This patch adds support for for basic features: nand, uarts, i2c,
> mmc, rtc, and usb. Also includes defconfig.

Cool, one question below.

> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c

<snip>

> +static struct omap_uart_config omap3pandora_uart_config __initdata = {
> +	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> +};

Are all the uarts really in use?

Does pandora have a real serial port for debugging?

Not that it matters at this point, but you'll want to have only
the serial ports that you really need enabled, as their clocks block
deeper sleep states.

In general, the short term plan is to change the serial port clocks
only to be enabled during start up if console=ttyS is specified on cmdline.

Regards,

Tony
