From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: USB Host on OMAP3 EVM, 2.6.29
Date: Tue, 26 May 2009 17:59:22 -0700
Message-ID: <4A1C906A.3030206@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:52379 "EHLO
	smtp1.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbZE0BG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 21:06:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

We're trying to get basic USB host mode up and running on a OMAP3530 
EVM, with no success.  We're (now, after many permutations of kernels 
and .config settings) using the vanilla 2.6.29-omap1 kernel plus the 
AUTOIDLE fix from Niilo Minkkinen), with slight additions to 
board-omap3evm to allow the MMC slot to work since it hosts the rootfs 
(missing regulator setup, as per dfoley's mail on 3/25).

All we've done with configuration past omap3_evm_defconfig, is to 
compile in the MMC driver (to allow boot from it), enabling the EHCI 
host driver (doesn't work with it off, either), and setting the 
integrated USB driver to Host mode.  Listed below is the resulting 
.config file.  We've tried many other configurations, but nothing has 
worked any better.

I'd very much appreciate it if anyone knows what magic sauce might be 
missing here - the USB bus debug messages indicate that the bus is being 
discovered, and powered up, but no voltage appears on the USB VBus line, 
and no devices are detected when they're plugged in.   Sometimes we've 
seen auto-suspend messages indicating that the bus is auto-suspending, 
and other times we've seen nothing - but no matter what, it doesn't seem 
to work.

Below is the output of "dmesg | grep 'usb\|hub' " for the above 
configuration with a USB keyboard plugged in, followed by the .config file:

Thanks,

Eino-Ville Talvala
Graduate Research Assistant
Computer Graphics Laboratory
Stanford University


----------------------------------------------------------------------------------------------------------------------------------------------------------
twl4030_usb twl4030_usb: HW_CONDITIONS 0x50/80; link 1
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, musb-dma, host, debug=0
musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk 
split (X), HB-ISO Rx (X), HB-ISO Tx (X), SoftConn)
musb_hdrc: MHDRC RTL version 1.400
musb_hdrc: setup fifo_mode 4
musb_hdrc: 29/31 max ep, 15424/16384 memory
musb_hdrc: hw_ep 0shared, max 64
musb_hdrc: hw_ep 1tx, max 512
musb_hdrc: hw_ep 1rx, max 512
musb_hdrc: hw_ep 2tx, max 512
musb_hdrc: hw_ep 2rx, max 512
musb_hdrc: hw_ep 3tx, max 512
musb_hdrc: hw_ep 3rx, max 512
musb_hdrc: hw_ep 4tx, max 512
musb_hdrc: hw_ep 4rx, max 512
musb_hdrc: hw_ep 5tx, max 512
musb_hdrc: hw_ep 5rx, max 512
musb_hdrc: hw_ep 6tx, max 512
musb_hdrc: hw_ep 6rx, max 512
musb_hdrc: hw_ep 7tx, max 512
musb_hdrc: hw_ep 7rx, max 512
musb_hdrc: hw_ep 8tx, max 512
musb_hdrc: hw_ep 8rx, max 512
musb_hdrc: hw_ep 9tx, max 512
musb_hdrc: hw_ep 9rx, max 512
musb_hdrc: hw_ep 10tx, max 512
musb_hdrc: hw_ep 10rx, max 512
musb_hdrc: hw_ep 11tx, max 512
musb_hdrc: hw_ep 11rx, max 512
musb_hdrc: hw_ep 12tx, max 512
musb_hdrc: hw_ep 12rx, max 512
musb_hdrc: hw_ep 13tx, max 512
musb_hdrc: hw_ep 13rx, max 512
musb_hdrc: hw_ep 14shared, max 1024
musb_hdrc: hw_ep 15shared, max 1024
musb_hdrc: USB Host mode controller at d80ab000 using DMA, IRQ 92
musb_hdrc musb_hdrc: MUSB HDRC host driver
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: default language 0x0409
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.29-omap1-05531-g0dfe43a-dirty musb-hcd
usb usb1: SerialNumber: musb_hdrc
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: no over-current protection
hub 1-0:1.0: power on to power good time: 10ms
hub 1-0:1.0: 100mA bus power budget for each child
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '001'
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
usbmon: debugfs is not available
drivers/usb/core/inode.c: creating file '002'
usb usb2: default language 0x0409
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OMAP-EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.29-omap1-05531-g0dfe43a-dirty ehci_hcd
usb usb2: SerialNumber: ehci-omap.0
usb usb2: uevent
usb usb2: usb_probe_device
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: individual port power switching
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 20ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '001'
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver usbtest
hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci-omap ehci-omap.0: suspend root hub

--------------------------------------------------------------------------------------------------------------
grep 'USB\|TWL' .config :

# USB Network Adapters
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_KEYBOARD_TWL4030=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_TWL4030_MADC is not set
# CONFIG_TWL4030_POWEROFF is not set
CONFIG_GPIO_TWL4030=y
# USB-based Watchdog Cards
# CONFIG_USBPCWATCHDOG is not set
CONFIG_TWL4030_CORE=y
# CONFIG_TWL4030_POWER is not set
# CONFIG_USB_DABUSB is not set
# USB Input Devices
CONFIG_USB_HID=y
# CONFIG_USB_HIDDEV is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
# Miscellaneous USB options
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_MON=y
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set
# USB Host Controller Drivers
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_SOC=y
# OMAP 343x high speed USB support
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_PERIPHERAL is not set
# CONFIG_USB_MUSB_OTG is not set
# CONFIG_USB_GADGET_MUSB_HDRC is not set
CONFIG_USB_MUSB_HDRC_HCD=y
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_INVENTRA_DMA=y
# CONFIG_USB_TI_CPPI_DMA is not set
# CONFIG_USB_MUSB_DEBUG is not set
# USB Device Class drivers
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
# see USB_STORAGE Help for more information
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set
# USB Imaging devices
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# USB port drivers
# CONFIG_USB_SERIAL is not set
# USB Miscellaneous drivers
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_VST is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_SELECTED=y
# CONFIG_USB_GADGET_AT91 is not set
# CONFIG_USB_GADGET_ATMEL_USBA is not set
# CONFIG_USB_GADGET_FSL_USB2 is not set
# CONFIG_USB_GADGET_LH7A40X is not set
CONFIG_USB_GADGET_OMAP=y
CONFIG_USB_OMAP=y
# CONFIG_USB_GADGET_PXA25X is not set
# CONFIG_USB_GADGET_PXA27X is not set
# CONFIG_USB_GADGET_S3C2410 is not set
# CONFIG_USB_GADGET_IMX is not set
# CONFIG_USB_GADGET_M66592 is not set
# CONFIG_USB_GADGET_AMD5536UDC is not set
# CONFIG_USB_GADGET_FSL_QE is not set
# CONFIG_USB_GADGET_CI13XXX is not set
# CONFIG_USB_GADGET_NET2280 is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
# CONFIG_USB_GADGET_DUALSPEED is not set
CONFIG_USB_ZERO=m
# CONFIG_USB_ETH is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_OTG_UTILS=y
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_TWL4030_USB=y
CONFIG_REGULATOR_TWL4030=y

