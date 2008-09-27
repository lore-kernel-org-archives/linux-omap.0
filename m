From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Sun, 28 Sep 2008 01:29:05 +0300
Message-ID: <20080927222900.GC8468@frodo>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809271441.41412.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43077 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbYI0W3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 18:29:17 -0400
Content-Disposition: inline
In-Reply-To: <200809271441.41412.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Sat, Sep 27, 2008 at 02:41:40PM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Move the twl4030 GPIO support from drivers/i2c/chips to drivers/gpio,
> which is a more appropriate home for this code.
> 
> The Kconfig symbol name is changed to match the GPIO_* convention for
> such symbols, so config files must change in the obvious ways (Kconfig
> will prompt you).  There's now some helptext.
> 
> It can now be compiled as a module, should anyone really want to
> do that; that'll be mostly useful for test builds.  Sanity check the
> IRQ range we're given.
> 
> Initialization order needed a bit of work too:  core add_children()
> called only after IRQs get set up, gpio uses subsys_initcall.  This
> depends on a patch making i2c driver model init use postcore_initcall.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> NOTE:  requires an I2C patch:
> 
>   http://marc.info/?l=i2c&m=122227316012577&w=2
> 
> I CC'd Jean since that doesn't seem to be in his queue yet, and
> that's pretty essential to moving such TWL stuff out of the
> i2c/chips directory into more appropriate locations.

This patch breaks hsmmc.c:
arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
/home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:51: undefined reference to `twl4030_get_gpio_datain'
arch/arm/mach-omap2/built-in.o: In function `hsmmc_cleanup':
/home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:93: undefined reference to `twl4030_free_gpio'
arch/arm/mach-omap2/built-in.o: In function `hsmmc_late_init':
/home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:64: undefined reference to `twl4030_request_gpio'
/home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:68: undefined reference to `twl4030_set_gpio_edge_ctrl'
/home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:78: undefined reference to `twl4030_set_gpio_debounce'

-- 
balbi
