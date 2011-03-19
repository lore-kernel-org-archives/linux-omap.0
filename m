From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP PM updates for 2.6.39
Date: Fri, 18 Mar 2011 17:34:11 -0700
Message-ID: <20110319003411.GG18583@atomide.com>
References: <87k4g6eakw.fsf@ti.com>
 <4D7E6DCF.1060703@openelec.tv>
 <20110314193848.GI7258@atomide.com>
 <4D7E71C0.4010808@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34590 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1CSAeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 20:34:17 -0400
Content-Disposition: inline
In-Reply-To: <4D7E71C0.4010808@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Stephan Raue <mailinglists@openelec.tv> [110314 12:49]:
> >
> >Tony
> patch attached.
> 
> i am using http://gitorious.org/linux-omap-dss2/linux with
> gcc-4.5.2, binutils-2.21

Still need a proper patch description and your Signed-off-by line :)

See Documentation/Submit* files in your kernel directory for
more info.

Tony

 
> diff -Naur linux-2.6.38-rc8/arch/arm/mach-omap2/Makefile linux-2.6.38-rc8.patch/arch/arm/mach-omap2/Makefile
> --- linux-2.6.38-rc8/arch/arm/mach-omap2/Makefile	2011-03-14 20:38:21.039926899 +0100
> +++ linux-2.6.38-rc8.patch/arch/arm/mach-omap2/Makefile	2011-03-14 20:39:01.679108209 +0100
> @@ -68,7 +68,7 @@
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
> -AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> +AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>  
>  ifeq ($(CONFIG_PM_VERBOSE),y)
>  CFLAGS_pm_bus.o				+= -DDEBUG

