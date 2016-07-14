From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/7] dmaengine:omap-dma: Linked List transfer for slave_sg
Date: Thu, 14 Jul 2016 15:42:35 +0300
Message-ID: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi,

The following series with the final patch will add support for sDMA Linked List
transfer support.
Linked List is supported by sDMA in OMAP3630+ (OMAP4/5, dra7 family).
If the descriptor load feature is present we can create the descriptors for each
SG beforehand and let sDMA to walk them through.
This way the number of sDMA interrupts the kernel need to handle will drop
dramatically.

I have gathered some numbers to show the difference.

Booting up the board with filesystem on SD card for example:
# cat /proc/interrupts | grep dma
W/o LinkedList support:
 27:       4436          0     WUGEN  13 Level     omap-dma-engine

Same board/filesystem with this patch:
 27:       1027          0     WUGEN  13 Level     omap-dma-engine

Or copying files from SD card to eMCC:
# du -h /usr
2.1G    /usr/
# find /usr/ -type f | wc -l
232001

# cp -r /usr/* /mnt/emmc/tmp/

W/o LinkedList we see ~761069 DMA interrupts.
With LinkedList support it is down to ~269314 DMA interrupts.

With the decreased DMA interrupt number the CPU load is dropping
significantly as well.

The series depends on the interleaved transfer support patch I have sent couple
of days ago:
https://lkml.org/lkml/2016/7/12/216

Regards,
Peter
---
Peter Ujfalusi (7):
  dmaengine: omap-dma: Simplify omap_dma_start_sg parameter list
  dmaengine: omap-dma: Complete the cookie first on transfer completion
  dmaengine: omap-dma: Simplify omap_dma_callback
  dmaengine: omap-dma: Dynamically allocate memory for lch_map
  dmaengine: omap-dma: Add more debug information when freeing channel
  dmaengine: omap-dma: Use pointer to omap_sg in slave_sg setup's loop
  dmaengine: omap-dma: Support for LinkedList transfer of slave_sg

 drivers/dma/omap-dma.c | 234 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 207 insertions(+), 27 deletions(-)

--
2.9.1
