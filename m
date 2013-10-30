From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH 0/1] Fix OMAP2 NAND ONFI device detection
Date: Wed, 30 Oct 2013 21:18:53 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2D41D@DBDE04.ent.ti.com>
References: <1383126788-27426-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131030191414.GA16668@norris.computersforpeace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52366 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784Ab3J3VT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Oct 2013 17:19:26 -0400
In-Reply-To: <20131030191414.GA16668@norris.computersforpeace.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>

Hi Brian, Ezequiel Garcia,

Some replies to your queries...

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> > On Wed, Oct 30, 2013 at 06:53:07AM -0300, Ezequiel Garcia wrote:

[...]

> I do have one curiosity here: omap2.c looks like it's essentially
> defaulting to the NAND_OMAP_POLLED callbacks during nand_scan_ident(),
> since omap2.c only initializes the read_buf callback after
> nand_scan_ident(). Is this ever a problem? Or should omap2.c be
> initializing its callbacks both before and after nand_scan_ident()
> (similar to how nand_base calls nand_set_defaults() twice for the AUTO
> case)?
> 
There is no issue if _default_ functions present in nand_base.c
are used for chip->read_byte() or chip->read_buf() while probing the device.
The different callbacks defined in omap2.c like
- omap_read_buf()
- omap_read_buf_pref()
- omap_read_buf_dma_pref()
- omap_read_buf_irq_pref()
Above are alternatives for having better throughput in different use-cases.
These are not tied to hardware. So it's okay if these callbacks are assigned
post nand_scan_ident().


> What value do you use for "ti,nand-xfer-type" in your BeagleBone device
> tree? Is the xfer type a hardware requirement, or just a software
> configuration? IOW, does the hardware care if I simply use POLLED, even
> temporarily? (A potential side issue: does "ti,nand-xfer-type" even
> belong in the device tree, if it is not actually a hardware property?)
> 
DMA and IRQ based callbacks have better throughput numbers than
POLLED ones. Though its not related to hardware, but as it's there in DT
now so we should maintain it. Also considering that:
- some older platforms might not support xx_dma_pref().
- some related pieces of information (like IRQ number, etc) comes from DT.
It was added as part of following patch..
http://www.spinics.net/lists/linux-omap/msg90250.html


> > This time I've decided to submit this patch alone, so we can focus
> > the discussion on this issue. The other cleanups can wait.
> >
> > AFAICS, the remaining questions are:
> >
> >  1. Does this work in the 8-bit case?
> >  (I'm not able to test such case for lack of hardware)
> 
> I'm not sure, of course, but I don't see why not. It's more likely to
> break for x16 than it is for x8.
> 
Another question here is ..
The above patch assumes that user has configured GPMC bus-width
correctly, so if user is already providing GPMC bus-width information
via DT, then do we really need to detect NAND device bus-width again
using NAND_BUSWIDTH_AUTO ?
 

> >  2. Do we want to re-configure the GPMC one the NAND core detects the
> >     device bus width?
> 
> I'm not quite sure here, as I don't know if I know enough about the GPMC
> to give an educated response here. Additionally, I'm not quite sure how
> "re-configurable" GPMC really is. It seems like we would be restricted
> physically if GPMC is hooked up as x8 for an x16 NAND (there are not
> enough pins connected). So even if we detect the NAND, it cannot
> function. I'm not sure about the reverse.
> 
> Now, this returns me to my rejection of Pekon's patch here:
> 
>   http://lists.infradead.org/pipermail/linux-mtd/2013-October/049154.html
> 
> (This patch addresses the question of checking the GPMC configuration,
> not correcting it.)
> 
> I'll admit that I was underinformed regarding the need for this type of
> patch. Since that time, I am less sure of my criticism. But really, I
> just have more questions now.
> 
> Does the GPMC intrinsically (physically; according to its pin
> configuration) restrict an attached device (e.g., NAND) to use x16 or
> x8?
Yes.. 

>  Or does it simply specify a maximum data width that is wired up?
> (I'm presuming that you could wire an x8 device to an x16 interface and
> just leave the upper 8 unconnected...) Or is there some third option?
> 
GPMC engine uses bus-width info to drive its data-lines.
- If GPMC is configured as x8, then it will only perform I/O on D0.. D7,
   even if all D0 .. D15 were wired on board.
- If GPMC is configured as x16, then it will perform I/O on D0.. D15,
   even if only D0 .. D7 were wired on board. There by reading 0x0 or
   garbage on D8 .. D15 lines.

This does not affect the probe, because chip->read_byte() would return
only single byte whether it's a x8 device or x16 device. So READID_CMD
works fine and you can read maf_id and dev_id. And based on that
device parameters can be looked from nand_flash_id[].
However when it comes to reading or writing complete page, then the
mismatch between GPMC configuration and actual NAND device
bus-width is seen, because there chip->read_buf() or chip->write_buf()
is used.


> The DT entry says:
> 
>   gpmc,device-width     Total width of device(s) connected to a GPMC
>                         chip-select in bytes. The GPMC supports 8-bit
>                         and 16-bit devices and so this property must be
>                         1 or 2.
> 
> So, this *sounds* like it specifies the exact width. But as I read it,
> this property could more optimally be specified as the *maximum*
> width...
> 
Yes, its exact width..


> > Regarding this last question, and as I've exposed in the discussion with
> Pekon
> > about this [1], IMO, doing so is a bad design choice. It's not the NAND
> > driver's task to fix illed-prepared device-tree's or a badly configured
> memory
> > controller (GPMC).
> >
> > [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg97760.html
> 
> Brian


with regards, pekon
