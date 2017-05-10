From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 09/10] ARM: OMAP2+: DMA: Add slave map entries for
 24xx external request lines
Date: Wed, 10 May 2017 09:30:21 -0700
Message-ID: <20170510163020.GN3489@atomide.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
 <20170510084231.19302-10-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170510084231.19302-10-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [170510 01:46]:
> The external request lines are used by tusb6010 on OMAP24xx platforms.
> Update the map so the driver can use dmaengine API to request the DMA
> channel. At the same time add temporary map containing only the external
> DMA request numbers for DT booted case on omap24xx since the tusb6010 stack
> is not yet supports DT boot.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Best to merge this together with the series:

Acked-by: Tony Lindgren <tony@atomide.com>
