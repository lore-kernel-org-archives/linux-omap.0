From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Cleanup the omap2_mcspi_txrx_dma
 function
Date: Wed, 12 Sep 2012 11:21:37 +0800
Message-ID: <20120912032135.GJ9162@opensource.wolfsonmicro.com>
References: <1347345800-4116-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347345800-4116-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 12:13:20PM +0530, Shubhrajyoti D wrote:
> Currently in omap2_mcspi_txrx_dma the tx and the rx support is
> interleaved. Make the rx related code in omap2_mcspi_rx_dma
> and the tx related code omap2_mcspi_tx_dma and call the functions.

I'd ideally like some testing from the OMAP side before applying this -
is there someone who can give a Tested-by?
