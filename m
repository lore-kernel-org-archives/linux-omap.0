From: Ram <vshrirama@gmail.com>
Subject: Re: Subject: [PATCH 3/3] [ARM] OMAP: Adding Support for 2K nand
	page support on omap2430
Date: Fri, 3 Aug 2007 22:46:32 +0530
Message-ID: <8bf247760708031016m3bf55e45pe2161a51c65e1c46@mail.gmail.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AF@ntxsjombx02.micron.com>
	<8bf247760707310753h7ca6cb78u3af809454d159a59@mail.gmail.com>
	<809D758398CC1F49AA8E493528AD4A27014DF6B8@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <809D758398CC1F49AA8E493528AD4A27014DF6B8@ntxsjombx02.micron.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
  Sorry for the late response. I am appending the kernel dump of all
the gpmc registers
  you had asked for after omap_nand_probe.

  My nand chip is a 128 MB chip. hence the base address i have taken
is 0x10000000
  which is 128MB boundary.
  hence my chip address and mask will become 0x850.(0x6e000078)

  do let me know if the timings are okay?

  am still getting messages such as
  Once i a while i get messages such as Empty flash at 0x00842758 ends
at 0x00842800
  and i get CRC errors as and when i store files and read them back.
  mtd->read(0x358 bytes from 0x590488) returned ECC error
  mtd->read(0x370 bytes from 0x590920) returned ECC error



  Thanking you,

   Regards,
   sriram


NAND device: Manufacturer ID: 0x2c, Chip ID: 0xb1 (Micron NAND 128MiB
1,8V 16-bit)
Creating 5 MTD partitions on "omap2-nand":
0x00000000-0x00080000 : "X-Loader"
0x00080000-0x00100000 : "U-Boot"
0x00100000-0x00140000 : "U-Boot Environment"
0x00140000-0x00540000 : "Kernel"
0x00540000-0x08000000 : "File System"
6e000010 => 11
6e000014 => 1
6e000018 => 0
6e00001c => 100
6e000020 => 0
6e000024 => 0
6e000028 => 0
6e00002c => 0
6e000030 => 0
6e000034 => 0
6e000038 => 0
6e00003c => 0
6e000040 => 0
6e000044 => 0
6e000048 => 0
6e00004c => 0
6e000050 => 11
6e000054 => f01
6e000058 => 0
6e00005c => 0
6e000060 => 601800
6e000064 => 141400
6e000068 => 141400
6e00006c => f010f01
6e000070 => 10c1414
6e000074 => a80
6e000078 => 850
6e00007c => ffffffff
6e000080 => ffffffff
6e000084 => ffffffff
6e000088 => 0
6e00008c => 0
6e000090 => 1000
6e000094 => 101001
6e000098 => 20201
6e00009c => 10031003
6e0000a0 => 10f1111
6e0000a4 => 0
6e0000a8 => f00
6e0000b8 => 0
6e0000bc => 0
6e0000c0 => 621000
6e0000c4 => 1f1f01
6e0000c8 => 80803
6e0000cc => 1c091c09
6e0000d0 => 41f1f1f
6e0000d4 => 4c4
6e0000d8 => f44
6e0000dc => 100000
6e0000e0 => 1c0000
6e0000e4 => 0
6e0000e8 => 0
6e0000ec => 0
6e0000f0 => 1000
6e0000f4 => 101001
6e0000f8 => 20201
6e0000fc => 10031003
6e000100 => 10f1111
6e000104 => 0
6e000108 => f00
6e000118 => 0
6e00011c => 0
6e000120 => 1000
6e000124 => 101001
6e000128 => 20201
6e00012c => 10031003
6e000130 => 10f1111
6e000134 => 0
6e000138 => f00
6e000148 => 0
6e00014c => 0
6e000150 => 11200
6e000154 => 1f1f00
6e000158 => 80802
6e00015c => 1c091c09
6e000160 => 41f1f1f
6e000164 => 4c4
6e000168 => f41
6e000178 => 0
6e00017c => 0
6e000180 => 1000
6e000184 => 101001
6e000188 => 20201
6e00018c => 10031003
6e000190 => 10f1111
6e000194 => 0
6e000198 => f00
6e0001a8 => 0
6e0001ac => 0
6e0001b0 => 1000
6e0001b4 => 101001
6e0001b8 => 20201
6e0001bc => 10031003
6e0001c0 => 10f1111
6e0001c4 => 0
6e0001c8 => f00
6e0001d8 => 0
6e0001dc => 0
6e0001e0 => 4000
6e0001e4 => 0
6e0001e8 => 0
6e0001ec => 0
6e0001f0 => 0
6e0001f4 => 80
6e0001f8 => 1
6e0001fc => 3fc0300f
6e000200 => 0
6e000204 => 0
6e000208 => 0
6e00020c => 0
6e000210 => 0
6e000214 => 0
6e000218 => 0
6e00021c => 0
6e000220 => 0
6e000224 => 0
6e000228 => 0
6e00022c => 0
6e000230 => 0
6e000234 => 0
input: omap_twl4030keypad as /class/input/input0
Power Management for OMAP2 initializing
PRCM revision 1.0
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 92K




