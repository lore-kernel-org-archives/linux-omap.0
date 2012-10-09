From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c to
 be OMAP2+ only for now
Date: Tue, 9 Oct 2012 02:49:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210090249240.5736@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com> <20121008221333.GZ13011@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56322 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab2JICt4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 22:49:56 -0400
In-Reply-To: <20121008221333.GZ13011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

On Mon, 8 Oct 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [121007 18:48]:
> > 
> > Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> > debug_card_init() function") results in the following new sparse[1]
> > warning:
> > 
> > arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> > 
> > Normally this could be fixed by including the appropriate header file
> > in plat-omap/debug-devices.c, but the header file now exists only in
> > mach-omap2/, so this would require a "sideways include" and is thus
> > impractical.  It turns out that only code in mach-omap2/ currently
> > uses the debug-devices.c and debug-leds.c files, so move them there.
> > In the long term, these devices should be created by DT, and the code
> > should be moved into drivers/ somewhere.
> 
> Hmm are you sure that omap1 is not using debug-leds.c?
> At least the initcall seems like it should run on omap1
> if enabled.

Will drop this one for now until we figure out what to do about it.


- Paul

