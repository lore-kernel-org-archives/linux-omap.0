From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sat, 21 Jan 2012 00:47:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201210042030.28153@utopia.booyaka.com>
References: <1327055619.1921.57.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50924 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab2AUHrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 02:47:23 -0500
In-Reply-To: <1327055619.1921.57.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

On Fri, 20 Jan 2012, Tomi Valkeinen wrote:

> Third, when I load the DSS modules, I see only ON state increasing for
> dss_pwrdm, as it should be. However, I'm getting constant stream of sync
> losts from DSS, and the display doesn't basically work at all.
> 
> I can see MPU pwrdm going into RET a lot, and if I do "while true; do
> echo foo; done", which I presume basically prevents RET for MPU, the
> display becomes stable.

If this particular problem persists after you apply the patch set that I 
sent earlier, it suggests that something in the DSS is sensitive to the 
amount of time it takes the MPU to wake up and service an interrupt when 
the MPU powerdomain is in a low-power state.  Total guess, but perhaps  
omap_dispc_irq_handler() is getting called after each frame and needs to 
run within a certain bounded time when that happens?


- Paul
