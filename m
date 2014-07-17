From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH CFT] arm: omap1: Migrate debug_ll macros to use 8250.S
Date: Thu, 17 Jul 2014 20:12:50 +0300
Message-ID: <20140717171250.GC16324@ambient.musicnaut.iki.fi>
References: <1405594444-27633-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:42923 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaGQRUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 13:20:04 -0400
Content-Disposition: inline
In-Reply-To: <1405594444-27633-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

Hi,

On Thu, Jul 17, 2014 at 11:54:04AM +0100, Daniel Thompson wrote:
> The omap1's debug-macro.S is similar to the generic 8250 code. Compared to
> the 8520 code the omap1 macro automatically determines what UART to use
> based on breadcrumbs left by the bootloader and automatically copes with
> the eccentric register layout on OMAP7XX.

[...]

> +	config DEBUG_OMAP1UART1
> +		bool "Kernel low-level debugging via OMAP1 UART1"
> +		depends on ARCH_OMAP1 && !ARCH_OMAP730

Did you try this with omap1_defconfig and then running menuconfig to see
how it looks like? The patch allows to select only OMAP730 ports,
but the kernel should be bootable on all core types...

A.