On 7/31/07, sshahrom@micron.com <sshahrom@micron.com> wrote:
>
> Hello,
> If you wrote to nand flash with SW ECC enabled. That place 12 bytes at offset 32 in spare area. That is different from our driver since we place 12 bytes after Bad block indicator at the beginning of spare area. In this case read would fail as you see. As I said yesterday, erase the flash, and reflash either nandwrite or use bootloader.
> Another cause could be it seems like clock setting is different. From your yesterday mail:
>
> Clocking rate (Crystal/DPLL/MPU): 12.0/532/266 MHz
>
>
> From my Setting:
>
> Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
>
> If you cat send us register setting at kernel level dump of registers 0x6e000000-0x6e00000280 after omap_nand_probe or init.
>
> Regards,
> -Shahrom
>
>
> -----Original Message-----
> From: Ram [mailto:vshrirama@gmail.com]
> Sent: Tuesday, July 31, 2007 7:53 AM
> To: sshahrom
> Subject: Re: Subject: [PATCH 3/3] [ARM] OMAP: Adding Support for 2K nand page support on omap2430
>
> Hi sharom,
>       I have managed to get git kernel booting on one of our boards.
> However, during usage i get lots of messages like.
>
> I am still getting the same errors.
> mount -t jffs2 /dev/mtdblock4 /mnt/
> mtd->read(0x1f9c8 bytes from 0xbc0638) returned ECC error read(0x12d2c
> mtd->bytes from 0xbcd2d4) returned ECC error
> Empty flash at 0x00bcd2d0 ends at 0x00bcd800 #mtd->read(0x800 bytes from 0xbcd800) returned ECC error
>
>
> After a long list of errors i have been able to get the shell prompt.
>
> However, As i add and delete files i get errors such as:
> Newly-erased block contained word 0xffff0000 at offset 0x02553000,
>
>
> Probably the GPMC settings are not okay. I dont know.
>
>  I am using MT29F1GxxABB (16 bit nand flash)
>
> Which chip are using using?
>
> Are there any differences in the timings between yours and mine.
>
> Am using the settings that comes with the bootloader.
> # define SMNAND_GPMC_CONFIG1 ( (0x00001800)) # define SMNAND_GPMC_CONFIG2 0x00141400 # define SMNAND_GPMC_CONFIG3 0x00141400 # define SMNAND_GPMC_CONFIG4 0x0F010F01 # define SMNAND_GPMC_CONFIG5 0x010C1414 # define SMNAND_GPMC_CONFIG6 0x00000A80
>
> Does the MT29F1GxxABB  require timings which are different from the chip youre using.
>
>
> Any help is highly appreciated.
>
>
> Please do advice.
>
>
> Regards,
> sriram
>
>
>
>
>
> On 7/27/07, sshahrom@micron.com <sshahrom@micron.com> wrote:
> >
> > Hi,
> > Continuing with rest of the patch series on linux.omap.com
> >
> > Signed-off-by: Shahrom Sharif-Kashani <sshahrom@micron.com>
> >
> > :100644 100644 295a568... 0000000... M  drivers/mtd/nand/Kconfig
> > :100644 100644 f9a1f6b... 0000000... M  drivers/mtd/nand/Makefile
> >
> > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig index
> > 295a568..31f646f 100644
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -69,6 +69,12 @@ config MTD_NAND_AMS_DELTA
> >         help
> >           Support for NAND flash on Amstrad E3 (Delta).
> >
> > +config MTD_NAND_OMAP2
> > +       tristate "NAND Flash device on OMAP 2420H4/2430SDP boards"
> > +       depends on ARM && ARCH_OMAP2 && MTD_NAND
> > +       help
> > +          Support for NAND flash on Texas Instruments 2430SDP/2420H4 platforms.
> > +
> >  config MTD_NAND_OMAP
> >         tristate "NAND Flash device on OMAP H3/H2/P2 boards"
> >         depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 ||
> > MACH_OMAP_H3 || MACH_OMAP_PERSEUS2) diff --git
> > a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile index
> > f9a1f6b..1539c98 100644
> > --- a/drivers/mtd/nand/Makefile
> > +++ b/drivers/mtd/nand/Makefile
> > @@ -24,6 +24,7 @@ obj-$(CONFIG_MTD_NAND_NANDSIM)                += nands
> >  obj-$(CONFIG_MTD_NAND_CS553X)          += cs553x_nand.o
> >  obj-$(CONFIG_MTD_NAND_NDFC)            += ndfc.o
> >  obj-$(CONFIG_MTD_NAND_OMAP)            += omap-nand-flash.o
> > +obj-$(CONFIG_MTD_NAND_OMAP2)           += omap2.o
> >  obj-$(CONFIG_MTD_NAND_OMAP_HW)         += omap-hw.o
> >  obj-$(CONFIG_MTD_NAND_AT91)            += at91_nand.o
> >  obj-$(CONFIG_MTD_NAND_CM_X270)         += cmx270_nand.o
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
