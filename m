From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Re: [PATCH] OMAP: Use omap_rev() instead of system_rev
Date: Fri, 31 Oct 2008 15:30:49 +0200
Message-ID: <20081031133049.GA23185@pure.research.nokia.com>
References: <1225409305-3465-1-git-send-email-lauri.leukkunen@nokia.com> <1225409305-3465-2-git-send-email-lauri.leukkunen@nokia.com> <20081031003438.GA13227@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40191 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbYJaNar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 09:30:47 -0400
Content-Disposition: inline
In-Reply-To: <20081031003438.GA13227@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 30/10/08 17:34 -0700, ext Tony Lindgren wrote:
> * Lauri Leukkunen <lauri.leukkunen@nokia.com> [081030 16:29]:
> > system_rev is meant for board revision, this patch changes
> > all relevant instances to use the new omap_rev() function
> > liberating system_rev to be used with ATAG_REVISION as it
> > has been designed.
> 
> Looks good to me! Let's make sure things still work and
> I'll push it and add it to my other id.c fixes to Russsell.

Seems to work (as well as the current l-o works) on omap3, compile tested for
omap1, omap2 fails to compile for me totally (also without my patch)with:

"__LINUX_ARM_ARCH__" is not defined

This is with a cs2008q3 compiler.

/lauri

