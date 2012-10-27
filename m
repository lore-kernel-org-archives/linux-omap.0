From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap plat header removal for v3.8 merge window, part1
Date: Sat, 27 Oct 2012 08:09:01 +0000
Message-ID: <201210270809.02140.arnd@arndb.de>
References: <20121019023300.GN30550@atomide.com> <20121026175537.GL11908@atomide.com> <20121026223848.GY11908@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53411 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2J0IJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Oct 2012 04:09:15 -0400
In-Reply-To: <20121026223848.GY11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Friday 26 October 2012, Tony Lindgren wrote:
> Here's a patch for that. It's against what I have queued up in
> omap-for-v3.8/cleanup-headers. Does that look OK to you?

Hi Tony,

thanks for the quick follow-up. Using the absolute #include statements
again looks good, but now there is another problem:

> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index cd169c3..03b1e80 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -2,6 +2,8 @@
>  # Makefile for the linux kernel.
>  #
>  
> +ccflags-$(CONFIG_ARCH_OMAP) := -I$(srctree)/arch/arm
> +

This is not what I meant, I don't think we want to have the entire
arch/arm/ hierarchy visible in platform directories. Instead, I thought
we'd keep using the existing arch/arm/mach-$foo/include/mach directories
that are currently visible to all files and make them available only
to platforms that explicitly add -I$(srctree)/arch/arm/include/mach-$foo/include
to their local include path.

This of course requires moving all those headers back to where they just came
from.

	Arnd
