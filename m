From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/2] dmaengine: omap-dma: Fix polled completion
Date: Mon, 4 Apr 2016 06:18:25 -0700
Message-ID: <20160404131822.GA19738@vkoul-mobl.iind.intel.com>
References: <1457616527-979-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457616527-979-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux@arm.linux.org.uk, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 10, 2016 at 03:28:45PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> Based on the discussion on the first version:
> https://lkml.org/lkml/2016/2/25/167
> 
> I have fixed the omap_dma_tx_status() - first patch and added the second patch
> to not disable the interrupts for memcpy so multiple transfers can be queued.

Hi Peter,

These do not apply for me. Can you please check.

FWIW my fixes is on -rc1

-- 
~Vinod
