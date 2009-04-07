From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH 3/3] OMAP: dmtimer: enable all timers to be
	wakeup events
Date: Tue, 7 Apr 2009 11:04:47 -0700
Message-ID: <20090407180447.GC23823@atomide.com>
References: <20090404205409.12269.94966.stgit@localhost.localdomain> <notify-1239126497@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62120 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbZDGSEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 14:04:50 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LrFfF-0004h4-63
	for linux-omap@vger.kernel.org; Tue, 07 Apr 2009 18:04:49 +0000
Content-Disposition: inline
In-Reply-To: <notify-1239126497@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090407 10:49]:
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
> 
> Initial commit ID (Likely to change): 7287a91be3de9ee00f8da7c07f19b368fd0969ae
> 
> PatchWorks
> http://patchwork.kernel.org/patch/16349/
> 
> Git
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=7287a91be3de9ee00f8da7c07f19b368fd0969ae

Well let's change the order of these patches, if you can sink #3
before #3 as we discussed on the phone. This way if adding the
gpt 12 support for Beagle is considered too intrusive, it's
easier to drop from omap-fixes and move to for-next instead.

So dropping all three until you have the updated series available.

Thanks,

Tony
