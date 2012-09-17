From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 04/15] dmaengine: Pass no_wakeup
 parameter via device_prep_dma_cyclic() callback
Date: Mon, 17 Sep 2012 14:34:53 +0800
Message-ID: <20120917063451.GB6413@S2101-09.ap.freescale.net>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Laxman Dewangan <ldewangan@nvidia.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-arm-kernel@lists.infradead.org, Barry Song <baohua.song@csr.com>, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Vista Silicon <javier.martin@vista-silicon.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 13, 2012 at 04:37:54PM +0300, Peter Ujfalusi wrote:
> Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
> can receive the no_wakeup request coming from client drivers.
> This feature can be used during audio operation to disable all audio
> related interrupts.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Barry Song <baohua.song@csr.com>
> CC: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
> CC: Vista Silicon <javier.martin@vista-silicon.com>
> CC: Zhangfei Gao <zhangfei.gao@marvell.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/dma/at_hdmac.c        | 3 ++-
>  drivers/dma/ep93xx_dma.c      | 4 +++-
>  drivers/dma/imx-dma.c         | 2 +-
>  drivers/dma/imx-sdma.c        | 2 +-
>  drivers/dma/mmp_tdma.c        | 2 +-
>  drivers/dma/mxs-dma.c         | 2 +-
>  drivers/dma/omap-dma.c        | 3 ++-
>  drivers/dma/pl330.c           | 2 +-
>  drivers/dma/sa11x0-dma.c      | 2 +-
>  drivers/dma/sirf-dma.c        | 2 +-
>  drivers/dma/ste_dma40.c       | 3 ++-
>  drivers/dma/tegra20-apb-dma.c | 2 +-
>  include/linux/dmaengine.h     | 5 +++--
>  13 files changed, 20 insertions(+), 14 deletions(-)
> 
API changes without updating users?

Regards,
Shawn
