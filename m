From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: A uboot problem when booting from on-board NOR Flash on H4
	platform
Date: Thu, 5 Jan 2006 09:22:34 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA601DE81AA@dlee05.ent.ti.com>
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
To: "Liu, Jason" <jason.liu@spansion.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
