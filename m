From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] dma: edma: Split out PaRAM set calculations into
 its own function
Date: Mon, 21 Oct 2013 12:56:12 +0530
Message-ID: <20131021072612.GN14013@intel.com>
References: <1379977515-3794-1-git-send-email-joelf@ti.com>
 <1379977515-3794-2-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379977515-3794-2-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Matt Porter <matt@ohporter.com>, Mark Brown <broonie@linaro.org>, Russell King <linux@arm.linux.org.uk>, Dan Williams <djbw@fb.com>, Jyri Sarha <jsarha@ti.com>, Lars Peter-Clausen <lars@metafoo.de>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 23, 2013 at 06:05:13PM -0500, Joel Fernandes wrote:
> PaRAM set calculation is abstracted into its own function to
> enable better reuse for other DMA cases such as cyclic. We adapt
> the Slave SG case to use the new function.
> 
> This provides a much cleaner abstraction to the internals of the
> PaRAM set. However, any PaRAM attributes that are not common to
> all DMA types must be set separately such as setting of interrupts.
> This function takes care of the most-common attributes.
> 
> Also added comments clarifying A-sync case calculations.
Applied, thanks

--
~Vinod
