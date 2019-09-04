From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 0/5] dmaengine: ti: edma: Multicore usage related fixes
Date: Wed, 4 Sep 2019 15:19:56 +0530
Message-ID: <20190904094956.GT2672@vkoul-mobl>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: robh+dt@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 23-08-19, 15:56, Peter Ujfalusi wrote:
> Hi,
> 
> When other cores want to use EDMA for their use cases Linux was not playing
> nicely.
> By design EDMA is supporting shared use with shadow regions. Linux is using
> region0, others can be used by other cores.
> 
> In order to not break multicore shared usage of EDMA:
> - do not reset paRAM slots which is not allocated for Linux (reserved paRAM
>   slots)
> - Only reset region0 access registers, do not touch other regions
> - Add option for reserved channels which should not be used by Linux in a similar
>   fashion as we already have for reserved paRAM slots.

Applied 1 to 3, thanks

-- 
~Vinod
