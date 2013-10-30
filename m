From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/1] Fix OMAP2 NAND ONFI device detection
Date: Wed, 30 Oct 2013 15:14:14 -0400
Message-ID: <20131030191414.GA16668@norris.computersforpeace.net>
References: <1383126788-27426-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:46684 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab3J3TOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Oct 2013 15:14:45 -0400
Received: by mail-oa0-f54.google.com with SMTP id o20so1988142oag.13
        for <linux-omap@vger.kernel.org>; Wed, 30 Oct 2013 12:14:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1383126788-27426-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Pekon Gupta <pekon@ti.com>, marek.belisko@gmail.com

Hi,

On Wed, Oct 30, 2013 at 06:53:07AM -0300, Ezequiel Garcia wrote:
> As it was discussed recently in the mailing list, the omap2-nand driver currently
> has an issue preventing proper ONFI detection of 16-bit devices (other drivers
> may suffer from this same issue).

First of all, thanks for clearly separating this discussion to its own
patch. It is an interesting issue by itself (without tying it up with
other driver-specific issues), and I think it has something useful to
teach other drivers, which may mostly be dodging issues with x16
devices.

> In an attempt to address such issue, this patch uses NAND_BUSWIDTH_AUTO
> (actually discarding any DT property) and leaves the bus width detection
> to the NAND core code.
> 
> This has been tested in a Beaglebone black (AM335x) board with a 16-bit Micron
> NAND device, both ONFI and array-based detections work fine:
> 
> [    1.560945] omap-gpmc 50000000.gpmc: GPMC revision 6.0
> [    1.569328] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xcc (Micron MT29F4G16ABADAH4)
> [    1.577853] NAND device: 512MiB, SLC, page size: 2048, OOB size: 64
> [    1.584448] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme
> [    1.591772] 8 ofpart partitions found on MTD device omap2-nand.0
> [    1.598171] Creating 8 MTD partitions on "omap2-nand.0":
> [    1.603797] 0x000000000000-0x000000020000 : "SPL1"
> [    1.612926] 0x000000020000-0x000000040000 : "SPL2"
> [    1.620112] 0x000000040000-0x000000060000 : "SPL3"
> [    1.627192] 0x000000060000-0x000000080000 : "SPL4"
> [    1.634205] 0x000000080000-0x000000260000 : "U-boot"
> [    1.642708] 0x000000260000-0x000000280000 : "environment"
> [    1.650410] 0x000000280000-0x000000780000 : "Kernel"
> [    1.661828] 0x000000780000-0x000010000000 : "File-System"
> 
> Also, a quick run of nandtest ends successfully:
> 
> # nandtest /dev/mtd6
> ECC corrections: 0
> ECC failures   : 0
> Bad blocks     : 0
> BBT blocks     : 0
> 004e0000: checking...
> Finished pass 1 successfully

I suspected this was the case (in agreement with your comments on
previous threads): that BUSWIDTH_AUTO will discover the correct buswidth
*AND* will handle initial ONFI requests correctly (i.e., initially in x8
"mode", then switching to x16 callbacks as appropriate).

I do have one curiosity here: omap2.c looks like it's essentially
defaulting to the NAND_OMAP_POLLED callbacks during nand_scan_ident(),
since omap2.c only initializes the read_buf callback after
nand_scan_ident(). Is this ever a problem? Or should omap2.c be
initializing its callbacks both before and after nand_scan_ident()
(similar to how nand_base calls nand_set_defaults() twice for the AUTO
case)?

What value do you use for "ti,nand-xfer-type" in your BeagleBone device
tree? Is the xfer type a hardware requirement, or just a software
configuration? IOW, does the hardware care if I simply use POLLED, even
temporarily? (A potential side issue: does "ti,nand-xfer-type" even
belong in the device tree, if it is not actually a hardware property?)

> This time I've decided to submit this patch alone, so we can focus
> the discussion on this issue. The other cleanups can wait.
> 
> AFAICS, the remaining questions are:
> 
>  1. Does this work in the 8-bit case?
>  (I'm not able to test such case for lack of hardware)

I'm not sure, of course, but I don't see why not. It's more likely to
break for x16 than it is for x8.

>  2. Do we want to re-configure the GPMC one the NAND core detects the
>     device bus width?

I'm not quite sure here, as I don't know if I know enough about the GPMC
to give an educated response here. Additionally, I'm not quite sure how
"re-configurable" GPMC really is. It seems like we would be restricted
physically if GPMC is hooked up as x8 for an x16 NAND (there are not
enough pins connected). So even if we detect the NAND, it cannot
function. I'm not sure about the reverse.

Now, this returns me to my rejection of Pekon's patch here:

  http://lists.infradead.org/pipermail/linux-mtd/2013-October/049154.html

(This patch addresses the question of checking the GPMC configuration,
not correcting it.)

I'll admit that I was underinformed regarding the need for this type of
patch. Since that time, I am less sure of my criticism. But really, I
just have more questions now.

Does the GPMC intrinsically (physically; according to its pin
configuration) restrict an attached device (e.g., NAND) to use x16 or
x8? Or does it simply specify a maximum data width that is wired up?
(I'm presuming that you could wire an x8 device to an x16 interface and
just leave the upper 8 unconnected...) Or is there some third option?

The DT entry says:

  gpmc,device-width     Total width of device(s) connected to a GPMC
                        chip-select in bytes. The GPMC supports 8-bit
                        and 16-bit devices and so this property must be
                        1 or 2.

So, this *sounds* like it specifies the exact width. But as I read it,
this property could more optimally be specified as the *maximum*
width...

> Regarding this last question, and as I've exposed in the discussion with Pekon
> about this [1], IMO, doing so is a bad design choice. It's not the NAND
> driver's task to fix illed-prepared device-tree's or a badly configured memory
> controller (GPMC).
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg97760.html

Brian
