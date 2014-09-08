From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: omap: fix Kconfig warning
Date: Mon, 08 Sep 2014 20:16:42 +0200
Message-ID: <2797284.2mFcuQ0Ias@wuerfel>
References: <3763111.OttSKCMuxb@wuerfel> <20140908153400.GC3238@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50784 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaIHSRT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 14:17:19 -0400
In-Reply-To: <20140908153400.GC3238@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 08 September 2014 08:34:00 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [140908 08:01]:
> > A small mistake during the recent Kconfig cleanup has led
> > to a harmless warning for OMAP1:
> > 
> > warning: (ARCH_OMAP1) selects ARCH_OMAP which has unmet direct dependencies (ARCH_MULTI_V6 || ARCH_MULTI_V7)
> > 
> > We can easily avoid that by moving the ARCH_OMAP symbol outside of the
> > OMAP2 submenu.
> 
> OK I made a similar patch, but I moved it into plat-omap/Kconfig
> as it's also used by omap1. The regression was probably caused by
> commit 21278aeafbfa (ARM: use menuconfig for sub-arch menus).
> 
> If that works for you, I'll verify the regression causing commit
> and post it with a description.

Yes, sounds good. Your version is better than mind.

	Arnd

> 
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -1,9 +1,6 @@
>  menu "TI OMAP/AM/DM/DRA Family"
>  	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
>  
> -config ARCH_OMAP
> -	bool
> -
>  config ARCH_OMAP2
>  	bool "TI OMAP2"
>  	depends on ARCH_MULTI_V6
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -1,3 +1,6 @@
> +config ARCH_OMAP
> +	bool
> +
>  if ARCH_OMAP
>  
>  menu "TI OMAP Common Features"

