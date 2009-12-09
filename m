From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH v3] omap: serial: fix non-empty uart fifo
 read abort
Date: Wed, 9 Dec 2009 08:28:00 -0800
Message-ID: <20091209162800.GM24013@atomide.com>
References: <1259972404-28784-1-git-send-email-vikram.pandita@ti.com>
 <notify-1260224602@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFA1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56087 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbZLIQ14 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 11:27:56 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFA1C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [091209 00:41]:
> Tony Lindgren wrote:
> > 
> > This patch has been applied to the linux-omap
> > by youw fwiendly patch wobot.
> > 
> > Branch in linux-omap: for-next-vol2
> > 
> 
> Tony,
> 
> A query on this for-next-vol2 branch:
> Is this branch going to be pushed in the current merge
> window, or is it for the -rc series?

What used to be for-next-vol2 is now the current for-next.
We should be able to get that merged too this merge window.

Regards,

Tony

> 
> 
> > PatchWorks
> > http://patchwork.kernel.org/patch/65022/
> 
> 
> With current Linus' tree + this patch, I can boot up on 3630.
> 
> Playing with the omap3_defconfig now, to see how many boards
> we can boot up with a single image :)
> 
> - Anand
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
