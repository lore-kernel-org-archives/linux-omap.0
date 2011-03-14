From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: plat-omap: iommu: fix request_mem_region() error
 path
Date: Mon, 14 Mar 2011 11:12:30 -0700
Message-ID: <20110314181230.GE7258@atomide.com>
References: <1300105712-12656-1-git-send-email-aaro.koskinen@nokia.com>
 <20110314.145029.848855634033118142.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20945 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab1CNSMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 14:12:38 -0400
Content-Disposition: inline
In-Reply-To: <20110314.145029.848855634033118142.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: aaro.koskinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [110314 05:50]:
> Hi Aaro,
> 
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> Subject: [PATCH] arm: plat-omap: iommu: fix request_mem_region() error path
> Date: Mon, 14 Mar 2011 14:28:32 +0200
> 
> > request_mem_region() error exit will leak ioremapped memory. Fix this
> > by moving the ioremap() after request_mem_region(), which is the proper
> > order to do this anyway.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> > ---
> >  arch/arm/plat-omap/iommu.c |   14 ++++++++------
> >  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> True. Thank you for catching this.

Applying.

Tony
