From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v10 00/11] dmtimer adaptation to platform_driver
Date: Fri, 18 Feb 2011 11:07:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0379AF21E6@dbde02.ent.ti.com>
References: <1297861220-831-1-git-send-email-tarun.kanti@ti.com>
 <20110218005706.GR20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841Ab1BRFhL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 00:37:11 -0500
In-Reply-To: <20110218005706.GR20795@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, February 18, 2011 6:27 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin
> Subject: Re: [PATCH v10 00/11] dmtimer adaptation to platform_driver
> 
> Hi,
> 
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110216 04:56]:
> > dmtimer adaptation to platform_driver.
> >
> > This patch series is adaptation of dmtimer code to platform driver
> > using omap_device and omap_hwmod abstraction.
> 
> Looks like this needs rebasing on top of current omap-for-linus
> because of the omap4 hwmod data being merged.
I will rebase on top of omap-for-linus and re-post.

> 
> Also note that you may need to change things with the clock
> init with init_early changes.
> 
> That's something we need to consider carefully as we don't
> necessarily want to have the system timer depend on hwmod
> and clock framework. But that can be fixed later on after
> your patch series.
OK, I will take care.
> 
> Tony
