From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/10] OMAP3: Zoom2: Add TWL4030 support
Date: Thu, 13 Aug 2009 10:27:55 +0100
Message-ID: <20090813092755.GW6132@n2100.arm.linux.org.uk>
References: <20090812120926.17601.85860.stgit@localhost> <20090812122007.17601.25934.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39972 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbZHMJ2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:28:07 -0400
Content-Disposition: inline
In-Reply-To: <20090812122007.17601.25934.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

On Wed, Aug 12, 2009 at 03:20:07PM +0300, Tony Lindgren wrote:
> +static struct twl4030_keypad_data zoom2_kp_twl4030_data = {
> +	.rows		= 8,
> +	.cols		= 8,
> +	.keymap		= zoom2_twl4030_keymap,
> +	.keymapsize	= ARRAY_SIZE(zoom2_twl4030_keymap),
> +	.rep		= 1,
> +};

Normally have a blank line here.

>  static void __init omap_zoom2_init_irq(void)
>  {
>  	omap2_init_common_hw(NULL);

Otherwise ok.
