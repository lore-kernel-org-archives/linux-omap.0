From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 04/15] dmaengine: Pass no_wakeup
 parameter via device_prep_dma_cyclic() callback
Date: Tue, 18 Sep 2012 14:30:10 +0530
Message-ID: <1347958810.1943.176.camel@vkoul-udesk3>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
 <CACRpkdYAxFzPAZgMsdj9C3YVLzMc_w41Xs0SiqX-1DWaZqxAdw@mail.gmail.com>
 <20120918083146.GE12445@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120918083146.GE12445@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Laxman Dewangan <ldewangan@nvidia.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-arm-kernel@lists.infradead.org, Barry Song <baohua.song@csr.com>, Dan Williams <djbw@fb.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Vista Silicon <javier.martin@vista-silicon.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2012-09-18 at 09:31 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 17, 2012 at 11:01:23AM +0200, Linus Walleij wrote:
> > On Thu, Sep 13, 2012 at 3:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > 
> > > Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
> > > can receive the no_wakeup request coming from client drivers.
> > > This feature can be used during audio operation to disable all audio
> > > related interrupts.
> > >
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > CC: Barry Song <baohua.song@csr.com>
> > > CC: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> > > CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > > CC: Vista Silicon <javier.martin@vista-silicon.com>
> > > CC: Zhangfei Gao <zhangfei.gao@marvell.com>
> > > CC: Shawn Guo <shawn.guo@linaro.org>
> > > CC: Laxman Dewangan <ldewangan@nvidia.com>
> > 
> > After some discussion with clever people I know I have come to the conclusion
> > that this is a good idea, so:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> NAKed-by: me
> 
> If you look at the other sub-threads of the patch you're acking, you'll
> notice that there's a v3 of this patch set which changes the way this is
> done.
Was it a genuine mistake, think v3 reply v2? Or less caffeine..... :)


-- 
~Vinod
