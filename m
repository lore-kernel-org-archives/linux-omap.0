From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 03/15] dmaengine: Add no_wakeup
	parameter to dmaengine_prep_dma_cyclic()
Date: Fri, 14 Sep 2012 10:15:05 +0300
Message-ID: <5052D979.3030901@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
 <5051FB4D.3000009@metafoo.de> <20120913153824.GK28448@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 09/13/2012 06:38 PM, Russell King - ARM Linux wrote:
> On Thu, Sep 13, 2012 at 05:27:09PM +0200, Lars-Peter Clausen wrote:
>> Hm... Do you think it would work as well if we implement this by setting=
 the
>> callback for the descriptor to NULL? If the callback is NULL there is
>> nothing to at the end of a transfer/period and the dma engine driver may
>> choose to disable interrupts. This would also benefit non cyclic transfe=
rs
>> where the callback is NULL and we do not need add the new parameter to
>> dmaengine_prep_dma_cyclic.
> =

> Actually, there's a way to do that already.  DMA_PREP_INTERRUPT.
> Unfortunately, most DMA engine slave API users don't set it when they
> setup their transfer:
> =

>  * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion =
of
>  *  this transaction

As I mentioned already to Vinod: the description of this flag is close enou=
gh
for our needs (other than the notion of 'this transaction' is not really
correct for cyclic mode).
I will resend the series to add the flags as new parameter instead of the
no_wakeup.

> =

> if we fixed that, then we could use the lack of it to avoid the interrupt.
> =

> However, cyclic transfers don't have the flags parameter used to pass this
> bit.  Yet another bit of yucky inconsistent design in DMA engine land...
> =



-- =

P=E9ter
