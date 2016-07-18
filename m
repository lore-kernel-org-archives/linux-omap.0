From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
Date: Mon, 18 Jul 2016 11:34:10 +0100
Message-ID: <20160718103409.GH5783@n2100.arm.linux.org.uk>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160714124242.7579-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
> Before looking for the next descriptor to start, complete the just finished
> cookie.

This change will reduce performance as we no longer have an overlap
between the next request starting to be dealt with in the hardware
vs the previous request being completed.  Your commit log doesn't
say _why_ the change is being made, it merely tells us what the
patch is doing, which we can see already.

Please describe changes a little better.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
