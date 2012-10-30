From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap plat header removal for v3.8 merge window,
 part1
Date: Tue, 30 Oct 2012 16:54:19 -0700
Message-ID: <20121030235419.GA12739@atomide.com>
References: <20121019023300.GN30550@atomide.com>
 <201210261402.19759.arnd@arndb.de>
 <20121026170949.GF11908@atomide.com>
 <201210261728.22132.arnd@arndb.de>
 <20121026175537.GL11908@atomide.com>
 <20121026223848.GY11908@atomide.com>
 <20121027090210.GJ28061@n2100.arm.linux.org.uk>
 <20121027163233.GA11908@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56877 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755320Ab2J3XyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 19:54:24 -0400
Content-Disposition: inline
In-Reply-To: <20121027163233.GA11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121027 09:34]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121027 02:03]:
> > 
> > Rather than moving all the files from plat-omap/include/plat into plat-omap
> > and then having all these totally disgusting relative includes, why don't
> > you add to these makefiles:
> > 
> > ccflags += -I$(srctree)/arch/arm/plat-omap/include
> > 
> > and avoid all that include moving and all the include name fixup?
> 
> I'll take a look. Most of these headers should be local,
> so it should not be too many files to move for plat-omap
> to fix this.

Posted a series to fix the issue with relative includes
as "[PATCH 00/11] Fix relative includes for omaps introduced
by recent clean-up".

Regards,

Tony
