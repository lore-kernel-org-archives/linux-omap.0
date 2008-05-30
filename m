From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/14] Big clean-up for multi-omap
Date: Fri, 30 May 2008 14:41:10 -0700
Message-ID: <20080530214109.GC30901@atomide.com>
References: <1211948418-16455-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61110 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYE3VlN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 May 2008 17:41:13 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1K2CLX-0008Ds-0p
	for linux-omap@vger.kernel.org; Fri, 30 May 2008 21:41:12 +0000
Content-Disposition: inline
In-Reply-To: <1211948418-16455-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080527 21:20]:
> Hi all,
> 
> Following patches clean up blockers for getting multi-omap closer
> to working for omap2 like we have for omap1:
> 
> - Remove __REG macros, use omap_read/write() instead
> 
> - Split omap24xx sram code so no register rewriting is needed
> 
> - Introduce struct omap_globals to allow early cpu detection to
>   work
> 
> - Make PRM and CM registers work for multi-omap
> 
> The __REG patches were posted earlier, but had some issues. They
> should be fixed now.
> 
> The first patch is to test primitive omap type detection with
> DEBUG_LL. Could somebody please try it out on 15xx and make sure
> you get output from DEBUG_LL?
> 
> Once the DEBU_LL patch works on all omaps, we can use the similar
> detection for multi-omap non-optimized get_irq_nr_and_base too :)
> 
> These patches are against current linux-omap tree, I pushed few
> fixes there so you pull before trying out these patches.

I've pushed this series refreshed and in slightly different order.
I also left out the DEBUG_LL patch for now.

Regards,

Tony
