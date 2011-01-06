From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 23:52:03 +0000
Message-ID: <20110106235203.GA14425@n2100.arm.linux.org.uk>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53408 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab1AFXwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 18:52:15 -0500
Content-Disposition: inline
In-Reply-To: <20110106205107.GI1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, Jan 06, 2011 at 08:51:07PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 06, 2011 at 12:34:32PM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [110106 11:52]:
> > > --- a/arch/arm/boot/compressed/head.S
> > > +++ b/arch/arm/boot/compressed/head.S
> > > @@ -71,6 +71,23 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
> > >  		mov	\rb, #0x50000000
> > >  		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
> > >  		.endm
> > > +#elif defined(CONFIG_ARCH_OMAP2PLUS)
> > > +#include <plat/multi.h>
> > > +#ifdef MULTI_OMAP2)
> >                      ^
> > Looks like my last change to this patch from if defined to ifdef
> > broke the warning above with an unbalanced bracket..
> > 
> > Thanks Nishant for catching that, updated patch below.
> 
> Just tried that patch, but I now have bigger problems:
> 
> OMAP44XX SDP # mmcinit 0
> OMAP44XX SDP # fatload mmc 0 0x80300000 uImage-test
> 
> 0 bytes read
> OMAP44XX SDP #
> 
> God knows why it's doing this now, as the file is present on the SD
> card:
> 
> -rwxr-xr-x. 1 rmk rmk 1836636 Jan  6 20:35 uImage-test
> 
> is what's on the SD card - with no FAT errors:
> 
> $ fsck.msdos /dev/mmcblk0p1
> dosfsck 3.0.1, 23 Nov 2008, FAT32, LFN
> /dev/mmcblk0p1: 8 files, 10249/142266 clusters
> 
> The file's not corrupt either:
> 
> $ md5sum /media/boot/uImage-test
> be3edd928f1dbb3c15215b1a8a62fa1f  /media/boot/uImage-test
> $ md5sum ../build/omap4/arch/arm/boot/uImage
> be3edd928f1dbb3c15215b1a8a62fa1f  ../build/omap4/arch/arm/boot/uImage
> 
> Nope, still won't work:
> 
> OMAP44XX SDP # setenv bootargs 'root=/dev/mmcblk0p2 rw mem=512M vmalloc=1G console=ttyO2,115200n8 rootdelay=2'
> OMAP44XX SDP # mmcinit 0
> OMAP44XX SDP # fatload mmc 0 0x80300000 uImage-test
> 
> 0 bytes read
> OMAP44XX SDP #
> 
> However, it can still boot the uImage contained on the SD card, so the
> card must be okay, and the SDP must still be able to successfully read
> from the card.  I can only assume that uboot's FAT support is buggered
> in some way.
> 
> We _really_ need a _decent_ boot loader on these boards, one which can
> do network booting _and_ can be configured to do so from bootup.  SD
> cards just don't hack it for kernel development.  It's a far too long-
> winded process for each cycle, and with all the additional problems
> (such as SD cards not being recognised 50% of the time, FAT filesystem
> bugs in boot loaders, etc) it's really not funny.
> 
> So, I give up at this point with the OMAP4430SDP board.  It's not worth
> spending the time with this kind of unreliability.

OMAP44XX SDP # fatls mmc 0

  1935000   uimage
   149104   u-boot.bin
    18984   mlo
  1836636   uimage-test
  1130288   uimage-ss
    19040   mlo.old
Invalid FAT entry

6 file(s), 0 dir(s)

"Invalid FAT entry" ?  I don't think so.  The thing actually contains:

-rwxr-xr-x. 1 rmk rmk 1935000 Feb  4  2010 uImage
-rwxr-xr-x. 1 rmk rmk  149104 Feb  4  2010 u-boot.bin
-rwxr-xr-x. 1 rmk rmk   18984 Jan  1  2000 mlo
-rwxr-xr-x. 1 rmk rmk 1836636 Jan  6 21:35 uImage-test
-rwxr-xr-x. 1 rmk rmk 1130288 Jan  1  2000 uImage-ss
-rwxr-xr-x. 1 rmk rmk   19040 Feb  4  2010 mlo.old
-rwxr-xr-x. 1 rmk rmk  154904 Jan  1  2000 u-boot.new

