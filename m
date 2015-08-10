From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause
 is not supported
Date: Mon, 10 Aug 2015 09:00:29 -0400
Message-ID: <55C8A06D.20309@hurleysoftware.com>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de> <1438977619-15488-2-git-send-email-bigeasy@linutronix.de> <55C890E2.50208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C890E2.50208@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

On 08/10/2015 07:54 AM, Peter Ujfalusi wrote:
> On 08/07/2015 11:00 PM, Sebastian Andrzej Siewior wrote:

> I don't think this is good thing for the stable _and_ for the mainline at the
> same time:
> in stable the rx DMA should not be allowed since the stable kernels does not
> allow pause/resume with omap-dma, so there the rx DMA should be just disabled
> for UART. This change will cause regression since it introduce a WARN_ON_ONCE,
> which will be printed if the user tries to use non working feature.
> 
> In mainline you will eventually going to have pause/resume support so this
> patch will make no sense there.

No, the whole point of this mess is that omap-dma does not provide pause/resume
support (without data loss). omap-dma will only be suitable for pause/terminate dma.

And adding pause support doesn't address the underlying problem that dmaengine
is not providing a means of determining if suitable support is available for
use by serial drivers, so this same problem is just waiting to happen again.

I think the way forward is,

For -stable, disable dma in the 8250_omap driver.
Then for mainline,
* extend the dma_get_slave_caps() api to differentiate the types of pause support
* query dma_get_slave_caps() when setting up the slave channel in 8250_dma & 8250_omap
  and only enable dma if suitable pause support is available
* add required dmaengine error checking in 8250_dma & 8250_omap _for unexpected errors_
  (so _not_ WARNs)
* do whatever with omap-dma. Not even sure it's worth trying to support dma with that;
  it still won't fully support tx dma which is forcing all kinds of goofy workarounds


Russell seemed to think that the current dma operation was necessary information to
differentiate types of pause support, but I don't think that's required.
As Sebastian's omap-dma driver patch shows, partial pause support has more
to do with how it's being used.

Regards,
Peter Hurley
