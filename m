From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 1/9] dmaengine: omap-dma: port_window support
 correction for both direction
Date: Sun, 14 May 2017 18:40:08 +0530
Message-ID: <20170514131008.GL6263@localhost>
References: <20170512135752.1800-1-peter.ujfalusi@ti.com>
 <20170512135752.1800-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512135752.1800-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dmaengine@vger.kernel.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

On Fri, May 12, 2017 at 04:57:44PM +0300, Peter Ujfalusi wrote:
> When the port_window support was verified it was done on setup where only
> the MEM_TO_DEV direction was enabled. This got un-noticed and thus only
> this direction worked.
> 
> Now that I have managed to get a setup to verify both direction it turned
> out that the setup was incorrect:
> omap_desc members are settings for the slave port while the omap_sg members
> apply to the memory side of the sDMA setup.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
