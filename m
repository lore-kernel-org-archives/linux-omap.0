From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [RFC] dmaengine: omap-dma: Start DMA without delay
Date: Fri, 29 Mar 2013 15:36:07 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1303291533540.26456@pmeerw.net>
References: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


> Remove the use of a tasklet to start the DMA channel when issue_pending is
> called.
> The use of tasklet delays the DMA start which can cause issues at drivers,
> for example the audio drivers expect that the DMA is started right away.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I've reported the problem and now tested the patch applied on top of 
3.8.5, running on beagle-xm; sounds good, so

Tested-by: Peter Meerwald <p.meerwald@bct-electronic.com>

-- 

Peter Meerwald
+43-664-2444418 (mobile)
