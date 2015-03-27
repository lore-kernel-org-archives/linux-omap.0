From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 5/7] dmaengine: omap-dma: Take DMA request number from
 DT if it is available
Date: Fri, 27 Mar 2015 20:24:46 +0000
Message-ID: <20150327202446.GB4027@n2100.arm.linux.org.uk>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
 <1427459213-14611-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427459213-14611-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, tony@atomide.com, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 27, 2015 at 02:26:51PM +0200, Peter Ujfalusi wrote:
> +	if (!pdev->dev.of_node || of_property_read_u32(pdev->dev.of_node,
> +						       "dma-requests",
> +						       &od->dma_requests)) {
> +		dev_info(&pdev->dev,
> +			 "Missing dma-requests property, using %u.\n",
> +			 OMAP_SDMA_REQUESTS);
> +		od->dma_requests = OMAP_SDMA_REQUESTS;
> +	}

Are all OMAPs including OMAP1 being converted to DT?  If not, don't
introduce noisy printks for which a platform can't do anything about.
Think about this please - if there's no of_node, then why complain
about a missing OF property?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
