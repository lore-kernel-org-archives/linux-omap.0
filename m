From: Peter Barada <peterb@logicpd.com>
Subject: Anyone have MUSB working on PM branch?
Date: Fri, 01 May 2009 14:06:53 -0400
Message-ID: <1241201214.18100.362.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:57134 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752499AbZEASGz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 May 2009 14:06:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

All,

I'm trying to get OTG to work using the latest PM branch (created by
cloning
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git,
commit ID 12323321f004c9e83061c9a9d06046b050d6d4c77).

I started with the rk51 board, and brought up serial, ethernet for
NFSroot, added the following to setup the OTG MUX
arch/arm/mach-omap2/mux.c:

// MUSB port 0
MUX_CFG_34XX("T28_3430_USB0HS_PHY_CLK", 0x1a2,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("T25_3430_USB0HS_PHY_STP", 0x1a4,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("R28_3430_USB0HS_PHY_DIR", 0x1a6,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("T26_3430_USB0HS_PHY_NXT", 0x1a8,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("T27_3430_USB0HS_PHY_D0", 0x1aa,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("U28_3430_USB0HS_PHY_D1", 0x1ac,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("U27_3430_USB0HS_PHY_D2", 0x1ae,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("U26_3430_USB0HS_PHY_D3", 0x1b0,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("U25_3430_USB0HS_PHY_D4", 0x1b2,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("V28_3430_USB0HS_PHY_D5", 0x1b4,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("V27_3430_USB0HS_PHY_D6", 0x1b6,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
MUX_CFG_34XX("V26_3430_USB0HS_PHY_D7", 0x1b8,
                OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)

The following is called before usb_musb_init in the board file:

// Initialize the mux for the MUSB
static void musb_mux_init(void)
{
	/* Port 0 */

	omap_cfg_reg(T28_3430_USB0HS_PHY_CLK);
	omap_cfg_reg(T25_3430_USB0HS_PHY_STP);
	omap_cfg_reg(R28_3430_USB0HS_PHY_DIR);
	omap_cfg_reg(T26_3430_USB0HS_PHY_NXT);
	omap_cfg_reg(T27_3430_USB0HS_PHY_D0);
	omap_cfg_reg(U28_3430_USB0HS_PHY_D1);
	omap_cfg_reg(U27_3430_USB0HS_PHY_D2);
	omap_cfg_reg(U26_3430_USB0HS_PHY_D3);
	omap_cfg_reg(U25_3430_USB0HS_PHY_D4);
	omap_cfg_reg(V28_3430_USB0HS_PHY_D5);
	omap_cfg_reg(V27_3430_USB0HS_PHY_D6);
	omap_cfg_reg(V26_3430_USB0HS_PHY_D7);
}

And I verified that it is indeed called(fromn the log):

MUX: setup T28_3430_USB0HS_PHY_CLK (0xd80021a2): 0x0108 -> 0x0108
MUX: setup T25_3430_USB0HS_PHY_STP (0xd80021a4): 0x0118 -> 0x0108
MUX: setup R28_3430_USB0HS_PHY_DIR (0xd80021a6): 0x0108 -> 0x0108
MUX: setup T26_3430_USB0HS_PHY_NXT (0xd80021a8): 0x0108 -> 0x0108
MUX: setup T27_3430_USB0HS_PHY_D0 (0xd80021aa): 0x0108 -> 0x0108
MUX: setup U28_3430_USB0HS_PHY_D1 (0xd80021ac): 0x0108 -> 0x0108
MUX: setup U27_3430_USB0HS_PHY_D2 (0xd80021ae): 0x0108 -> 0x0108
MUX: setup U26_3430_USB0HS_PHY_D3 (0xd80021b0): 0x0108 -> 0x0108
MUX: setup U25_3430_USB0HS_PHY_D4 (0xd80021b2): 0x0108 -> 0x0108
MUX: setup V28_3430_USB0HS_PHY_D5 (0xd80021b4): 0x0114 -> 0x0108
MUX: setup V27_3430_USB0HS_PHY_D6 (0xd80021b6): 0x0108 -> 0x0108
MUX: setup V26_3430_USB0HS_PHY_D7 (0xd80021b8): 0x0108 -> 0x0108

And setup the MUSB in host mode(relevant part of .config):

CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_WHITELIST=y
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_MON=y
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_SOC=y

#
# OMAP 343x high speed USB support
#
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_PERIPHERAL is not set
# CONFIG_USB_MUSB_OTG is not set
# CONFIG_USB_GADGET_MUSB_HDRC is not set
CONFIG_USB_MUSB_HDRC_HCD=y
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_MUSB_DEBUG=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
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
CONFIG_USB_LIBUSUAL=y


When I fire up the kernel w/o a device plugged in, then plug in a
device, it fails to detect the insertion event.  Also, if I fire it up
with a hub plugged in, it detects the hub, but no downstream devices.

I see the following on startup(with debug set to 4, hub plugged in with
card reader downstream of the hub).  It looks like the usb can see the
hub, but doesn't detect (or power up) any devices downsteam of the hub:

Uncompressing
Linux........................................................................................................................................................................ done, booting the kernel.
Linux version 2.6.30-rc1-omap1 (peter@blackhole) (gcc version 4.1.2) #11
Fri May 1 13:59:28 EDT 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Logic OMAP3530 LV SOM reference board
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c052b148, node_mem_map c09bb000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32512 pages, LIFO batch:7
OMAP3430 ES2.1
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512
Kernel command line: display=15 console=ttyS0,115200 root=/dev/nfs rw
nfsroot=192.168.3.5:/opt/nfs-exports/ltib-omap-lv_som,wsize=1500,rsize=1500 ip=dhcp ignore_loglevel
debug: ignoring loglevel setting.
NR_IRQS:402
Clocking rate (Crystal/DPLL/ARM core): 26.0/166/500 MHz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
PID hash table entries: 512 (order: 9, 2048 bytes)
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 3167 kB
 per task-struct memory footprint: 2304 bytes
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 119836KB available (3360K code, 6327K data, 136K init, 0K
highmem)
Calibrating delay loop... 497.82 BogoMIPS (lpj=1941504)
Security Framework initialized
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 896 bytes
NET: Registered protocol family 16
MUX: setup T28_3430_USB0HS_PHY_CLK (0xd80021a2): 0x0108 -> 0x0108
MUX: setup T25_3430_USB0HS_PHY_STP (0xd80021a4): 0x0118 -> 0x0108
MUX: setup R28_3430_USB0HS_PHY_DIR (0xd80021a6): 0x0108 -> 0x0108
MUX: setup T26_3430_USB0HS_PHY_NXT (0xd80021a8): 0x0108 -> 0x0108
MUX: setup T27_3430_USB0HS_PHY_D0 (0xd80021aa): 0x0108 -> 0x0108
MUX: setup U28_3430_USB0HS_PHY_D1 (0xd80021ac): 0x0108 -> 0x0108
MUX: setup U27_3430_USB0HS_PHY_D2 (0xd80021ae): 0x0108 -> 0x0108
MUX: setup U26_3430_USB0HS_PHY_D3 (0xd80021b0): 0x0108 -> 0x0108
MUX: setup U25_3430_USB0HS_PHY_D4 (0xd80021b2): 0x0108 -> 0x0108
MUX: setup V28_3430_USB0HS_PHY_D5 (0xd80021b4): 0x0114 -> 0x0108
MUX: setup V27_3430_USB0HS_PHY_D6 (0xd80021b6): 0x0108 -> 0x0108
MUX: setup V26_3430_USB0HS_PHY_D7 (0xd80021b8): 0x0108 -> 0x0108
MUX: setup J21_34XX_I2C1_SDA (0xd80021bc): 0x0118 -> 0x0118
MUX: setup K21_34XX_I2C1_SCL (0xd80021ba): 0x0118 -> 0x0118
MUX: setup AE15_34XX_I2C2_SDA (0xd80021c0): 0x0118 -> 0x0118
MUX: setup AF15_34XX_I2C2_SCL (0xd80021be): 0x0118 -> 0x0118
MUX: setup AG14_34XX_I2C3_SDA (0xd80021c4): 0x0118 -> 0x0118
MUX: setup AF14_34XX_I2C3_SCL (0xd80021c2): 0x0118 -> 0x0118
MUX: setup AE1_34XX_GPIO152 (0xd8002184): 0x0104 -> 0x0104
GPMC CS1: cs_on     :   2 ticks,  24 ns (was   2 ticks)  24 ns
GPMC CS1: cs_rd_off :   8 ticks,  96 ns (was   8 ticks)  96 ns
GPMC CS1: cs_wr_off :   8 ticks,  96 ns (was   8 ticks)  96 ns
GPMC CS1: adv_on    :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: adv_rd_off:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: adv_wr_off:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: oe_on     :   2 ticks,  24 ns (was   2 ticks)  24 ns
GPMC CS1: oe_off    :   8 ticks,  96 ns (was   8 ticks)  96 ns
GPMC CS1: we_on     :   2 ticks,  24 ns (was   2 ticks)  24 ns
GPMC CS1: we_off    :   8 ticks,  96 ns (was   8 ticks)  96 ns
GPMC CS1: rd_cycle  :  10 ticks, 120 ns (was  10 ticks) 120 ns
GPMC CS1: wr_cycle  :  10 ticks, 120 ns (was  10 ticks) 120 ns
GPMC CS1: access    :   8 ticks,  96 ns (was   8 ticks)  96 ns
GPMC CS1: page_burst_access:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: wr_data_mux_bus:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: wr_access :   0 ticks,   0 ns (was   0 ticks)   0 ns
01: 00001000 00080802 00000000 08020802 00080a0a 00000000 00000f48
gpmc_get_fclk_period() = 12048
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030_gpio: use which platform_data?
twl4030: gpio (irq 368) chaining IRQs 384..401
twl4030_madc: use which platform_data?
i2c_omap i2c_omap.2: bus 2 rev3.12 at 100 kHz
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switched to high resolution mode on CPU 0
musb_hdrc: version 6.0, pio, host, debug=3
allocate_instance: mbast d80ab000
HS USB OTG: revision 0x33, sysconfig 0x2011, sysstatus 0x1, intrfsel
0x1, simenable  0x0
musb_hdrc: ConfigData=0x55 (UTMI-16, dyn FIFOs, bulk split (X), HB-ISO
Rx (X))
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
musb_hdrc: USB Host mode controller at d80ab000 using PIO, IRQ 92
musb_hdrc musb_hdrc: MUSB HDRC host driver
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: default language 0x0409
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.30-rc1-omap1 musb-hcd
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
musb_start 867: <== devctl 98
drivers/usb/core/inode.c: creating file '001'
musb_init_controller 2033: HOST mode, status 0, devctl 99 B
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
msgmni has been set to 234
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
console [ttyS0] enabled
musb_stage0_irq 393: <== Power=e0, DevCtl=5d, int_usb=0x10
musb_stage0_irq 629: CONNECT (a_host) devctl 5d
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
brd: module loaded
loop: module loaded
i2c /dev entries driver
musb_hub_control 344: port status 00010101
hub 1-0:1.0: port 1: status 0101 change 0001
hub 1-0:1.0: state 7 ports 1 chg 0002 evt 0000
hub 1-0:1.0: port 1, status 0101, change 0000, 12 Mb/s
Driver 'sd' needs updating - please use bus_type methods
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=ffffffff:01,
irq=-1)
net eth0: MAC Address: 00:08:ee:02:82:22
OneNAND driver initializing
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
Advanced Linux Sound Architecture Driver Version 1.0.19.
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
musb_hub_control 344: port status 00120503
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Disabling unused clock "sr2_fck"
Disabling unused clock "sr1_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "gpt2_ick"
Disabling unused clock "gpt3_ick"
Disabling unused clock "gpt4_ick"
Disabling unused clock "gpt5_ick"
Disabling unused clock "gpt6_ick"
Disabling unused clock "gpt7_ick"
Disabling unused clock "gpt8_ick"
Disabling unused clock "gpt9_ick"
Disabling unused clock "wdt3_ick"
Disabling unused clock "wdt3_fck"
Disabling unused clock "gpio2_dbck"
Disabling unused clock "gpio3_dbck"
Disabling unused clock "gpio4_dbck"
Disabling unused clock "gpio5_dbck"
Disabling unused clock "gpio6_dbck"
Disabling unused clock "gpt9_fck"
Disabling unused clock "gpt8_fck"
Disabling unused clock "gpt7_fck"
Disabling unused clock "gpt6_fck"
Disabling unused clock "gpt5_fck"
Disabling unused clock "gpt4_fck"
Disabling unused clock "gpt3_fck"
Disabling unused clock "gpt2_fck"
Disabling unused clock "gpt12_ick"
Disabling unused clock "wdt1_ick"
Disabling unused clock "wdt2_ick"
Disabling unused clock "wdt2_fck"
Disabling unused clock "gpio1_dbck"
Disabling unused clock "cam_ick"
Disabling unused clock "cam_mclk"
Disabling unused clock "dss_ick"
Disabling unused clock "dss_96m_fck"
Disabling unused clock "dss1_alwon_fck"
Disabling unused clock "des1_ick"
Disabling unused clock "sha11_ick"
Disabling unused clock "rng_ick"
Disabling unused clock "aes1_ick"
Disabling unused clock "ssi_ick"
Disabling unused clock "mailboxes_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "gpt10_ick"
Disabling unused clock "gpt11_ick"
Disabling unused clock "hdq_ick"
Disabling unused clock "mspro_ick"
Disabling unused clock "des2_ick"
Disabling unused clock "sha12_ick"
Disabling unused clock "aes2_ick"
Disabling unused clock "icr_ick"
Disabling unused clock "pka_ick"
Disabling unused clock "ssi_ssr_fck"
Disabling unused clock "hdq_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mspro_fck"
Disabling unused clock "gpt11_fck"
Disabling unused clock "gpt10_fck"
Disabling unused clock "iva2_ck"
Disabling unused clock "clkout2_src_ck"
Disabling unused clock "dpll4_m6x2_ck"
Disabling unused clock "dpll3_m3x2_ck"
Disabling unused clock "sys_clkout1"
OMAP GPIO switch handler initializing
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
usb 1-1: new high speed USB device using musb_hdrc and address 2
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev0 ep0out h_addr00
h_port00 bytes 8
musb_hub_control 344: port status 00120503
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev0 ep0out h_addr00
h_port00 bytes 8
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
usb 1-1: default language 0x0409
musb_ep_program 635: --> hw0 urb c7a27d40 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-1: Product: USB2.0 Hub
usb 1-1: uevent
usb 1-1: usb_probe_device
usb 1-1: configuration #1 chosen from 1 choice
musb_ep_program 635: --> hw0 urb c7a27cc0 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: uevent
hub 1-1:1.0: usb_probe_interface
hub 1-1:1.0: usb_probe_interface - got id
hub 1-1:1.0: ignoring external hub
drivers/usb/core/inode.c: creating file '002'
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
musb_hub_control 344: port status 00020503
hub 1-0:1.0: port 1 enable change, status 00000503
net eth0: SMSC911x/921x identified at 0xc886e000, IRQ: 312
Sending DHCP requests .<7>musb_ep_program 635: --> hw0 urb c7a27ac0 spd3
dev2 ep0out h_addr00 h_port00 bytes 8
musb_port_suspend 78: Root port suspended, power f2
usb 1-1: usb auto-suspend
., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.3.105
IP-Config: Complete:
     device=eth0, addr=192.168.3.105, mask=255.255.255.0,
gw=192.168.3.1,
     host=192.168.3.105, domain=, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=192.168.3.5, rootpath=
Looking up port of RPC 100003/2 on 192.168.3.5
Looking up port of RPC 100005/1 on 192.168.3.5
VFS: Mounted root (nfs filesystem) on device 0:14.
Freeing init memory: 136K
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend
init started: BusyBox v1.11.2 ()
starting pid 731, tty '': '/etc/rc.d/rcS'
Setting the hostname to OMAP-35x
Mounting /proc and /sys 
Starting the hotplug events dispatcher udevd
Synthesizing initial hotplug events
Mounting filesystems
Starting syslogd and klogd
Running depmod
WARNING: Couldn't open directory /lib/modules/2.6.30-rc1-omap1: No such
file or directory
FATAL: Could not open /lib/modules/2.6.30-rc1-omap1/modules.dep.temp for
writing: No such file or directory
Starting inetd: 
Starting the dropbear ssh server: 
LCD panel file is not found
starting pid 1027, tty '': '/sbin/getty -L ttyS0 115200 vt100'


        Welcome to Logic's OMAP35x Embedded Linux Environment

!!!!! WARNING !!!!!!!

The default password for the root account is: root
please change this password using the 'passwd' command
and then edit this message (/etc/issue) to remove this message

OMAP-35x login: root
Password: 
OMAP-35x# lsusb
usb usb1: usb auto-resume
hub 1-0:1.0: hub_resume
hub 1-0:1.0: port 1: status 0507 change 0000
musb_port_suspend 105: Root port resuming, power f4
usb 1-1: usb auto-resume
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
musb_hub_control 344: port status 00040503
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
usb 1-1: finish resume
musb_ep_program 635: --> hw0 urb c7a27840 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
musb_ep_program 635: --> hw0 urb c7a27840 spd3 dev2 ep0out h_addr00
h_port00 bytes 8
Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc. 
Bus 001 Device 001: ID 1d6b:0002  
OMAP-35x# musb_ep_program 635: --> hw0 urb c7a27840 spd3 dev2 ep0out
h_addr00 h_port00 bytes 8
musb_port_suspend 78: Root port suspended, power f2
usb 1-1: usb auto-suspend
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend

OMAP-35x# 
OMAP-35x# At this point,unplug the hub
OMAP-35x# 
OMAP-35x# musb_stage2_irq 763: DISCONNECT (a_suspend) as Host, devctl 19
musb_stage2_irq 805: SUSPEND (a_wait_bcon) devctl 19 power e0
usb usb1: usb resume
hub 1-0:1.0: hub_resume
musb_hub_control 344: port status 00010100
hub 1-0:1.0: port 1: status 0100 change 0001
hub 1-0:1.0: state 7 ports 1 chg 0002 evt 0002
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
usb 1-1: USB disconnect, address 2
usb 1-1: unregistering device
usb 1-1: usb_disable_device nuking all URBs
usb 1-1: unregistering interface 1-1:1.0
usb 1-1:1.0: uevent
usb 1-1: uevent
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend

OMAP-35x# # insert the hub again, and nothing...
OMAP-35x# 

1) Has anyone gotten the MUSB in the latest PM branch working?

2) Outside of setting up the pinmux, is there anything else necessary to
get the MUSB to come up?

3) Any ideas on how to fix this?


-- 
Peter Barada <peterb@logicpd.com>
