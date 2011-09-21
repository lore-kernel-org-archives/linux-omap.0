From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Wed, 21 Sep 2011 06:51:27 -0700
Message-ID: <20110921135127.GN2937@atomide.com>
References: <20110917014623.GC2937@atomide.com>
 <201109202334.43213.arnd@arndb.de>
 <201109202346.11393.arnd@arndb.de>
 <2241590.uiCS2D9jjt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62793 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750783Ab1IUNvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 09:51:32 -0400
Content-Disposition: inline
In-Reply-To: <2241590.uiCS2D9jjt@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Kevin,

* Arnd Bergmann <arnd@arndb.de> [110921 01:55]:
> On Tuesday 20 September 2011 23:46:11 Arnd Bergmann wrote:
> 
> > It seems that you replace the #ifdef in the board-flash.c file
> > with a similar #ifdef in the header that replaces this with an
> > empty inline function when the object is not built.
> 
> Found another similar problem over night, presumably in the voltage series:
> 
> arch/arm/mach-omap2/built-in.o: In function `pwrdm_register_pwrdms':
> twl-common.c:(.text+0x5e20): undefined reference to `voltdm_lookup'
> twl-common.c:(.text+0x5e40): undefined reference to `voltdm_add_pwrdm'
> arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_infrastructure':
> twl-common.c:(.init.text+0x3a4): undefined reference to `omap2xxx_voltagedomains_init'
> twl-common.c:(.init.text+0x3c8): undefined reference to `omap3xxx_voltagedomains_init'
> arch/arm/mach-omap2/built-in.o: In function `omap2_set_init_voltage':
> twl-common.c:(.init.text+0x13c8): undefined reference to `voltdm_lookup'
> arch/arm/mach-omap2/built-in.o: In function `omap3_twl_init':
> twl-common.c:(.init.text+0x1f44): undefined reference to `voltdm_lookup'
> twl-common.c:(.init.text+0x1f4c): undefined reference to `voltdm_lookup'

Can you take a look at this one?

Tony
