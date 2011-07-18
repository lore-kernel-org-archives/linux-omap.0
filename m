From: Tony Lindgren <tony@atomide.com>
Subject: Re: conflicts between omap/cleanup branch and omap_dss2 tree
Date: Mon, 18 Jul 2011 01:08:56 -0700
Message-ID: <20110718080856.GW5783@atomide.com>
References: <201107172339.32516.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46639 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750745Ab1GRIJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 04:09:03 -0400
Content-Disposition: inline
In-Reply-To: <201107172339.32516.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

* Arnd Bergmann <arnd@arndb.de> [110717 14:36]:
> Hi Paul and Tomi,
> 
> I'm trying to get the arm-soc tree integrated into linux-next, but right
> now that fails because of lots of conflicts in the arch/arm/mach-omap2/clock44xx_data.c
> and arch/arm/mach-omap2/omap_hwmod_44xx_data.c files.
> 
> I've done a dumb resolution by pulling in the omap_dss2/for_next tree as a
> depedency and taking Tomi's version of the files, which is probably wrong 
> but lets Stephen at least take the arm-soc tree.

Yes that's the wrong way around for these files..

> Please fix this properly in either the omap or the omap_dss2 trees.

The clock and hwmod data patches should get queued by Benoit and Paul,
so I'm suspecting these are some of Tomi's patches still in development.

Tomi can you please check what you have in for-next?

Regards,

Tony
