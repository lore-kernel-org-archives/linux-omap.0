From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 8/9] OMAP2: add board file for Nokia N800 and N810
Date: Thu, 13 Aug 2009 10:15:10 +0100
Message-ID: <20090813091510.GK6132@n2100.arm.linux.org.uk>
References: <20090811094348.32577.81307.stgit@localhost> <20090811095558.32577.26177.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36759 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbZHMJPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:15:25 -0400
Content-Disposition: inline
In-Reply-To: <20090811095558.32577.26177.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Kalle Valo <kalle.valo@iki.fi>, linux-omap@vger.kernel.org

On Tue, Aug 11, 2009 at 12:55:58PM +0300, Tony Lindgren wrote:
> +#include <mach/gpio.h>

linux/gpio.h

> +#include <mach/io.h>

linux/io.h

> +static struct musb_hdrc_platform_data tusb_data = {
> +	.mode		= BOARD_MODE,
> +	.set_power	= tusb_set_power,
> +	.set_clock	= tusb_set_clock,
> +	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
> +	.power		= 100,	/* Max 100 mA VBUS for host mode */
> +	.clock		= "osc_ck",

Still passing clock names around?
