From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Wed, 20 May 2015 22:50:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505202249450.7960@utopia.booyaka.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com> <1432156863-19695-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51299 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbbETWu5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 18:50:57 -0400
In-Reply-To: <1432156863-19695-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Roger Quadros <rogerq@ti.com>

On Wed, 20 May 2015, Tony Lindgren wrote:

> We support decoding the bootloader values if DEBUG is defined.
> But we also need to change the struct omap_hwmod flags to have
> HWMOD_INIT_NO_RESET to avoid the GPMC being reset during the
> boot. Otherwise just the default timings will be displayed
> instead of the bootloader configured timings.
> 
> This also allows us to clean up the various GPMC related
> hwmod flags. For debugging, we only need HWMOD_INIT_NO_RESET,
> and HWMOD_INIT_NO_IDLE is not needed.
> 
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks good to me, want me to queue it or do you want to?


- Paul
