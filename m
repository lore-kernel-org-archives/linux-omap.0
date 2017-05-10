From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 01/10] dmaengine: omap-dma: port_window support
 correction for both direction
Date: Wed, 10 May 2017 09:28:47 -0700
Message-ID: <20170510162847.GM3489@atomide.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
 <20170510084231.19302-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170510084231.19302-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dmaengine@vger.kernel.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [170510 01:45]:
> When the port_window support was verified it was done on setup where only
> the MEM_TO_DEV direction was enabled. This got un-noticed and thus only
> this direction worked.
> 
> Now that I have managed to get a setup to verify both direction it turned
> out that the setup was incorrect:
> omap_desc members are settings for the slave port while the omap_sg members
> apply to the memory side of the sDMA setup.
> 
> Fixes: 527a27591312 ("dmaengine: omap-dma: Fix the port_window support")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: dmaengine@vger.kernel.org
> Cc: dan.j.williams@intel.com
> Cc: vinod.koul@intel.com

Tested-by: Tony Lindgren <tony@atomide.com>
