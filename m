From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 19:55:48 +0200
Message-ID: <20150807175548.GA4163@linutronix.de>
References: <1438961765-22554-1-git-send-email-bigeasy@linutronix.de>
 <20150807162648.GR7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150807162648.GR7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux | 2015-08-07 17:26:48 [+0100]:

>On Fri, Aug 07, 2015 at 05:36:05PM +0200, Sebastian Andrzej Siewior wr=
ote:
>> +		/*
>> +		 * We do not allow DMA_MEM_TO_DEV transfers to be paused.
>> +		 * According to RMK the OMAP hardware might prefetch bytes from
>> +		 * memory into its FIFO and not send it to the device due to the
>> +		 * pause. The bytes in the FIFO are cleared on pause. It is
>> +		 * unspecified by how many bytes the source address is updated
>> +		 * if at all.
>
>Would you mind rewording the above.
>
>Please take the time to read the manuals for the device you are playin=
g
>with.  It's mostly documented in there.  See the OMAP4430 ES2.x TRM,
>16.4.18 and 16.4.19.

I didn't connect the dots that well. Thank you.

=E2=80=A6

I updated the comment to:

/*=20
 * We do not allow DMA_MEM_TO_DEV transfers to be paused.
 * From the AM572x TRM, 16.1.4.18 Disabling a Channel During Transfer:
 * "When a channel is disabled during a transfer, the channel undergoes
 * an abort, unless it is hardware-source-synchronized =E2=80=A6".
 * A source-synchronised channel is one where the fetching of data is
 * under control of the device. In other words, a device-to-memory
 * transfer. So, a destination-synchronised channel (which would be a
 * memory-to-device transfer) undergoes an abort if the the CCR_ENABLE
 * bit is cleared.
 * From 16.1.4.20.4.6.2 Abort: "If an abort trigger occurs, the channel
 * aborts immediately after completion of current read/write
 * transactions and then the FIFO is cleaned up." The term "cleaned up"
 * is not defined. TI recommends to check that RD_ACTIVE and WR_ACTIVE
 * are both clear _before_ disabling the channel, otherwise data loss
 * will occur.
 * The problem is that if the channel is active, then device activity
 * can result in DMA activity starting between reading those as both
 * clear and the write to DMA_CCR to clear the enable bit hitting the
 * hardware. If the DMA hardware can't drain the data in its FIFO to th=
e
 * destination, then data loss "might" occur (say if we write to an UAR=
T
 * and the UART is not accepting any further data).
 */

would that be okay?

>Due to this, the OMAP DMA engine driver was submitted with this in the
>cover note:
>
>"For the OMAP DMAengine driver, there's a few short-comings:
>
>1. pause/resume support is not implemented; it's not clear whether the
>   OMAP hardware is capable of supporting this sanely."

If I google for it, I find it. pause/resume support for cyclic was adde=
d
later without a note why it is only supported for cyclic.

Sebastian