The hexdump of the directory on the SD card is:
0011a000  62 6f 6f 74 20 20 20 20  20 20 20 08 00 00 87 b6  |boot       .....|
0011a010  3e 3c 3e 3c 00 00 87 b6  3e 3c 00 00 00 00 00 00  |><><....><......|
0011a020  41 75 00 49 00 6d 00 61  00 67 00 0f 00 46 65 00  |Au.I.m.a.g...Fe.|
0011a030  00 00 ff ff ff ff ff ff  ff ff 00 00 ff ff ff ff  |................|
0011a040  55 49 4d 41 47 45 20 20  20 20 20 20 00 64 6d 65  |UIMAGE      .dme|
0011a050  44 3c 26 3e 00 00 6d 65  44 3c 4a 0e 98 86 1d 00  |D<&>..meD<J.....|
0011a060  41 75 00 2d 00 62 00 6f  00 6f 00 0f 00 30 74 00  |Au.-.b.o.o...0t.|
0011a070  2e 00 62 00 69 00 6e 00  00 00 00 00 ff ff ff ff  |..b.i.n.........|
0011a080  55 2d 42 4f 4f 54 20 20  42 49 4e 20 00 64 6f 65  |U-BOOT  BIN .doe|
0011a090  44 3c bc 3c 00 00 6f 65  44 3c 0e 1d 70 46 02 00  |D<.<..oeD<..pF..|
0011a0a0  41 6d 00 6c 00 6f 00 00  00 ff ff 0f 00 c8 ff ff  |Am.l.o..........|
0011a0b0  ff ff ff ff ff ff ff ff  ff ff 00 00 ff ff ff ff  |................|
0011a0c0  4d 4c 4f 20 20 20 20 20  20 20 20 20 00 00 28 00  |MLO         ..(.|
0011a0d0  21 28 26 3e 00 00 28 00  21 28 21 2d 28 4a 00 00  |!(&>..(.!(!-(J..|
0011a0e0  41 75 00 49 00 6d 00 61  00 67 00 0f 00 4e 65 00  |Au.I.m.a.g...Ne.|
0011a0f0  2d 00 74 00 65 00 73 00  74 00 00 00 00 00 ff ff  |-.t.e.s.t.......|
0011a100  55 49 4d 41 47 45 7e 31  20 20 20 20 00 64 7b ac  |UIMAGE~1    .d{.|
0011a110  26 3e 26 3e 00 00 7b ac  26 3e ce fb 5c 06 1c 00  |&>&>..{.&>..\...|
0011a120  e5 75 00 2d 00 62 00 6f  00 6f 00 0f 00 14 74 00  |.u.-.b.o.o....t.|
0011a130  2e 00 42 00 49 00 32 00  00 00 00 00 ff ff ff ff  |..B.I.2.........|
0011a140  e5 2d 42 4f 4f 54 20 20  42 49 32 20 00 64 6f 65  |.-BOOT  BI2 .doe|
0011a150  44 3c bc 3c 00 00 6f 65  44 3c 0e 1d 70 46 02 00  |D<.<..oeD<..pF..|
0011a160  41 75 00 49 00 6d 00 61  00 67 00 0f 00 6e 65 00  |Au.I.m.a.g...ne.|
0011a170  2d 00 73 00 73 00 00 00  ff ff 00 00 ff ff ff ff  |-.s.s...........|
0011a180  55 49 4d 41 47 45 7e 32  20 20 20 20 00 64 bb 00  |UIMAGE~2    .d..|
0011a190  21 28 26 3e 00 00 bb 00  21 28 76 2e 30 3f 11 00  |!(&>....!(v.0?..|
0011a1a0  41 6d 00 6c 00 6f 00 2e  00 6f 00 0f 00 4e 6c 00  |Am.l.o...o...Nl.|
0011a1b0  64 00 00 00 ff ff ff ff  ff ff 00 00 ff ff ff ff  |d...............|
0011a1c0  4d 4c 4f 20 20 20 20 20  4f 4c 44 20 00 64 73 65  |MLO     OLD .dse|
0011a1d0  44 3c 6a 3c 00 00 73 65  44 3c 32 1e 60 4a 00 00  |D<j<..seD<2.`J..|
0011a1e0  41 75 00 2d 00 62 00 6f  00 6f 00 0f 00 fa 74 00  |Au.-.b.o.o....t.|
0011a1f0  2e 00 6e 00 65 00 77 00  00 00 00 00 ff ff ff ff  |..n.e.w.........|

... and the directory continues in a different sector ...

00a29200  55 2d 42 4f 4f 54 20 20  4e 45 57 20 00 00 3d 00  |U-BOOT  NEW ..=.|
00a29210  21 28 26 3e 00 00 3d 00  21 28 47 2d 18 5d 02 00  |!(&>..=.!(G-.]..|
00a29220  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

The relevant parts of the FAT table are:

00004000  f8 ff ff 0f ff ff ff 0f  7b 48 00 00 00 00 00 00  |........{H......|
                                   ^^^^^ entry linking to next root-dir sector
...
000161e0  00 00 00 00 00 00 00 00  00 00 00 00 ff ff ff 0f  |................|
                                               ^^^^^^^^^^^ terminator

Cluster 2 = root dir start.
Cluster 2 image address = 0x119c00 + 2 * 0x200 = 0x11a000.
Cluster 2 FAT address = 0x4000 + 2 * 4 = 0x4008.
Following cluster = 0x487b.
Cluster 0x487b image address = 0x119c00 + 0x487b * 0x200 = 0xa29200
Cluster 0x487b FAT address = 0x4000 + 0x487b * 4 = 0x161ec.
Following cluster = 0x0fffffff = FAT-32 EOF.

So, uboot's FAT code can't deal with a directory larger than one sector
that doesn't continue.  While we're here, lets confirm by hand that
there's nothing wrong with the uImage-test file and it's yet again uboot
being idiotic.

The directory entry for loading my uImage-test file is:
0011a0e0  41 75 00 49 00 6d 00 61  00 67 00 0f 00 4e 65 00  |Au.I.m.a.g...Ne.|
0011a0f0  2d 00 74 00 65 00 73 00  74 00 00 00 00 00 ff ff  |-.t.e.s.t.......|
0011a100  55 49 4d 41 47 45 7e 31  20 20 20 20 00 64 7b ac  |UIMAGE~1    .d{.|
0011a110  26 3e 26 3e 00 00 7b ac  26 3e ce fb 5c 06 1c 00  |&>&>..{.&>..\...|

Decoding this entry gives:
 creation time = 0xac7b
 creation date = 0x3e26
 access date = 0x3e26
 time = 0xac7b
 date = 0x3e26
 start cluster = 0x0000fbce
 size = 0x001c065c (1836636 bytes)

Cluster 0xfbce = image address 0x119c00 + 0xfbce*0x200 = 0x2093800:
Cluster 0xfbce FAT entry address = 0x4000 + 0xfbce * 4 = 0x42f38

00042f30  00 00 00 00 00 00 00 00  cf fb 00 00 d0 fb 00 00  |................|
00042f40  d1 fb 00 00 d2 fb 00 00  d3 fb 00 00 d4 fb 00 00  |................|

Next cluster = 0xfbcf, then 0xfbd0 and so on.

The data on the SD card for this file:
02093800  27 05 19 56 76 ed 63 cb  4d 26 27 76 00 1c 06 1c  |'..Vv.c.M&'v....|
02093810  80 00 80 00 80 00 80 00  ad 09 bd ce 05 02 02 00  |................|
02093820  4c 69 6e 75 78 2d 32 2e  36 2e 33 37 2b 00 00 00  |Linux-2.6.37+...|
02093830  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
02093840  00 00 a0 e1 00 00 a0 e1  00 00 a0 e1 00 00 a0 e1  |................|
*
02093860  02 00 00 ea 18 28 6f 01  00 00 00 00 1c 06 1c 00  |.....(o.........|
02093870  01 70 a0 e1 02 80 a0 e1  00 20 0f e1 03 00 12 e3  |.p....... ......|
02093880  01 00 00 1a 17 00 a0 e3  56 34 12 ef 00 20 0f e1  |........V4... ..|

and the corresponding version from my build tree:
00000000  27 05 19 56 76 ed 63 cb  4d 26 27 76 00 1c 06 1c  |'..Vv.c.M&'v....|
00000010  80 00 80 00 80 00 80 00  ad 09 bd ce 05 02 02 00  |................|
00000020  4c 69 6e 75 78 2d 32 2e  36 2e 33 37 2b 00 00 00  |Linux-2.6.37+...|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000040  00 00 a0 e1 00 00 a0 e1  00 00 a0 e1 00 00 a0 e1  |................|
*
00000060  02 00 00 ea 18 28 6f 01  00 00 00 00 1c 06 1c 00  |.....(o.........|
00000070  01 70 a0 e1 02 80 a0 e1  00 20 0f e1 03 00 12 e3  |.p....... ......|
00000080  01 00 00 1a 17 00 a0 e3  56 34 12 ef 00 20 0f e1  |........V4... ..|

matches.  So there's no problem here with the filesystem itself - it's
just uboot not parsing the FAT filesystem correctly.  I *really* want
to throw this version of uboot in the circular filing cabinet now.

Can we _please_ have a version of uboot for the SDP4430 platform which
can be configured at runtime _and_ which is capable of DHCP/TFTP ?
I really don't want to mess about anymore with buggy boot loaders.
