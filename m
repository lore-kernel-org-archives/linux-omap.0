From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/2] dmaengine: edma/omap-dma: max_burst validity
 checking
Date: Thu, 12 Oct 2017 22:14:59 +0530
Message-ID: <20171012164459.GS30097@localhost>
References: <20171003083538.11044-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171003083538.11044-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 03, 2017 at 11:35:36AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Fixed typo in commit message
> - Separated from the 'dmaengine: core/edma/omap-dma: maximum SG len reporting'
>   series
> 
> Both eDMA and sDMA have limit on the maximum burst size. The two patch
> implements protection against too big burst size for both driver.

I have applied these, but had to hand fix the patches. I guess you should
use gmail or someother server to send patches

-- 
~Vinod
