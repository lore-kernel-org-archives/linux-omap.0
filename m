From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: No more software ECC in omap2.c NAND driver. Why?
Date: Wed, 24 Nov 2010 19:38:55 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0369D9E2B6@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42AB7@dbde02.ent.ti.com>
 <C90FFE9C.203C0%marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47703 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0KXOJK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 09:09:10 -0500
In-Reply-To: <C90FFE9C.203C0%marathon96@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Charles Manning <manningc2@actrix.gen.nz>



 [..snip..]
> % mkfs.jffs2 --little-endian --no-cleanmarkers --pad 2048 --pagesize 2048
> --eraseblock 131072 -d /tmp/tmp.h9dKGpcNFw -D root.devices -o root.jffs2
> 
> >>     nand write.i ${loadaddr} 0x00c00000 0x2000000
> >>     nand write.i ${loadaddr} 0x04200000 0x2000000
> >
> > [Ghorai] why you writing in two places?
> 
> Redundant images.
> 
> >> Following that, the board is updated, from Linux, using 'flash_eraseall
> -
> >> q'
> >> and 'nandwrite -p -q' on all partitions, except that containing MLO.
> > [Ghorai]
> >
> > 1. can you send the exact comment you used to write in nand? Which
> partition?
> 
>     flash_eraseall -q /dev/mtd7
>     nandwrite -p -q /dev/mtd7 root.jffs2
>     flash_eraseal -q /dev/mtd9
>     nandwrite -p -q /dev/mtd9 root.jffs2
> 
> > 2. What is the last kernel you used and was working perfectly?
> v2.6.32_OMAPPSP_03.00.01.06.patch1

[Ghorai] I followed the steps you mentioned. Also I used the following command to mount the jffs2 FS and working fine.
mount -t jffs2 /dev/mtdblock3 /mnt/nand

I have tested in zoom3 -
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micron NAND 512MiB 1,8V 16-bit).

And using the latest kernel -
Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.37-rc3-00102-gea49b16 (a0393553@omapldc12) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #20 SMP Wed Nov 24 17:27:21 IST 2010 

Would you please share your latest log? 
