From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Mon, 17 Dec 2007 17:05:56 -0800
Message-ID: <20071218010556.GX7388@atomide.com>
References: <5573C19A4BBDB441BED2A44157E9705302A4C387@dlee12.ent.ti.com>
	<200711231226.44592.david-b@pacbell.net>
	<5573C19A4BBDB441BED2A44157E9705302C29F01@dlee12.ent.ti.com>
	<200712092134.23712.david-b@pacbell.net>
	<5573C19A4BBDB441BED2A44157E9705302D6E61F@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5573C19A4BBDB441BED2A44157E9705302D6E61F@dlee12.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hunter, Jon <jon-hunter@ti.com> [071217 16:01]:
> > There what's odd is that nothing seems to have emptied the
> > FIFO.  I've not looked at the Mentor DMA engine, but I'd kind
> > of hope that it's more sane than CPPI ... so that one could
> > let it offload entire IEEE 802 packets without needing to
> > wake up the CPU after each packet.
> 
> 
> I do see from the driver that the Mentor DMA engine appears to have two
> modes of operation, namely mode 0 and mode 1. When the DMA is configured
> for Mode 0 then the DMA will only load/unload one packet at a time and
> so the CPU will be interrupted for each packet. Whereas in Mode 1 the
> DMA can load/unload all packets of the entire transfer. On the TX side
> it appears to use Mode 1 and on the RX side it uses Mode 0. I did find
> the following comment in the musb_gadget.c file:
> 
> /* We use DMA Req mode 0 in rx_csr, and DMA controller operates in
>  * mode 0 only. So we do not get endpoint interrupts due to DMA
>  * completion. We only get interrupts from DMA controller.
>  *
>  * We could operate in DMA mode 1 if we knew the size of the tranfer
>  * in advance. For mass storage class, request->length = what the host
>  * sends, so that'd work.  But for pretty much everything else,
>  * request->length is routinely more than what the host sends. For
>  * most these gadgets, end of is signified either by a short packet,
>  * or filling the last byte of the buffer.  (Sending extra data in
>  * that last pckate should trigger an overflow fault.)  But in mode 1,
>  * we don't get DMA completion interrrupt for short packets.
>  *
>  * Theoretically, we could enable DMAReq irq (MUSB_RXCSR_DMAMODE = 1),
>  * to get endpoint interrupt on every DMA req, but that didn't seem
>  * to work reliably.
>  *
>  * REVISIT an updated g_file_storage can set req->short_not_ok, which
>  * then becomes usable as a runtime "use mode 1" hint...
>  */
> 
> >From digging into this more, when the failure condition occurs, I see
> that the DMA channels for both RX and TX are configured and enabled. The
> strange thing is that neither DMA completes and so the driver is stuck
> waiting for an interrupt from both the RX and the TX side. The DMA
> registers do show that the DMA channels are configured to generate an
> interrupt but the INTR (interrupt status register) for DMA controller
> never shows an interrupt pending for either the RX or TX channel. It
> seems that the DMA is setup correctly but never transfer the data. 

The musb driver should be fixed to allow using mode 1 based on the fifo
interrupt. I never had much luck with mode 1 though on tusb :(

Tony
