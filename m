From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC,
 kexec, atags
Date: Fri, 18 Dec 2009 21:07:30 -0800
Message-ID: <20091219050730.GC4575@atomide.com>
References: <20091219034151.26198.26570.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60848 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZLSFHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 00:07:38 -0500
Content-Disposition: inline
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [091218 19:44]:
> Hi all,
> 
> Here are some v7 fixes, mostly to make kexec work.
> 
> Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
> git repo, I can reboot my n900 in a loop reliably.
> 
> To clarify, this works booting 2.6.33-rc1 in a loop, booting
> the Maemo kernel with kexec does not seem to boot very far
> at all for some reason. I'll look into that next.

After a quick look it seems that the Maemo kernel hangs
at dss_boottime_get_clocks(). Oh well, if anybody has
a patch for that, let me know.

Regards,

Tony
