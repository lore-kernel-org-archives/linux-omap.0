From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 04/15] dmaengine: Pass no_wakeup
 parameter via device_prep_dma_cyclic() callback
Date: Mon, 17 Sep 2012 11:01:23 +0200
Message-ID: <CACRpkdYAxFzPAZgMsdj9C3YVLzMc_w41Xs0SiqX-1DWaZqxAdw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Laxman Dewangan <ldewangan@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Liam Girdwood <lrg@ti.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Barry Song <baohua.song@csr.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Vista Silicon <javier.martin@vista-silicon.com>, Dan Williams <djbw@fb.com>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 13, 2012 at 3:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

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

After some discussion with clever people I know I have come to the conclusion
that this is a good idea, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
