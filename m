From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP3/4: hwmod data changes for 3.3
Date: Fri, 16 Dec 2011 11:48:14 -0800
Message-ID: <20111216194813.GI32251@atomide.com>
References: <alpine.DEB.2.00.1112160423360.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49407 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760245Ab1LPTsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 14:48:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112160423360.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111216 02:53]:
> Hi Tony
> 
> Here are some hwmod data changes for the 3.3 merge window.  Note that they 
> have a dependency on the 3.2-rc hwmod data fixes.  Once those are merged, 
> I'd be happy to update this pull request on a stable commit.
> 
> The following changes since commit 91a36bdb3ada99ebf3a613a0dab2d741445ffd7f:
> 
>   ARM: OMAP: hwmod data: fix the panic on Nokia RM-680 during boot (2011-12-15 22:38:37 -0700)

Thanks pulling into hwmod branch on top of fixes-non-critical-part2.
No need to rebase since I have your commit above pulled already in
fixes-non-critical-part2.

Regards,

Tony
