From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to handle named resources with DT?
Date: Sun, 28 Aug 2011 17:06:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108281100150.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca> <201108261741.29850.arnd@arndb.de> <20110827143736.GA10182@yookeroo.fritz.box> <5595208.OB5dBohxQP@wuerfel> <20110828083934.GA4254@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42757 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1H1XGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Aug 2011 19:06:45 -0400
In-Reply-To: <20110828083934.GA4254@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, 28 Aug 2011, David Gibson wrote:

> I've never been very clear on what exactly DMA resources cover,

DMA resource data are usually DMA request line ID numbers.

DMA request lines are dedicated, unidirectional hardware signals from I/O 
devices to one or more independent DMA controllers[1][2][3].  Request 
lines indicate when the device is ready to accept data from the DMA 
controller, or, when the device has data ready for the DMA controller to 
fetch.  On a given DMA controller, each request line has its own unique ID 
number[4][5][6].

During a DMA transfer, the I/O device asserts or deasserts its DMA request 
lines as its FIFOs fill or drain[7][8].  This will pause or resume the DMA 
transfer, if the DMA controller is programmed with the correct DMA request 
line IDs[9][10][11][12].  In a hardware-synchronized DMA transfer, the DMA 
controller must be controlled by the device because it is not good to read 
from an empty device FIFO, or to write to a full device FIFO.  There 
aren't many sane courses of action in those circumstances with most 
interconnects and DMA controllers.

So in terms of Linux kernel code, the driver needs the DMA request line ID 
numbers so it and the DMA code can program the DMA controller to 
synchronize DMA transfers with the I/O device(s).

Like hardware IRQ IDs, these DMA request line IDs are properties of a DMA 
controller itself, but are associated with individual I/O devices.  And 
like IRQ IDs, these DMA request line ID mappings may change from chip 
version to chip version[13], even for the same IP block.  So it is useful 
for device data formats to provide DMA request line IDs dynamically.

Several upstream device drivers get their DMA request line IDs from the 
device data format[14][15][16].  But more drivers should be doing this 
than currently are[17]:

- the device driver author may have hardcoded the DMA request line ID, 
  assuming it would never change

- DMA could be broken on the device due to hardware bugs, so it is unused

- the driver author may just never have gotten around to implementing DMA, 
  or was reassigned to another project, or couldn't figure it out

- the device may have its own internal DMA controller logic, so support 
  for an external DMA controller was simply never added

When looking at a driver, it may not be obvious which of the cases 
apply.

(N.B., I/O device IP blocks that contain their own dedicated DMA 
controllers that are specialized to transfer only to memory don't need DMA 
request lines.)


- Paul


All code citations below are of Linux v3.1-rc3.

1. A DMA controller's view of DMA request lines.  Figure 9-4, "SDMA 
   Controller Integration".  _OMAP34xx Multimedia Device Silicon Revision 
   3.1.x Version R (SWPU223R)_ (public version).
   http://focus.ti.com/pdfs/wtbu/OMAP34xx_ES3.1.x_PUBLIC_TRM_vZR.zip

2. A simple device's view of DMA request lines, only connected to one
   DMA controller.  Figure 22-17, "MMC/SD/SDIO1 Integration". _OMAP34xx 
   Multimedia Device Silicon Revision 3.1.x Version R (SWPU223R)_ (public 
   version).
   http://focus.ti.com/pdfs/wtbu/OMAP34xx_ES3.1.x_PUBLIC_TRM_vZR.zip

3. A device's view of its DMA request lines connected to two separate DMA
   controllers, and thus with distinct numbering.  Note also that the 
   device refers to its signals with strings, while the DMA controllers
   refer to the same signals with ID numbers.  Figure 21-16, "McBSP1 
   Integration". _OMAP34xx Multimedia Device Silicon Revision 3.1.x 
   Version R (SWPU223R)_ (public version).
   http://focus.ti.com/pdfs/wtbu/OMAP34xx_ES3.1.x_PUBLIC_TRM_vZR.zip

4. Table 5-1 "Peripheral Addresses and Selectors". _RMI Alchemy Au1550 
   Security Network Processor Data Book Revision E_.  May 2007.
   Available from 
   http://www.poeticmonkey.com/ebay/semiconductors/cpus/au1550/au1550_db_0507e.pdf

