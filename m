From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] dma: edma: Increase maximum SG limit to 20
Date: Mon, 21 Oct 2013 12:56:45 +0530
Message-ID: <20131021072645.GO14013@intel.com>
References: <1379977515-3794-1-git-send-email-joelf@ti.com>
 <1379977515-3794-4-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379977515-3794-4-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Matt Porter <matt@ohporter.com>, Mark Brown <broonie@linaro.org>, Russell King <linux@arm.linux.org.uk>, Dan Williams <djbw@fb.com>, Jyri Sarha <jsarha@ti.com>, Lars Peter-Clausen <lars@metafoo.de>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 23, 2013 at 06:05:15PM -0500, Joel Fernandes wrote:
> davinci-pcm uses 16 as the no.of periods. With this, in EDMA we have to
> allocate atleast 17 slots: 1 slot for channel, and 16 slots the periods.
> 
> Due to this, the MAX_NR_SG limitation causes problems, set it to 20 to make
> cyclic DMA work when davinci-pcm is converted to use DMA Engine. Also add
> a comment clarifying this.

Applied, thanks

--
~Vinod
