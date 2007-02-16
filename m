From: abhishek@nextbitcpu.com
Subject: trouble configuring the touchscreen driver for OMAP OSK 5912
Date: Thu, 15 Feb 2007 22:19:45 -0800 (PST)
Message-ID: <46972.59.144.20.1.1171606785.squirrel@webmail.nextbitcpu.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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

i am not getting any option for CONFIG_TOUCHSCREEN_OMAP. Also while trying
to enable the LCD i dont get an option for CONFIG_FB_OMAP_INTERNAL_LCDC.

here is the Input Device Drivers section of .config file generated after
the 'make menuconfig' command.

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OMAP=y
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TOUCHSCREEN=y
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
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
# CONFIG_FB_CFB_FILLRECT is not set
# CONFIG_FB_CFB_COPYAREA is not set
# CONFIG_FB_CFB_IMAGEBLIT is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_OMAP=y
# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
# CONFIG_FB_OMAP_LCD_MIPID is not set
# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
# CONFIG_FB_OMAP_DMA_TUNE is not set

#

Still i continued with the following procedure and loaded the kernel using
using tftp.

$ make
$ arm-linux-objcopy -O binary -R .note -R .comment -S
arch/arm/boot/compressed/vmlinux linux.bin
$ gzip -9 linux.bin
$ /usr/src/u-boot-1.1.6/tools/mkimage -A arm -O linux -T kernel -C gzip -a
0x10c08000 -e 0x10c08000 -n 'Linux Kernel Image' -d linux.bin.gz uImage.cc
$ cp uImage.cc /tftpboot/uImage.cc

The kernel boots correctly but when i run the command

cat /proc/bus/input/devices

nothing is displayed.

Is there anything i missed out when compiling the kernel? Plese help.

Abhishek Desai
