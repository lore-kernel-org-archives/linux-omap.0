From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: MMC/SD cards hotplug scenario
Date: Thu, 22 May 2008 19:10:10 +0530
Message-ID: <005f01c8bc11$5d12d3c0$828918ac@ent.ti.com>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com> <20080521073017.GB23427@flint.arm.linux.org.uk> <005d01c8bb25$63345fe0$538918ac@ent.ti.com> <20080521203202.6d84a02b@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0060_01C8BC3F.76CB0FC0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:49515 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935145AbYEVNkq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 May 2008 09:40:46 -0400
In-Reply-To: <20080521203202.6d84a02b@mjolnir.drzeus.cx>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Pierre Ossman' <drzeus@drzeus.cx>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

This is a multi-part message in MIME format.

------=_NextPart_000_0060_01C8BC3F.76CB0FC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

> -----Original Message-----
> From: Pierre Ossman [mailto:drzeus@drzeus.cx] 
> Sent: Thursday, May 22, 2008 12:02 AM
> To: Madhusudhan Chikkature Rajashekar
> Cc: 'Russell King - ARM Linux'; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.arm.linux.org.uk
> Subject: Re: MMC/SD cards hotplug scenario
> 
> On Wed, 21 May 2008 15:01:00 +0530
> "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com> wrote:
> 
> > What I meant here is that reinsertion of the card does not 
> seem to result in reinitialization of the card consistently.
> 
> Previously, that has always been because of bad interactions with the
> block layer. 2.6.24 should be more resilient though.
> 
> > 
> > Details of few things I noticed is listed below stepwise 
> and to start with card is detected and mounted on mount point 
> /mnt/mmc dir.
> > 
> > 1. Start copy of data.
> > 2. Removed the card in the middle of transfer. At the 
> controller driver level this generated card removed interrupt. The
> > mmc_detect_change fn called.
> > 3. I/O Errors generated.
> 
> The obscene amount of noise here seems to be caused by ext2 being
> extremely persistent. This is generally a good thing for your data
> though. :)
> 
> What is missing is a decent way for a block device to tell the upper
> layers that is gone with no hope of ever coming back. Right 
> now we just
> tell it that there was a write error, which just makes the 
> upper layers
> retry and retry.
> 
> > 4. Reinsert the card. This generated card inserted 
> interrupt. The mmc_detect_fn called. But the card does not seem to be
> > reinitialized correctly.
> >    cat /proc/partitions does not list mmc partitions.
> > 
> 
> Anything in dmesg?
> 
> > 
> > So my question is for the above scenario does the MMC/SD 
> core need to take care of anything explicitely or should this 
> be fixed at
> > the controller
> > driver level?
> 
> Host drivers shouldn't have to bother with any of this for the simple
> reason that there should be no state inside the driver except for the
> current request. Keeping track of cards and block devices are handled
> in the core and mmc_block respectively.
> 
> Rgds
> Pierre
> 

Hi Pierre,

Thanks for the answers.

I am attaching the output of dmesg. I captured dmesg output after I get to the error phrase.
I enabled MMC debugging as well to get some idea. It looks like upon reinsertion of the SD card,
no commands are issued after CMD51. It might be the case where CMD51 (SD_APP_SEND_SCR) fails to read
the SCR for some reason in this scenario.

Regards,
Madhu

------=_NextPart_000_0060_01C8BC3F.76CB0FC0
Content-Type: text/plain;
	name="SDCard-Dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="SDCard-Dmesg.txt"

dmesg
ode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
printk: 142 messages suppressed.
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode bitmap - block_group = 6, inode_bitmap = 196609
printk: 12 messages suppressed.
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode block - inode=93153, block=196611
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode block - inode=93121, block=196610

 MMC Card Inserted........ 
mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmci-omap mmci-omap.1: mmc0: CMD0, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc0: starting CMD8 arg 000001aa flags 000002f5
mmci-omap mmci-omap.1: mmc0: CMD8, argument 0x000001aa
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
mmc0: starting CMD5 arg 00000000 flags 000002e1
mmci-omap mmci-omap.1: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 18000
mmc0: req failed (CMD5): -110, retrying...
mmci-omap mmci-omap.1: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 18000
mmc0: req failed (CMD5): -110, retrying...
mmci-omap mmci-omap.1: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 18000
mmc0: req failed (CMD5): -110, retrying...
mmci-omap mmci-omap.1: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 18000
mmc0: req done (CMD5): -110: 000001aa 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap mmci-omap.1: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD55): 0: 00400120 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
mmci-omap mmci-omap.1: mmc0: CMD41, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmci-omap mmci-omap.1: mmc0: CMD0, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
mmc0: starting CMD8 arg 000001aa flags 000002f5
mmci-omap mmci-omap.1: mmc0: CMD8, argument 0x000001aa
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap mmci-omap.1: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
mmc0: starting CMD41 arg 40300000 flags 000000e1
mmci-omap mmci-omap.1: mmc0: CMD41, argument 0x40300000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap mmci-omap.1: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
mmc0: starting CMD41 arg 40300000 flags 000000e1
mmci-omap mmci-omap.1: mmc0: CMD41, argument 0x40300000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap mmci-omap.1: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
mmc0: starting CMD41 arg 40300000 flags 000000e1
mmci-omap mmci-omap.1: mmc0: CMD41, argument 0x40300000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD41): 0: 80ff8000 00000000 00000000 00000000
mmc0: starting CMD2 arg 00000000 flags 00000067
mmci-omap mmci-omap.1: mmc0: CMD2, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD2): 0: 03534453 55303147 800008e1 b7006cad
mmc0: starting CMD3 arg 00000000 flags 00000075
mmci-omap mmci-omap.1: mmc0: CMD3, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD3): 0: 981b0520 00000000 00000000 00000000
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
mmc0: starting CMD9 arg 981b0000 flags 00000007
mmci-omap mmci-omap.1: mmc0: CMD9, argument 0x981b0000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD9): 0: 00260032 5f5983c8 befbcfff 924040d7
mmc0: starting CMD7 arg 981b0000 flags 00000015
mmci-omap mmci-omap.1: mmc0: CMD7, argument 0x981b0000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD7): 0: 00000700 00000000 00000000 00000000
mmc0: starting CMD55 arg 981b0000 flags 00000095
mmci-omap mmci-omap.1: mmc0: CMD55, argument 0x981b0000
mmci-omap mmci-omap.1: IRQ Status is 1
mmc0: req done (CMD55): 0: 00000920 00000000 00000000 00000000
mmc0: starting CMD51 arg 00000000 flags 000000b5
mmc0:     blksz 8 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmci-omap mmci-omap.1: mmc0: CMD51, argument 0x00000000
mmci-omap mmci-omap.1: IRQ Status is 1
root@omap:~# 
------=_NextPart_000_0060_01C8BC3F.76CB0FC0--

