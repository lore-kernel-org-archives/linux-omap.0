From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/1] dying serial console in PM branch
Date: Mon, 19 Oct 2009 16:02:41 -0700
Message-ID: <20091019230241.GV12576@atomide.com>
References: <1255990482-16201-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54744 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553AbZJSXCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 19:02:39 -0400
Content-Disposition: inline
In-Reply-To: <1255990482-16201-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [091019 15:14]:
> This patch fixes the problems in the PM branch where the serial
> console on UART3 was not able to wakeup after the inactivity timer.
> 
> This fix has been pushed to the PM branch already, but should also
> be queued as a fix upstream.

OK, good to hear you found the problem!
 
> Tony, this is available in my pm-upstream/pm-fixes-32 branch based at
> v2.6.32-rc5.  I shouldn't have any more PM fixes coming for 2.6.32.

Thanks, since it's just one patch, I'll apply it into my omap-fixes
from the patchwork.k.o for easier handling.

Regards,

Tony

> 
> Kevin Hilman (1):
>   OMAP3: PM: enable UART3 module wakeups
> 
>  arch/arm/mach-omap2/pm34xx.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
