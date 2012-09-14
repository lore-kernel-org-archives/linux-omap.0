From: Vinod Koul <vkoul@infradead.org>
Subject: Re: [PATCH v2 03/15] dmaengine: Add no_wakeup
 parameter to dmaengine_prep_dma_cyclic()
Date: Fri, 14 Sep 2012 08:57:59 +0530
Message-ID: <1347593279.1943.27.camel@vkoul-udesk3>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
 <5051FB4D.3000009@metafoo.de>
 <20120913153824.GK28448@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120913153824.GK28448@n2100.arm.linux.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, vinod.koul@intel.com, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Dan Williams <djbw@fb.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2012-09-13 at 16:38 +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 13, 2012 at 05:27:09PM +0200, Lars-Peter Clausen wrote:
> > Hm... Do you think it would work as well if we implement this by setting the
> > callback for the descriptor to NULL? If the callback is NULL there is
> > nothing to at the end of a transfer/period and the dma engine driver may
> > choose to disable interrupts. This would also benefit non cyclic transfers
> > where the callback is NULL and we do not need add the new parameter to
> > dmaengine_prep_dma_cyclic.
> 
> Actually, there's a way to do that already.  DMA_PREP_INTERRUPT.
> Unfortunately, most DMA engine slave API users don't set it when they
> setup their transfer:
> 
>  * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion of
>  *  this transaction
Looks like I have repeated the correct action!
> 
> if we fixed that, then we could use the lack of it to avoid the interrupt.
> 
> However, cyclic transfers don't have the flags parameter used to pass this
> bit.  Yet another bit of yucky inconsistent design in DMA engine land...
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
