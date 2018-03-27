From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: Check the memory allocation for the
 memcpy dma device
Date: Tue, 27 Mar 2018 17:43:54 +0530
Message-ID: <20180327121353.GK15443@localhost>
References: <20180321083022.32616-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321083022.32616-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 21, 2018 at 10:30:22AM +0200, Peter Ujfalusi wrote:
> If the allocation fails then disable the memcpy support.

Applied, thanks

-- 
~Vinod
