From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 03/15] dmaengine: Add no_wakeup
 parameter to dmaengine_prep_dma_cyclic()
Date: Fri, 14 Sep 2012 08:56:57 +0530
Message-ID: <1347593217.1943.26.camel@vkoul-udesk3>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
 <5051FB4D.3000009@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5051FB4D.3000009@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2012-09-13 at 17:27 +0200, Lars-Peter Clausen wrote:
> Hi,
> 
> Hm... Do you think it would work as well if we implement this by
> setting the
> callback for the descriptor to NULL? If the callback is NULL there is
> nothing to at the end of a transfer/period and the dma engine driver
> may
> choose to disable interrupts. This would also benefit non cyclic
> transfers
> where the callback is NULL and we do not need add the new parameter to
> dmaengine_prep_dma_cyclic.
That will work too.... BUT the idea of no_wake mode in ALSA is that we
should not have any interrupts, so anything which is going to cause
interrupts to AP in undesired. The interrupts still happen and it just
that dmaengine driver is not notifying client.


-- 
~Vinod
