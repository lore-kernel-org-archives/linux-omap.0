From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/4] dmaengine: omap-dma: transfer start and short memcpy
 improvement
Date: Sat, 5 Dec 2015 13:37:00 +0530
Message-ID: <20151205080700.GK1854@localhost>
References: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 11, 2015 at 12:37:54PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> The first two patch is trivial fix.
> The third (remove the tasklet use for starting the transfer):
> I had been wondering about this for a while and now I was able to spend some
> time to look at this in more detail.
> In 'normal' operation I have never seen the tasklet to start more then one
> transfer even when pushing I/O based workloads on the board. However when I run
> the DMAtest module I can see that the tasklet executes about 15 transfers.
> When the tasklet use has been removed, everything worked as well as before but
> the throughput of MMC/SD and memcpy increased slightly:
> 
> dd if=/dev/mmcblk0 of=/dev/null bs=64k count=24000
> ~16.5 MB/s -> ~16.6 MB/s
> 
> echo 6553 > /sys/module/dmatest/parameters/test_buf_size
> echo 2000 > /sys/module/dmatest/parameters/timeout
> echo 5000 > /sys/module/dmatest/parameters/iterations
> ~585 KB/s -> ~638 KB/s
> 
> It worth mentioning that _with_ the tasklet starting the transfers I managed to
> hit a situation once when for some reason the memcpy tests were started to time
> out. This happend with memcpy, iozone, dd and grep -R blabla /usr/ running at
> the same time.
> 
> The last patch is to correct the behaviour of omap-dma when short memcpy is used
> by a client and the client is not using completion, but polling for the end of
> the transfer.

Applied, thanks

-- 
~Vinod
