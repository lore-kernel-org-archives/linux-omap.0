From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 04/15] dmaengine: Pass no_wakeup
 parameter via device_prep_dma_cyclic() callback
Date: Fri, 14 Sep 2012 08:54:00 +0530
Message-ID: <1347593040.1943.24.camel@vkoul-udesk3>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Laxman Dewangan <ldewangan@nvidia.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-arm-kernel@lists.infradead.org, Barry Song <baohua.song@csr.com>, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Vista Silicon <javier.martin@vista-silicon.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2012-09-13 at 16:37 +0300, Peter Ujfalusi wrote:
> Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
> can receive the no_wakeup request coming from client drivers.
> This feature can be used during audio operation to disable all audio
> related interrupts.
We already have a flag to indicate this, see 
* @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion  of
*  this transaction

Unfortunately, the addition of cyclic API missed having this flag. So
right way would be to add flag argument in the API.

-- 
~Vinod
