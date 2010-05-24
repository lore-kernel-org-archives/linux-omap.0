From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 0/3][v3] omap:iommu-enable TLB miss interrupt
Date: Mon, 24 May 2010 09:25:44 +0300 (EEST)
Message-ID: <20100524.092544.241926993.Hiroshi.DOYU@nokia.com>
References: <1274666512-19765-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53607 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab0EXN1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 09:27:11 -0400
In-Reply-To: <1274666512-19765-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, x0124230@ti.com

Hi Hari,

From: ext Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/3][v3] omap:iommu-enable TLB miss interrupt
Date: Mon, 24 May 2010 04:01:49 +0200

> The current iommu module doesn't provide the mechanism to get MMU fault on
> TLB miss when working with locked TLB entries and TWL disabled.
> To get the TLB miss interrupt, the TWL should be disabled.
> This patch set provides the option to enable/disable TWL and to enable TLB miss
> interrupt.

OK for me. Thanks.

FYI: all patches are queued in the following branch for the next merge:

  git://gitorious.org/~doyu/lk/mainline.git iommu
