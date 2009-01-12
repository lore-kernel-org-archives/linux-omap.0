From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix gpio by switching to generic gpio
	calls
Date: Mon, 12 Jan 2009 15:14:32 +0200
Message-ID: <20090112131430.GI9373@atomide.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com> <20090110110224.GB28945@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58348 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZALNOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 08:14:39 -0500
Content-Disposition: inline
In-Reply-To: <20090110110224.GB28945@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090110 13:02]:
> On Wed, Jan 07, 2009 at 01:17:45PM +0200, Tony Lindgren wrote:
> > From: Jarkko Nikula <jarkko.nikula@nokia.com>
> > Date: Wed, 7 Jan 2009 12:54:34 +0200
> > Subject: [PATCH] ARM: OMAP: Fix gpio by switching to generic gpio calls
> > 
> > Fix compile by removing remaining omap specific gpio
> > calls. Based on earlier patches by Jarkko Nikula.
> 
> This isn't the whole story... There's another build error related to
> the OMAP GPIO changes which remain unaddressed:
> 
> arch/arm/plat-omap/gpio.c:1792: error: 'struct gpio_bank' has no member named 'suspend_wakeup'

Looks like this happens with CONFIG_DEBUG_FS, will fix.

> and there's also the unrelated:
> 
> arch/arm/mach-omap1/board-palmte.c:198: error: variable 'palmte_mmc_config' has initializer but incomplete type

Thanks, looks like I somehow missed removing the old style MMC init
for palmte.

Will post a series of omap-fixes soonish.

Tony
