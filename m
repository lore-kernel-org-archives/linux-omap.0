From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MAINTAINERS: Add list entries
	linux-arm@vger.kernel.org and linux-arm-kernel@ to OMAP sections
Date: Fri, 7 Aug 2009 11:01:04 +0300
Message-ID: <20090807080102.GV2358@atomide.com>
References: <1249576450.3467.25.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59627 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052AbZHGIBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 04:01:12 -0400
Content-Disposition: inline
In-Reply-To: <1249576450.3467.25.camel@Joe-Laptop.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>

Hi,

* Joe Perches <joe@perches.com> [090806 19:35]:
> Perhaps it's useful for OMAP patches and bug reports
> to CC entries to the primary and secondary ARM lists.
> 
> Added a pattern entry for OMAP USB as well.

Good idea, except maybe let's leave out all the driver parts
because that will cause tons of extra noise on the lists,
see below.

> 
> Signed-off-by: Joe Perches
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1114cf..f237765 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3662,6 +3662,8 @@ F:	drivers/video/nvidia/
>  OMAP SUPPORT
>  M:	"Tony Lindgren <tony@atomide.com>" <tony@atomide.com>
>  L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  W:	http://www.muru.com/linux/omap/
>  W:	http://linux.omap.com/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> @@ -3671,12 +3673,16 @@ F:	arch/arm/*omap*
>  OMAP CLOCK FRAMEWORK SUPPORT
>  M:	Paul Walmsley <paul@pwsan.com>
>  L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  S:	Maintained
>  F:	arch/arm/*omap*/*clock*
>  
>  OMAP POWER MANAGEMENT SUPPORT
>  M:	Kevin Hilman <khilman@deeprootsystems.com>
>  L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  S:	Maintained
>  F:	arch/arm/*omap*/*pm*
>  
All the above look good to me, but..

> @@ -3684,6 +3690,8 @@ OMAP AUDIO SUPPORT
>  M:	Jarkko Nikula <jhnikula@gmail.com>
>  L:	alsa-devel@alsa-project.org (subscribers-only)
>  L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  S:	Maintained
>  F:	sound/soc/omap/
>  
> @@ -3691,17 +3699,24 @@ OMAP FRAMEBUFFER SUPPORT
>  M:	Imre Deak <imre.deak@nokia.com>
>  L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
>  L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/video/omap/
>  
>  OMAP MMC SUPPORT
>  M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
>  L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/*omap*
>  
>  OMAP RANDOM NUMBER GENERATOR SUPPORT
>  M:	Deepak Saxena <dsaxena@plexity.net>
> +L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/char/hw_random/omap-rng.c
>  
> @@ -3710,7 +3725,10 @@ M:	Felipe Balbi <felipe.balbi@nokia.com>
>  M:	David Brownell <dbrownell@users.sourceforge.net>
>  L:	linux-usb@vger.kernel.org
>  L:	linux-omap@vger.kernel.org
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm@vger.kernel.org
>  S:	Maintained
> +F:	drivers/usb/*/*omap*
>  
>  OMFS FILESYSTEM
>  M:	Bob Copeland <me@bobcopeland.com>

... I think let's not add the drivers. The related driver list
and linux-omap list should be enough for these.

Regards,

Tony
