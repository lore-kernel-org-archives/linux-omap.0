From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: Add probe callback to edma_tptc_driver
Date: Fri, 18 Dec 2015 11:03:41 +0530
Message-ID: <20151218053341.GT1854@localhost>
References: <1450271945-15263-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450271945-15263-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, tony@atomide.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 16, 2015 at 03:19:05PM +0200, Peter Ujfalusi wrote:
> Due to changes in device and platform code drivers w/o probe will fail to
> load. This means that the devices for eDMA TPTCs are goign to be without
> driver and omap hwmod code will turn them off after the kernel finished
> loading:
> [    3.015900] platform 49800000.tptc: omap_device_late_idle: enabled but no driver.  Idling
> [    3.024671] platform 49a00000.tptc: omap_device_late_idle: enabled but no driver.  Idling
> 
> This will prevent eDMA to work since the TPTCs are not enabled.

Applied, thanks

-- 
~Vinod
