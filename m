From: Tony Lindgren <tony@atomide.com>
Subject: Re: board_onenand_init() build error in linux-next
Date: Wed, 20 Jun 2012 07:24:32 -0700
Message-ID: <20120620142431.GP12766@atomide.com>
References: <WC20120615124650.94039B@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62207 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab2FTOYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 10:24:34 -0400
Content-Disposition: inline
In-Reply-To: <WC20120615124650.94039B@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Joe Woodward <jw@terrafix.co.uk> [120615 05:51]:
> Someone may have spotted this already...
> 
> But if you build todays linux-next (next-20120615) without CONFIG_MTD_ONENAND_OMAP2 or 
> CONFIG_MTD_ONENAND_OMAP2_MODULE then board_onenand_init() is defined in two places 
> (in board-flash.c:102 as an empty function, and board-flash.h:56 as a static inline).
> 
> This causes the build to fail as board-flash.c includes board-flash.h:
>   CC      arch/arm/mach-omap2/board-flash.o
> arch/arm/mach-omap2/board-flash.c:102:8: error: redefinition of 'board_onenand_init'
> arch/arm/mach-omap2/board-flash.h:56:20: note: previous definition of 'board_onenand_init' 
> was here
> make[1]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
> 
> I'm fairly sure this isn't right!?

Yeah sounds like a bug, got a patch for it?

Tony
