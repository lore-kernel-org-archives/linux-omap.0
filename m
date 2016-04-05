From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/2] dmaengine: omap-dma: Fix polled completion
Date: Tue, 5 Apr 2016 09:10:16 -0700
Message-ID: <20160405161014.GA5392@vkoul-mobl.iind.intel.com>
References: <1459858821-25191-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459858821-25191-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux@arm.linux.org.uk, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2016 at 03:20:19PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v2:
> - series rebased on -rc1 for resending
> 
> Cover letter from v2:
> 
> Based on the discussion on the first version:
> https://lkml.org/lkml/2016/2/25/167
> 
> I have fixed the omap_dma_tx_status() - first patch and added the second patch
> to not disable the interrupts for memcpy so multiple transfers can be queued.

Applied thanks

-- 
~Vinod
