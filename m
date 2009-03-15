From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ARM OMAP3: Initial support for Nokia RX-51
Date: Sun, 15 Mar 2009 15:47:41 +0000
Message-ID: <20090315154741.GC10541@n2100.arm.linux.org.uk>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224844.8810.17295.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36542 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbZCOPru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 11:47:50 -0400
Content-Disposition: inline
In-Reply-To: <20090313224844.8810.17295.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Lauri Leukkunen <lauri.leukkunen@nokia.com>

On Fri, Mar 13, 2009 at 03:48:44PM -0700, Tony Lindgren wrote:
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/mcspi.h>
> +#include <mach/gpio.h>

linux/gpio.h again?
