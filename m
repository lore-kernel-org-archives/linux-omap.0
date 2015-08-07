From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 19:47:39 +0100
Message-ID: <20150807184739.GX7576@n2100.arm.linux.org.uk>
References: <1438961765-22554-1-git-send-email-bigeasy@linutronix.de>
 <20150807162648.GR7576@n2100.arm.linux.org.uk>
 <20150807175548.GA4163@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150807175548.GA4163@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 07:55:48PM +0200, Sebastian Andrzej Siewior wro=
te:
> /*=20
>  * We do not allow DMA_MEM_TO_DEV transfers to be paused.
>  * From the AM572x TRM, 16.1.4.18 Disabling a Channel During Transfer=
:
>  * "When a channel is disabled during a transfer, the channel undergo=
es
>  * an abort, unless it is hardware-source-synchronized =E2=80=A6".
>  * A source-synchronised channel is one where the fetching of data is
>  * under control of the device. In other words, a device-to-memory
>  * transfer. So, a destination-synchronised channel (which would be a
>  * memory-to-device transfer) undergoes an abort if the the CCR_ENABL=
E
>  * bit is cleared.
>  * From 16.1.4.20.4.6.2 Abort: "If an abort trigger occurs, the chann=
el
>  * aborts immediately after completion of current read/write
>  * transactions and then the FIFO is cleaned up." The term "cleaned u=
p"
>  * is not defined. TI recommends to check that RD_ACTIVE and WR_ACTIV=
E
>  * are both clear _before_ disabling the channel, otherwise data loss
>  * will occur.
>  * The problem is that if the channel is active, then device activity
>  * can result in DMA activity starting between reading those as both
>  * clear and the write to DMA_CCR to clear the enable bit hitting the
>  * hardware. If the DMA hardware can't drain the data in its FIFO to =
the
>  * destination, then data loss "might" occur (say if we write to an U=
ART
>  * and the UART is not accepting any further data).
>  */
>=20
> would that be okay?

Better, if a tad verbose.  I guess no one will miss that. :)

> If I google for it, I find it. pause/resume support for cyclic was ad=
ded
> later without a note why it is only supported for cyclic.

Try searching for the "[PATCH 11/11] ASoC: omap-pcm: Convert to use
dmaengine" thread, which was the initial round of patches converting
omap-pcm to DMA engine, and where there was some discussion of how
to handle it at that time.

The result of that was it was felt that the safest approach was to
limit it to cyclic transfers for ASoC, and to use the method which
had been well proven over previous years/decade on numerous different
OMAP hardware.

It's all entirely sensible given that omap-dma has to cope with many
different hardware revisions with two major hardware versions and
people having limited testing resources for validation.  So you will
understand, given the data loss issues here, why it was decided that
omap-dma will only provide pause/resume support for cases where it
has been proven to work sufficiently well and where data loss is not
that a major issue (if a few samples of audio get lost over a
suspend/resume, it's not going to corrupt your data.)

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
