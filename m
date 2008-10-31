From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/4] 34xx spurious interrupts unravelling
Date: Fri, 31 Oct 2008 14:59:04 -0700
Message-ID: <200810311459.04687.david-b@pacbell.net>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <200810311307.15154.david-b@pacbell.net> <20081031203529.GB28924@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:21841 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752222AbYJaV7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2008 17:59:08 -0400
In-Reply-To: <20081031203529.GB28924@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Friday 31 October 2008, Tony Lindgren wrote:
>=20
> > For PIO drivers, IRQ handling is the main place these races
> > will appear. =A0If DMA is in use, there are a boatload of
> > additional complications that can crop up ... sometimes you
> > need to worry about when writes get to memory (DMA mapping
> > ops don't necessarily ensure the CPU write buffer is empty),
> > and unless the peripheral has an integrated DMA engine you
> > need to flush writes to the DMA engine separately from
> > writes to the peripheral.
>=20
> Yeah, especially when recycling dma buffers.. The call to use
> there is dma_cache_maint().

Well, not directly ... call dma_map_*() and dma_sync_*(),
letting those functions call dma_cache_maint() as needed.
(See arch/arm/include/asm/dma-mapping.h ...)

That said, I have seen platforms where the fact that those
calls can leave data in the CPU write buffer made trouble.

As in, issue those dma cache updates, then write to the
DMA or peripheral controller registers ... and the key data
was still in the write buffers when those writes completed!
That's quite unusual; possibly related to memory controller
bugs in that silicon revision.


(And there are converse problems in drivers that collect
status from both DMA buffers/descriptors and from peripheral
registers.  Status can show up in registers before memory
because of buffering on those paths, and vice versa.  The
varying clock rates matter ... maybe the memory writes are
synced to a 166 MHz clock, but the peripheral internally
uses a 48 MHz clock domain.)

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
