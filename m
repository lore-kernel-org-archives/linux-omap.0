From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for
 device-tree
Date: Thu, 17 May 2012 10:48:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205171047580.2921@utopia.booyaka.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com> <4FB37356.9040001@ti.com> <4FB40AB5.10302@ti.com> <alpine.DEB.2.00.1205161727200.2921@utopia.booyaka.com> <4FB51FA9.7010202@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47993 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759792Ab2EQQsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 12:48:23 -0400
In-Reply-To: <4FB51FA9.7010202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Thu, 17 May 2012, Jon Hunter wrote:

> Yes that's right. What is your preference here, the options are ...
> 
> 1. Move the clkt_clksel.c file to arch/arm/plat-omap and change the
> omap2_xxx API names to omap_xxx.
> 2. Add the functions in clkt_clksel.c to arch/arm/plat-omap/clock.c and
> get rid of clkt_clksel.c altogether.

#1.


- Paul
