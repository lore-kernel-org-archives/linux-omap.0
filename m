From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] dmaengine: omap-dma: transfer start and short memcpy improvement
Date: Wed, 11 Nov 2015 12:37:54 +0200
Message-ID: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

The first two patch is trivial fix.
The third (remove the tasklet use for starting the transfer):
I had been wondering about this for a while and now I was able to spend some
time to look at this in more detail.
In 'normal' operation I have never seen the tasklet to start more then one
transfer even when pushing I/O based workloads on the board. However when I run
the DMAtest module I can see that the tasklet executes about 15 transfers.
When the tasklet use has been removed, everything worked as well as before but
the throughput of MMC/SD and memcpy increased slightly:

dd if=/dev/mmcblk0 of=/dev/null bs=64k count=24000
~16.5 MB/s -> ~16.6 MB/s

echo 6553 > /sys/module/dmatest/parameters/test_buf_size
echo 2000 > /sys/module/dmatest/parameters/timeout
echo 5000 > /sys/module/dmatest/parameters/iterations
~585 KB/s -> ~638 KB/s

It worth mentioning that _with_ the tasklet starting the transfers I managed to
hit a situation once when for some reason the memcpy tests were started to time
out. This happend with memcpy, iozone, dd and grep -R blabla /usr/ running at
the same time.

The last patch is to correct the behaviour of omap-dma when short memcpy is used
by a client and the client is not using completion, but polling for the end of
the transfer.

Regards,
Peter
---
Peter Ujfalusi (4):
  dmaengine: omap-dma: Correct status reporting for memcpy
  dmaengine: omap-dma: Clean up the prep_slave_sg sg list walk code
  dmaengine: omap-dma: Remove tasklet to start the transfers
  dmaengine: omap-dma: Handle cases when the channel is polled for
    completion

 drivers/dma/omap-dma.c | 78 +++++++++-----------------------------------------
 1 file changed, 14 insertions(+), 64 deletions(-)

-- 
2.6.2
