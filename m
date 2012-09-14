From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 03/15] dmaengine: Add no_wakeup
 parameter to dmaengine_prep_dma_cyclic()
Date: Fri, 14 Sep 2012 15:08:08 +0530
Message-ID: <1347615488.1943.47.camel@vkoul-udesk3>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
 <5051FB4D.3000009@metafoo.de> <1347593217.1943.26.camel@vkoul-udesk3>
 <5052E72A.8040207@metafoo.de> <1347612630.1943.29.camel@vkoul-udesk3>
 <5052F8BC.4020102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5052F8BC.4020102@ti.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 2012-09-14 at 12:28 +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On 09/14/2012 11:50 AM, Vinod Koul wrote:
> >> Well, the idea was that the driver would disable interrupts if there is no
> >> callback to call, since there would be nothing to do in the interrupt
> >> handler anyway. But I guess the flags approach should work fine as well.
> > Yes we _could_ do that, but this relies on dmaengine driver to have this
> > implicit understanding. Anyone using dmaengine library in ASoC may or
> > may not be aware of this, so i would consider it hackish.
> > 
> > Using this flag explicitly makes everyone aware what the intended
> > behaviour is.
> 
> I'm not sure about which flags should ASoC set for the two case we are going
> to have. I think it should be something like this:
> 
> unsigned long flags = DMA_CTRL_ACK;
usage of ACK flag is mostly async_tx thingy, we can skip it for slave.
> 
> if (!substream->runtime->no_period_wakeup)
> 	flags |= DMA_PREP_INTERRUPT;
> I'm not 100% sure of the role of DMA_CTRL_ACK in this case. Or should we only
> handle the DMA_PREP_INTERRUPT flag, like this:
> 
> unsigned long flags = 0;
> 
> if (!substream->runtime->no_period_wakeup)
> 	flags |= DMA_PREP_INTERRUPT;
> 
> 
> What do you think?
Looks fine.

-- 
~Vinod
