From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: GPMC generic timing
Date: Mon, 12 Nov 2012 15:50:43 -0800
Message-ID: <20121112235042.GY6801@atomide.com>
References: <1352470910-9630-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29985 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752506Ab2KLXuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 18:50:46 -0500
Content-Disposition: inline
In-Reply-To: <1352470910-9630-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [121109 06:23]:
> The following changes since commit 6ba54ab4a49bbad736b0254aa6bdf0cb83013815:
> 
>   ARM: OMAP: Remove omap_init_consistent_dma_size() (2012-11-06 16:01:19 -0800)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/x0148406-public/linux-kernel.git tags/gpmc-generic-timing
> 
> for you to fetch changes up to 47acde16726080e5157b602f23937d00a04cd2ed:
> 
>   ARM: OMAP2+: tusb6010: generic timing calculation (2012-11-09 18:07:23 +0530)
> 
> ----------------------------------------------------------------
> These changes provide a generic gpmc timing calculation method,
> migrates existing peripherals that makes use of custom gpmc timing
> calculation method to use the new generic one.
> 
> Generic routine has been verified for onenand async timing calculation
> on omap3evm (with a local change to add onenand support). Generic
> timing calculation method were verified for other peripherals by
> simulation. Generic method has to be verified on peripherals supported
> in mainline.

Thanks pulled into omap-for-v3.8/gpmc. I've replaced the second paragraph
in my tag with the following as that's what I've tried it with:

The generic timing routine has been tested with onenand, smsc911x,
and tusb6010 devices connected to GPMC in addition to simulating
other devices support in the mainline kernel.

Regards,

Tony
