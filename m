From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Thu, 2 Mar 2017 20:49:00 +0100
Message-ID: <20170302204900.2ab4bf65@bbrezillon>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-3-vigneshr@ti.com>
 <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
 <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
 <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
 <20170301175506.202cb478@bbrezillon>
 <09ffe06d-565d-afe8-8b7d-d1a0b575595b@baylibre.com>
 <4cd22ddd-b108-f697-0bde-ad844a386e62@ti.com>
 <20170302152921.1c031b57@bbrezillon>
 <20170302170041.hfix33mhzgqydmvh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170302170041.hfix33mhzgqydmvh@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Frode Isaksen <fisaksen@baylibre.com>, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2 Mar 2017 17:00:41 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 02, 2017 at 03:29:21PM +0100, Boris Brezillon wrote:
> > Vignesh R <vigneshr@ti.com> wrote:  
> 
> > > Or SPI core can be extended in a way similar to this RFC. That is, SPI
> > > master driver will set a flag to request SPI core to use of bounce
> > > buffer for vmalloc'd buffers. And spi_map_buf() just uses bounce buffer
> > > in case buf does not belong to kmalloc region based on the flag.  
> 
> > That's a better approach IMHO. Note that the decision should not only  
> 
> I don't understand how the driver is supposed to tell if it might need a
> bounce buffer due to where the memory is allocated and the caches used
> by the particular system it is used on?

That's true, but if the SPI controller driver can't decide that, how
could a SPI device driver guess?

We could patch dma_map_sg() to create a bounce buffer when it's given a
vmalloc-ed buffer and we are running on a system using VIVT or VIPT
caches (it's already allocating bounce buffers when the peripheral
device cannot access the memory region, so why not in this case).

This still leaves 2 problems:
1/ for big transfers, dynamically allocating a bounce buffer on demand
   (and freeing it after the DMA operation) might fail, or might induce
   some latency, especially when the system is under high mem pressure.
   Allocating these bounce buffers once during the SPI device driver
   ->probe() guarantees that the bounce buffer will always be available
   when needed, but OTOH, we don't know if it's really needed.
2/ only the SPI and/or DMA engine know when using DMA with a bounce
   buffer is better than using PIO mode. The limit is probably
   different from the DMA vs PIO mode (dma_min_len <
   dma_bounce_min_len). Thanks to ->can_dma() we can let drivers decide
   when preparing the buffer for a DMA transfer is needed.
3/ if the DMA engine does not support chaining DMA descriptor, and the
   vmalloc-ed buffer spans several non-contiguous pages, doing DMA
   is simply not possible. That one can probably handled with the
   ->can_dma() hook too.

>  The suggestion to pass via
> scatterlists seems a bit more likely to work but even then I'm not clear
> that drivers doing PIO would play well.

You mean that SPI device drivers would directly pass an sg list instead
of a virtual pointer? Not sure that would help, we're just moving the
decision one level up without providing more information to help decide
what to do.

> 
> > be based on the buffer type, but also on the transfer length and/or
> > whether the controller supports transferring non physically contiguous
> > buffers.  
> 
> The reason most drivers only look at the transfer length when deciding
> that they can DMA is that most controllers are paired with DMA
> controllers that are sensibly implemented, the only factor they're
> selecting on is the copybreak for performance.

Of course, the checks I mentioned (especially the physically contiguous
one) are SPI controller and/or DMA engine dependent. Some of them might
be irrelevant.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
