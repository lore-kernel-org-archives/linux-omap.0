From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] dmtimer changes for v3.2 merge window
Date: Mon, 3 Oct 2011 17:07:43 -0700
Message-ID: <20111004000743.GM6324@atomide.com>
References: <20110928220237.GE6324@atomide.com>
 <201109302213.42435.arnd@arndb.de>
 <2793025.zWgRvMbLEl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37847 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1JDAHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 20:07:47 -0400
Content-Disposition: inline
In-Reply-To: <2793025.zWgRvMbLEl@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [111001 09:12]:
> On Friday 30 September 2011 22:13:42 Arnd Bergmann wrote:
> > On Thursday 29 September 2011, Tony Lindgren wrote:
> > > Please pull omap dmtimer changes from:
> > > 
> > > git://github.com/tmlind/linux.git dmtimer
> > > 
> > > This series completes the system timer separation from the
> > > driver like features. It also adds support for v2 ip that is
> > > available for some timers starting with omap4.
> > > 
> > > After this series arch/arm/plat-omap/dmtimer.c could be
> > > moved to live under drivers somewhere, but there is still
> > > discussion going on which features should be supported in
> > > a generic way.
> > > 
> > > This series depends on the cleanup you pulled earlier.
> > > As this series adds some new features like runtime PM suppport,
> > > I've kept it separate from cleanup.
> > 
> > Looks really nice. I've put it into another top-level branch
> > named next/dmtimer for now. I'm open for suggestions on whether
> > I should generally push branches like this separately Linuswards
> > or better aggregate multiple standalone features into a single
> > branch. 
> 
> I'm adding the patch below to fix a trivial randconfig build regression
> in this series.
> 
> 	Arnd
> 
> 8<---
> 
> Subject: [PATCH] ARM: omap: use __devexit_p in dmtimer driver
> 
> The omap_dm_timer_remove function gets discarded when
> CONFIG_HOTPLUG is not set, so we must not reference it
> unconditionally.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Great, thanks!

Acked-by: Tony Lindgren <tony@atomide.com>
 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index de7896f..2def4e1 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -723,7 +723,7 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
>  
>  static struct platform_driver omap_dm_timer_driver = {
>  	.probe  = omap_dm_timer_probe,
> -	.remove = omap_dm_timer_remove,
> +	.remove = __devexit_p(omap_dm_timer_remove),
>  	.driver = {
>  		.name   = "omap_timer",
>  	},
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
