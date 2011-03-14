From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] arm: plat-omap: iommu: fix request_mem_region() error
 path
Date: Mon, 14 Mar 2011 14:50:29 +0200 (EET)
Message-ID: <20110314.145029.848855634033118142.Hiroshi.DOYU@nokia.com>
References: <1300105712-12656-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:38204 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639Ab1CNMwv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 08:52:51 -0400
In-Reply-To: <1300105712-12656-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, aaro.koskinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Aaro,

From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: plat-omap: iommu: fix request_mem_region() error path
Date: Mon, 14 Mar 2011 14:28:32 +0200

> request_mem_region() error exit will leak ioremapped memory. Fix this
> by moving the ioremap() after request_mem_region(), which is the proper
> order to do this anyway.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/plat-omap/iommu.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)

True. Thank you for catching this.