5. Table 6-7 "Priority and Default Mapping of Peripheral to DMA". 
   _ADSP-BF51x Blackfin Processor Hardware Reference Preliminary Revision 
   0.1_ (January 2009).  Available from 
   http://www.analog.com/static/imported-files/processor_manuals/bf51x_hwr_rev_0-1.pdf

6. Table 16-5 "sDMA Controller Request Mapping". _OMAP4460 Multimedia 
   Device Silicon Revision 1.x Version H (Public Version) (SWPU235H)_.
   Available from 
   http://focus.ti.com/pdfs/wtbu/OMAP4460_ES1.x_PUBLIC_TRM_vH.zip

7. A really nice illustration of the interaction between a FIFO and
   DMA request line during DMA receive.  Figure 17-25
   "Receive FIFO DMA Request Generation (32 Characters)".  _OMAP34xx 
   Multimedia Device Silicon Revision 3.1.x Version R (SWPU223R)_ (public 
   version).
   http://focus.ti.com/pdfs/wtbu/OMAP34xx_ES3.1.x_PUBLIC_TRM_vZR.zip

8. A similarly good illustration of the interaction between a FIFO and 
   DMA request line during DMA transmit.  Figure 17-26
   "Transmit FIFO DMA Request Generation (56 Spaces)".  _OMAP34xx
   Multimedia Device Silicon Revision 3.1.x Version R (SWPU223R)_ (public 
   version).
   http://focus.ti.com/pdfs/wtbu/OMAP34xx_ES3.1.x_PUBLIC_TRM_vZR.zip

9. Table 3-23 "DMACCxConfiguration Register bit assignments".  _PrimeCell 
   DMA Controller (PL080) Technical Reference Manual (DDI0196G)_.
   http://infocenter.arm.com/help/topic/com.arm.doc.ddi0196g/DDI0196.pdf

10. Section 16.4.9.2 "Hardware Synchronization".  _OMAP4460 Multimedia
    Device Silicon Revision 1.x Version H (Public Version) (SWPU235H)_.
    Available from
    http://focus.ti.com/pdfs/wtbu/OMAP4460_ES1.x_PUBLIC_TRM_vH.zip

11. Page 6-5 "Peripheral DMA". _ADSP-BF51x Blackfin Processor Hardware 
    Reference Preliminary Revision 0.1_ (January 2009).  Available from   
    http://www.analog.com/static/imported-files/processor_manuals/bf51x_hwr_rev_0-1.pdf

12. Section 5.3.1.1 "Command 0". _RMI Alchemy Au1550
    Security Network Processor Data Book Revision E_.  May 2007.
    Available from
    http://www.poeticmonkey.com/ebay/semiconductors/cpus/au1550/au1550_db_0507e.pdf

13. For example, consider what happens to the EXT_DMAREQ3 request line ID
    on the SDMA controller:
    ... from the OMAP2420:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/dma.h;h=dc562a5c0a8ad2c7117b0b02e43b85cabe7b9aa5;hb=c11a7e26f8ee60bda0e64983291113ce5d04df55#l113
    ... to the OMAP2430:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/dma.h;h=dc562a5c0a8ad2c7117b0b02e43b85cabe7b9aa5;hb=c11a7e26f8ee60bda0e64983291113ce5d04df55#l125
    ... to the OMAP3430:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/dma.h;h=dc562a5c0a8ad2c7117b0b02e43b85cabe7b9aa5;hb=c11a7e26f8ee60bda0e64983291113ce5d04df55#l179

14. An OMAP2+ driver example is: drivers/tty/serial/omap-serial.c lines 
    1249 and 1255:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/tty/serial/omap-serial.c#l1249

15. An Alchemy AU1xxx example is: sound/soc/au1x/dbdma2.c lines 173 and 
    177:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=sound/soc/au1x/dbdma2.c#l173

16. A Blackfin BF51x example is: drivers/spi/spi-bfin5xx.c line 1323:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/spi/spi-bfin5xx.c#l1323

17. First Law of Kernel Hacking: the bodies are always buried in the 
    device driver code.

