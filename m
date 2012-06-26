From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap4: Fix standalone OMAP4 build break
Date: Tue, 26 Jun 2012 03:28:42 -0700
Message-ID: <20120626102842.GB31393@atomide.com>
References: <1340365461-25385-1-git-send-email-rnayak@ti.com>
 <20120625105336.GD12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28451 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab2FZK2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 06:28:45 -0400
Content-Disposition: inline
In-Reply-To: <20120625105336.GD12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120625 03:58]:
> * Rajendra Nayak <rnayak@ti.com> [120622 04:48]:
> > Fix the below build error while building OMAP4 standalone
> > 
> >   CC      arch/arm/mach-omap2/board-flash.o
> > arch/arm/mach-omap2/board-flash.c:102: error: redefinition of 'board_onenand_init'
> > arch/arm/mach-omap2/board-flash.h:56: note: previous definition of 'board_onenand_init' was here
> > make[1]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Thanks, applying into fixes with the updated description to describe
> the regression causing commit.

Oops, looks like I have an earlier fix already in fixes-board branch
from Kevin that I'll use instead.

Regards,

Tony
