From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: edma: Do not change the error code
 returned from edma_alloc_slot
Date: Thu, 31 Jul 2014 17:28:17 +0530
Message-ID: <20140731115817.GR8181@intel.com>
References: <1406801558-13126-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406801558-13126-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, joelf@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 31, 2014 at 01:12:37PM +0300, Peter Ujfalusi wrote:
> In case of edma_alloc_slot() failure during probe we should return the error
> unchanged to make debugging easier.

Applied both

Thanks

-- 
~Vinod
