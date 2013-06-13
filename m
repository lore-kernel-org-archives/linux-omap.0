From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/3] minor omap dma fixes
Date: Thu, 13 Jun 2013 18:39:17 +0530
Message-ID: <1371128960-24822-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36505 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478Ab3FMNKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 09:10:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Hi,

Here are some minor omap dma fixes.

R Sricharan (2):
  ARM: OMAP: dma: Remove the wrong dev_id check
  ARM: OMAP: dma: Fix the dma_chan_link_map init order

Rajendra Nayak (1):
  ARM: OMAP: dma: Fix the kfree ordering

 arch/arm/plat-omap/dma.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.9.5

