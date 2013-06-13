From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/3] minor omap dma fixes
Date: Thu, 13 Jun 2013 19:47:08 +0530
Message-ID: <1371133031-29229-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42911 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab3FMORx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 10:17:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi,

Here are some minor omap dma fixes.

v2:
Patch 3/3 was wrongly fixed by just changing the
kfree() order. As Russell suggested the kfree()
was that for platform_data and wrong to begin with.
So Patch 3/3 now removes all instances of kfree() of
platform_data.

R Sricharan (2):
  ARM: OMAP: dma: Remove the wrong dev_id check
  ARM: OMAP: dma: Fix the dma_chan_link_map init order

Rajendra Nayak (1):
  ARM: OMAP: dma: Remove the erroneous freeing of platform data

 arch/arm/plat-omap/dma.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
1.7.9.5

