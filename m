From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: A uboot problem when booting from on-board NOR Flash on
	H4platform
Date: Thu, 5 Jan 2006 10:05:44 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A503B91F3C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>, "Liu, Jason" <jason.liu@spansion.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

To further clarify you will need to compile with XIP support to run your
kernel in flash.  I don't believe all the necessary fixes are in most of
the generally available public versions to correctly do XIP.  I do
recall MontaVista adding some fixes for XIP and ARM11.  These fixes will
be in there CEE/Mobilinux products and perhaps are in the latest 2.6
public kernels.  Many aspects of the ARM11 support were broke in the
public trees.  TI kernels patch many of these, vendor/partner kernels do
also, and the latest public kernels are finally also coming around.
When you have a lot of memory running from DDR is probably preferred
anyway as it is much quicker though it may have a higher power cost.  It
is likely we will refresh our kernel image again, we'll see about making
sure xip works.

As Jian indicated, you can burn a kernel into flash which is meant to
run in SDRAM, this has been the norm.  U-boot will relocate and direct
execution to it at the proper point.

Regards,
Richard W.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Zhang, Jian
Sent: Thursday, January 05, 2006 9:23 AM
To: Liu, Jason; linux-omap-open-source@linux.omap.com
Subject: RE: A uboot problem when booting from on-board NOR Flash on
H4platform

The following is wrong. You need the exactly same uImage to boot from
flash as boot from RAM:

//Note: uImage is generated from mkimage, "mkimage -A arm -O linux -T
kernel -C none -a 0x04100000 -e 0x04100040 -n "Linux Image" -d linux.bin
uImage"

Regards,
Jian

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Liu,
Jason
Sent: Thursday, January 05, 2006 2:37 AM
To: linux-omap-open-source@linux.omap.com
Subject: A uboot problem when booting from on-board NOR Flash on H4
platform


Hi all,

I met an issue when booting a linux kernel from NOR flash on H4
MENELAUSE platform. u-boot for h4 is downloaded from linux.omap.com.
Nothing is modified except that the CFG_NAND_BOOT is undefined.


The linux kernel can be booted from RAM if we use the below uboot
command,
> tftpboot 0x80007fc0 uImage  =20
> bootm 0x80007fc0
//Note: uImage is generated from mkimage, "mkimage -A arm -O linux -T
kernel -C none -a 0x80007fc0 -e 0x80008000 -n "Linux Image" -d linux.bin
uImage"

.......Kernel booting OK!!


But now, I want to boot the uImage from NOR Flash,  I use the following
uboot command to flash the NOR flash firstly,
> protect off all
> erase 1:8-23    /* Intel Flash with 128kB per sector,erase 2MB from
the beginning of 0x04100000*/
> tftpboot 0x80007fc0 uImage
> cp 0x80007fc0 0x04100000 0x200000   /* 2M size for kernel */
//Note: uImage is generated from mkimage, "mkimage -A arm -O linux -T
kernel -C none -a 0x04100000 -e 0x04100040 -n "Linux Image" -d linux.bin
uImage"

After flashing is over, I boot the kernel with the below command:
> bootm 0x04100000

The terminal shows the below information:

## Booting image at 04100000 ...
   Image Name:   Bill Linux Image
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1975872 Bytes =3D  1.9 MB
   Load Address: 04100000
   Entry Point:  04100040
   Verifying Checksum ... OK
   XIP Kernel Image ... OK

Starting kernel ...

Then stopped, and followed by nothing......:(

So, could anybody tell me what the reason is?  or tell me another way to
fulfill it. Thanks a lot!!!


Jason Liu =20








=20
an issue when booting a linux kernel from NOR flash.
The linux kernel=20


Jason Liu

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
