From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/7] dmaengine:omap-dma: Linked List transfer for slave_sg
Date: Mon, 18 Jul 2016 11:31:37 +0100
Message-ID: <20160718103137.GG5783@n2100.arm.linux.org.uk>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 14, 2016 at 03:42:35PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> The following series with the final patch will add support for sDMA Linked List
> transfer support.
> Linked List is supported by sDMA in OMAP3630+ (OMAP4/5, dra7 family).
> If the descriptor load feature is present we can create the descriptors for each
> SG beforehand and let sDMA to walk them through.
> This way the number of sDMA interrupts the kernel need to handle will drop
> dramatically.

I suggested this a few years ago, and I was told by TI that there was
no interest to implement this feature as it had very little performance
effect.  Do I take it that TI have changed their position on this
feature?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
