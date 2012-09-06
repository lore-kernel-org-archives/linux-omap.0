From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/9] ARM: OMAP: Move gpio.h to
 include/linux/platform_data
Date: Thu, 6 Sep 2012 13:36:54 -0700
Message-ID: <20120906203653.GI1303@atomide.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005234.28732.10624.stgit@muffinssi.local>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC3AF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43625 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751759Ab2IFUhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:37:00 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9DC3AF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

* Mohammed, Afzal <afzal@ti.com> [120903 03:15]:
> Hi,
> 
> On Fri, Aug 31, 2012 at 06:22:34, Tony Lindgren wrote:
> > This way we can remove includes of plat/gpio.h which won't work
> > with the single zImage support.
> > 
> > Note that we also remove the cpu_class_is_omap2() check
> > in gpio-omap.c as the drivers should not call it as we need to
> > make it local to arch/arm/mach-omap2 for single zImage support.
> > 
> > While at it, arrange the related includes in the standard way.
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: linux-mtd@lists.infradead.org
> > Cc: alsa-devel@alsa-project.org
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> I think there is only one Tony ;)

Heh thanks I'll tell myself to replace it with Signed-off-by :)

Tony
