From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: trouble configuring the touchscreen driver for OMAP OSK 5912
Date: Fri, 16 Feb 2007 05:52:26 -0600
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6A30A12@dlee12.ent.ti.com>
References: <46972.59.144.20.1.1171606785.squirrel@webmail.nextbitcpu.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <46972.59.144.20.1.1171606785.squirrel@webmail.nextbitcpu.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: abhishek@nextbitcpu.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I don't have my code handy right now, but if I remember correctly, in
menuconfig you need to enable SPI.  The touchscreen on the display
module is an ADS7846 so you need to enable that touchscreen.  If I
remember correctly, you need to enable SPI support first before the
ADS7846 shows up as an option under Touchscreens.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com]=

On Behalf Of abhishek@nextbitcpu.com
Sent: Friday, February 16, 2007 12:20 AM
To: linux-omap-open-source@linux.omap.com
Subject: trouble configuring the touchscreen driver for OMAP OSK 5912

Hello,

I have been trying to build the linux kernel for the omap osk 5912 with
touchscreen option but it is not working. The OSK is connected to a
Mistral QVLM display module.
 I am using linux kernel version 2.6.18 along with the appropriate omap
patch patch-2.6.18-omap1. After applying the patch i use the following
procedure.

make clean
make omap_osk_5912_defconfig
make menuconfig

I use the following link for reference
http://oskfordummies.hp.infoseek.co.jp/howto/touch.html

According to this refence document i have to enable the  options

CONFIG_INPUT_EVDEV
CONFIG_INPUT_TOUCHSCREEN
CONFIG_TOUCHSCREEN_OMAP

i am not getting any option for CONFIG_TOUCHSCREEN_OMAP. Also while
trying
to enable the LCD i dont get an option for CONFIG_FB_OMAP_INTERNAL_LCDC.

here is the Input Device Drivers section of .config file generated after
the 'make menuconfig' command.

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OMAP=3Dy
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TOUCHSCREEN=3Dy
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_INPUT_MISC is not set

#


The graphics support section of .config

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB=3Dy
# CONFIG_FB_CFB_FILLRECT is not set
# CONFIG_FB_CFB_COPYAREA is not set
# CONFIG_FB_CFB_IMAGEBLIT is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_OMAP=3Dy
# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
# CONFIG_FB_OMAP_LCD_MIPID is not set
# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=3D2
# CONFIG_FB_OMAP_DMA_TUNE is not set

#

Still i continued with the following procedure and loaded the kernel
using
using tftp.

$ make
$ arm-linux-objcopy -O binary -R .note -R .comment -S
arch/arm/boot/compressed/vmlinux linux.bin
$ gzip -9 linux.bin
$ /usr/src/u-boot-1.1.6/tools/mkimage -A arm -O linux -T kernel -C gzip
-a
0x10c08000 -e 0x10c08000 -n 'Linux Kernel Image' -d linux.bin.gz
uImage.cc
$ cp uImage.cc /tftpboot/uImage.cc

The kernel boots correctly but when i run the command

cat /proc/bus/input/devices

nothing is displayed.

Is there anything i missed out when compiling the kernel? Plese help.

Abhishek Desai




_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
