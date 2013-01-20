From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RESEND][PATCH] dma: edma: fix slave config dependency on
 direction
Date: Sun, 20 Jan 2013 04:05:15 -0800
Message-ID: <20130120120515.GB23398@intel.com>
References: <1357843264-27045-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357843264-27045-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 10, 2013 at 01:41:04PM -0500, Matt Porter wrote:
> The edma_slave_config() implementation depends on the
> direction field such that it will not properly configure
> a slave channel when called without direction set.
> 
> This fixes the implementation so that the slave config
> is copied as is and prep_slave_sg() handles the
> direction dependent handling. spi-omap2-mcspi and
> omap_hsmmc both expose this bug as they configure the
> slave channel config from a common path with an unconfigured
> direction field.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
Applied, Thanks

--
~Vinod
