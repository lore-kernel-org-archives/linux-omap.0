From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/9] ARM: OMAP: Move gpio.h to include/linux/platform_data
Date: Sat, 1 Sep 2012 01:17:20 +0200
Message-ID: <CACRpkdb7ozr8uxTDudVPMF5Lcr3FMtDLo9RUm-hvqbVUCHji6w@mail.gmail.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
	<20120831005234.28732.10624.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45102 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab2HaXRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 19:17:21 -0400
Received: by wgbdr13 with SMTP id dr13so2890219wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 16:17:20 -0700 (PDT)
In-Reply-To: <20120831005234.28732.10624.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org

On Fri, Aug 31, 2012 at 2:52 AM, Tony Lindgren <tony@atomide.com> wrote:

> This way we can remove includes of plat/gpio.h which won't work
> with the single zImage support.
>
> Note that we also remove the cpu_class_is_omap2() check
> in gpio-omap.c as the drivers should not call it as we need to
> make it local to arch/arm/mach-omap2 for single zImage support.
>
> While at it, arrange the related includes in the standard way.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-mtd@lists.infradead.org
> Cc: alsa-devel@alsa-project.org
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
