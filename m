From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH 3/3] [ARM] omap850: Use ck_ref clock for
	omap850.
Date: Tue, 22 Sep 2009 15:36:38 -0700
Message-ID: <20090922223638.GH4919@atomide.com>
References: <notify-1253656568@atomide.com> <4AB95230.4090409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50576 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbZIVWgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 18:36:37 -0400
Content-Disposition: inline
In-Reply-To: <4AB95230.4090409@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Angelo Arrifano <miknix@gmail.com>
Cc: linux-omap@vger.kernel.org

* Angelo Arrifano <miknix@gmail.com> [090922 15:33]:
> Tony Lindgren wrote:
> > This patch has been applied to the linux-omap
> > by youw fwiendly patch wobot.
> > 
> > Branch in linux-omap: omap-fixes
> > 
> > Initial commit ID (Likely to change): 16f038289768a16888e0131471f7c7eb841d36bf
> 
> Just a notice, this patch *as-is* will probably break the tree.
> 
> Current linux-omap still doesn't have a CK_7XX definition, which is
> introduced by "[RFC] OMAP1: Massive clean up of omap730/omap850 code"

OK, let's drop it for now then and then do the massive clean up after
-rc1.

Tony

> 
> Sorry,
> - Angelo
> > 
> > PatchWorks
> > http://patchwork.kernel.org/patch/45810/
> > 
> > Git (Likely to change, and takes a while to get mirrored)
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=16f038289768a16888e0131471f7c7eb841d36bf
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
