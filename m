From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP: misc. fixes for 2.6.32
Date: Fri, 28 Aug 2009 09:00:49 -0700
Message-ID: <20090828160049.GI25828@atomide.com>
References: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62740 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZH1QAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 12:00:55 -0400
Content-Disposition: inline
In-Reply-To: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [090828 01:28]:
> Tony,
> 
> I pushed a couple more fixes to my pm-upstream/fixes-32 branch.  You've
> already pulled this branch into your for-next, so a re-pull will get
> you just these two additional patches.

OK, I need to rebuild the omap for-next as there are few compilation
issues in at least the omap3-upstream series.

Regards,

Tony
 
> Thanks,
> 
> Kevin
> 
> 
> Reddy, Teerth (1):
>   OMAP3: PM: add T2 interrupt line mux setting, and enable on 3430SDP
> 
> Vikram Pandita (1):
>   OMAP: Zoom2: release debug board detect gpio line
> 
>  arch/arm/mach-omap2/board-3430sdp.c         |    6 ++++++
>  arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++++---
>  arch/arm/mach-omap2/mux.c                   |    5 +++++
>  arch/arm/plat-omap/include/mach/mux.h       |    3 +++
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
