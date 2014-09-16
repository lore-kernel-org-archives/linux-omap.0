From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] dmaengine: omap-dma: Fix cyclic suspend/resume
Date: Tue, 16 Sep 2014 16:53:47 +0300
Message-ID: <1410875629-1540-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

When the audio is paused/resumed (application paused the sream or board suspend)
the audio was only playing back one period worth of data and then stops because
the omap_dam_stop() clears the link configuration and it is not restored in
start.

Also add memory barrier call to resume path since this could happen right after
coming out from suspend.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: omap-dma: Add memory barrier to dma_resume path
  dmaengine: omap-dma: Restore the CLINK_CTRL in resume path

 drivers/dma/omap-dma.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.1.0
