From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 0/2] OMAP: IOMMU fault callback support
Date: Mon, 21 Feb 2011 11:52:21 +0200 (EET)
Message-ID: <20110221.115221.795673505667830874.Hiroshi.DOYU@nokia.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:43926 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386Ab1BUJwp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 04:52:45 -0500
In-Reply-To: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dacohen@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v3 0/2] OMAP: IOMMU fault callback support
Date: Wed, 16 Feb 2011 21:35:49 +0200

> Hi,
> 
> This patch set adapts current (*isr)() to be used as fault callback.
> IOMMU faults might be very difficult to reproduce and then to figure out
> the source of the problem. Currently IOMMU driver prints not so useful
> debug message and does not notice user about such issue.
> With a fault callback, IOMMU user may debug much more useful information
> and/or react to go back to a valid state.

Tony, please put them in your queue too. Thanks.

> Br,
> 
> David
> ---
> 
> David Cohen (2):
>   OMAP2+: IOMMU: don't print fault warning on specific layer
>   OMAP: IOMMU: add support to callback during fault handling

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

> 
>  arch/arm/mach-omap2/iommu2.c            |   33 +++++++++-----------
>  arch/arm/plat-omap/include/plat/iommu.h |   14 ++++++++-
>  arch/arm/plat-omap/iommu.c              |   52 ++++++++++++++++++++++---------
>  3 files changed, 65 insertions(+), 34 deletions(-)
> 
> -- 
> 1.7.2.3
> 
