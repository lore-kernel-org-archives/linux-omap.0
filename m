From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: Misc cleanup
Date: Tue, 8 May 2012 11:34:14 -0700
Message-ID: <20120508183414.GZ5088@atomide.com>
References: <1336461259-28596-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:13629 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2EHSeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 14:34:19 -0400
Content-Disposition: inline
In-Reply-To: <1336461259-28596-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120508 00:18]:
> Tony,
> 
> Please pull the following preparatory cleanup series to add OMAP5 minimal
> support. Boot tested on OMAP2430 SDP, OMAP3430 SDP and OMAP4430 SDP platforms.
> 
> I have dropped {[PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function}
> from this set since Paul is taking that one in his queue.

OK thanks, pulling this into cleanup-soc and merging into cleanup branch
with what we have in devel-hwmod.
 
> P.S: While merging this series with linux-omap master, I saw one trivial
> Makefile conflict.

Yes that's with devel-hwmod, I'm basing cleanup branch on that so we have
all the dependencies out of the way for adding omap5 and am33xx patches
on top of the cleanup branch.

Regards,

Tony
