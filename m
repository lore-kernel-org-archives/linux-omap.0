From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 15/17] ARM: OMAP: Split plat/hardware.h, use local soc.h for omap2+
Date: Tue, 11 Sep 2012 12:48:38 +0200
Message-ID: <20120911104838.GE27604@spo001.leaseweb.com>
References: <20120911052934.29637.9190.stgit@muffinssi.local> <20120911053117.29637.2499.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:38244 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759140Ab2IKLbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 07:31:39 -0400
Content-Disposition: inline
In-Reply-To: <20120911053117.29637.2499.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi Tony,

> As the plat and mach includes need to disappear for single zImage work,
> we need to remove plat/hardware.h.
> 
> Do this by splitting plat/hardware.h into omap1 and omap2+ specific files.
> 
> The old plat/hardware.h already has omap1 only defines, so it gets moved
> to mach/hardware.h for omap1. For omap2+, we use the local soc.h
> that for now just includes the related SoC headers to keep this patch more
> readable.
> 
> Note that the local soc.h still includes plat/cpu.h that can be dealt
> with in later patches. Let's also include plat/serial.h from common.h for
> all the board-*.c files. This allows making the include files local later
> on without patching these files again.
> 
> Note that only minimal changes are done in this patch for the
> drivers/watchdog/omap_wdt.c driver to keep things compiling. Further
> patches are needed to eventually remove cpu_is_omap usage in the drivers.
> 
> Also only minimal changes are done to sound/soc/omap/* to remove the
> unneeded includes and to define OMAP44XX_MCPDM_L3_BASE locally so there's
> no need to include omap44xx.h.
> 
> While at it, also sort some of the includes in the standard way.
> 
> Cc: linux-watchdog@vger.kernel.org
> Cc: Wim Van Sebroeck <wim@iguana.be>

Acked-by for the watchdog part.

Kind regards,
Wim.

