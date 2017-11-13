From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3 5/7] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Mon, 13 Nov 2017 16:27:17 +0100
Message-ID: <20171113152717.fj2vgga4gzfr3q2b@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091529.x3pqqvbiywj5aulo@lenoch>
 <3d33265a-2520-2298-6068-f76a7257bfd0@ti.com>
 <20171110100443.zqk7uzxoaq4eyntk@lenoch>
 <20171110152423.GM28152@atomide.com>
 <d498102d-11ff-cdd0-430e-0ea650c2a12b@ti.com>
 <20171113121541.2tlezfjwk5bptakp@lenoch>
 <c13c503c-9435-7e88-7700-40bfcf806231@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <c13c503c-9435-7e88-7700-40bfcf806231@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 13, 2017 at 04:36:41PM +0200, Peter Ujfalusi wrote:
> 
> 
> On 2017-11-13 14:15, Ladislav Michl wrote:
> > On Mon, Nov 13, 2017 at 10:22:12AM +0200, Peter Ujfalusi wrote:
> >>
> >> On 2017-11-10 17:24, Tony Lindgren wrote:
> >>> FYI, the gpio pin for onenand should not be in gpio mode. It should
> >>> be used as external dma request line to automatically trigger new
> >>> transfers like we do for tusb6010 dma. But of course it's possible
> >>> that onenand has other issues too preventing the dma usage.
> >>
> >> My conversion to DMAengine is drop in replacement of the existing
> >> implementation: memcpy w/o hardware synchronization event.
> >>
> >> But I think it should be possible to use HW sync (slave DMA) with the
> >> src/dst_port_window in a similar way we do with the tusb6010.
> > 
> > How do you want to synchronize it from OneNAND side?
> 
> _if_ the pin used as GPIO interrupt has ext DMA request mode then we can
> switch it, in the DT bindings we give the extDMA request as sync event
> and convert the driver: remove GPIO irq handling and have slave DMA
> setup with port_window to do kind of memcpy with HW synchronization.

Well, the pin used as GPIO interrupt has this purpose, according to specs:
"The OneNAND INT pin is an output pin function used to notify the Host when
a command has been completed. This provides a hardware method of signaling
the completion of a program, erase, or load operation".

See for example section 3.9 (and later) of specs:
https://www.abcelectronique.com/composants/telechargement_datasheet.php?id=1089396&part-number=KFH2G16Q2A-DEBx

> It might be possible... It was possible with tusb6010, but that one was
> already using hw sync with the legacy omap-dma API.

Based on above, it seems there's long and hard way :)

> >> But that can be done in a followup series, but what to do in case of old
> >> DT where the dmas/dma-names properties are no there?
> > 
> > These will not work anyway as they do not have compatible property.
> > Also note, that DMA is currently not used, yet nobody complained.
> 
> ;)
> 
> >> Hmm, extending the dma_slave_map in mach-omap1/2/dma.c might work just fine.
> >>
> >> Having said that, there might have been a reason why the original
> >> implementation was not using DMA request to trigger the memcpy... The
> >> legacy omap-dma API would have allowed that as you kind of open code
> >> things with much flexibility.
> > 
> > That's mainly problem of OneNAND driver itself, not oma-dma. But do we
> > really want to invest more time to this obsolete technology?
> > 
> > Of course, I would love to see my 10+ years old boards running faster,
> > but it seems unrealistic to me to get enough manpower to finish this task.
> 
> Valid point. I would - for now - only do the DMAengine memcpy conversion
> with the GPIO irq and investigate the slave DMA support after that.

Here it would be nice to have the same documentation Nokia had at the time
writing support for n8x0 as they clearly used few undocumented features.
Please see section 3.9.5 of above mentioned specs. Seems DMA slave should
be triggered by RDY not INT pin.

Best regards,
	ladis

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
