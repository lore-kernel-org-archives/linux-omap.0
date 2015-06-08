From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] dmaengine: ti-dma-crossbar: Support for eDMA
Date: Mon, 8 Jun 2015 16:22:40 +0300
Message-ID: <1433769762-31827-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52915 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbFHNWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2015 09:22:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com

Hi,

Changes since v01:
- Drop change in compatible for the crossbar driver and do the configuration
  based on the DT structure.

The ti-dma-crossbar driver in it's current form can work when it is used with
sDMA (omap-dma). On DRA7x class of devices we have both sDMA and eDMA available.
The sDMA driver expects to get the DMA request line with offset 1. The eDMA
stack does not need the offset.
The crosbbar itself is identical for sDMA and eDMA.
At probe time the driver will do a match to figure out which dma engine it is
connected to and based on that information it will configure the offset needed
by the DMA driver.

Regards,
Peter
---
Misael Lopez Cruz (1):
  dmaengine: ti-dma-crossbar: Make idr xbar instance-specific

Peter Ujfalusi (1):
  dmaengine: ti-dma-crossbar: Add support for eDMA

 drivers/dma/ti-dma-crossbar.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

-- 
2.4.2

