From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: Question about USB mass storage on omap2420
Date: Fri, 26 May 2006 08:21:40 +0900
Message-ID: <001201c68051$fa978c60$c7a3580a@swcenter.sec.samsung.co.kr>
References: <EA12F909C0431D458B9D18A176BEE4A505E492AE@dlee02.ent.ti.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <EA12F909C0431D458B9D18A176BEE4A505E492AE@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

> The current usb source code can't support omap2420 but it's not
difficult
> to port from TI web 2.6.9 kernel Now USB gadget is working and the
windows
> recognizes the removable disk, and File-backed Storage Gadget.
> But I can't see real disk drive.

What do you mean real disks?

=> When attaching USB flash drive to windows, we can see the contents of
flash drivers. like this, apollon also has same behavior as removable disk
Now I only concern with the usb gadget, especialy "File-backed Storage
Gadget"

config USB_FILE_STORAGE
        tristate "File-backed Storage Gadget"
        help
          The File-backed Storage Gadget acts as a USB Mass Storage
          disk drive.  As its storage repository it can use a regular
          file or a block device (in much the same way as the "loop"
          device driver), specified as a module parameter.

Above you are talking about the OMAP-USB-Device working for you when
compiled on.  This is good.  The OMAP-USB-Device can assume many profiles.

I generally associate real disks with things like USB flash drives.
These are associated with OMAP-USB-Host.

If you want OMAP-USB-Host you need to compile that on and add needed client
drivers to handle host.  There are 3 combinations:
  host only (arch-init code + ohci driver + transceiver driver)
  device only (arch-init code + omap_udc driver + transceiver driver)
  OTG (arch-init code + ohci + omap_udc + transceiver)

=> currently I want to enable device only, in fact, apollon board can
support the both USB-device(usb0) and USB-host(usb1)

following is the arch-init code and console message after kernel booting.


% arch-init

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
omap2/board-apollon.c
index 6c6ba17..819824f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -174,6 +174,15 @@ static struct omap_mmc_config apollon_mm
        },
 };

+static struct omap_usb_config apollon_usb_config __initdata = {
+       .register_dev           = 1,
+       .register_host          = 1,
+       .hmc_mode               = 0x14, // 0:dev 1: host1 2: disable
+
+       .pins[0]                = 6,
+       .pins[1]                = 4,
+};
+
 static struct omap_lcd_config apollon_lcd_config __initdata = {
        .ctrl_name      = "internal",
 };
@@ -181,6 +190,7 @@ static struct omap_lcd_config apollon_lc
 static struct omap_board_config_kernel apollon_config[] = {
        { OMAP_TAG_UART,        &apollon_uart_config },
        { OMAP_TAG_MMC,         &apollon_mmc_config },
+       { OMAP_TAG_USB,         &apollon_usb_config },
        { OMAP_TAG_LCD,         &apollon_lcd_config },
 };

OMAP USB0 mux settings

Muxing J20_24XX_USB0_PUEN (0x4800011d): 0x00 -> 0x00
Muxing K18_24XX_USB0_DAT (0x48000123): 0x00 -> 0x00
Muxing K19_24XX_USB0_TXEN (0x48000121): 0x00 -> 0x00
Muxing J14_24XX_USB0_SE0 (0x48000122): 0x00 -> 0x00
Muxing J18_24XX_USB0_RCV (0x48000120): 0x00 -> 0x00
Muxing J19_24XX_USB0_VP (0x4800011e): 0x00 -> 0x00
Muxing K20_24XX_USB0_VM (0x4800011f): 0x00 -> 0x00

USB: hmc 20, usb0 6 wires (dev), usb1 4 wires

udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
udc: OMAP UDC rev 6.1
udc: hmc mode 20, integrated transceiver
udc: fifo mode 3, 392 bytes not used

/ # cat /proc/interrupts
           CPU0
 12:          0   DMA
 38:       6015   gp timer
 72:        224   serial
 75:          0   omap_udc
 76:          0   omap_udc pio
 77:          0   omap_udc iso
176:          0   enter sw
177:          0   up sw
218:          0   down sw
234:       3000   eth0
Err:          0

/ # loading file_storage gadget
g_file_storage gadget: File-backed Storage Gadget, version: 28 November 2005
g_file_storage gadget: Number of LUNs=1
g_file_storage gadget-lun0: ro=0, file: /var/fat-test-image

/ # cat /proc/driver/udc
OMAP UDC driver, version: 4 October 2004 (iso) (dma)
UDC rev 6.1, fifo mode 3, gadget g_file_storage
hmc 20, transceiver (none)

OTG rev 3.4, transceiver_ctrl 200000
otg_syscon1 00138004 usb2 unused, usb1 4wire, usb0 6wire, !otg reset_done
otg_syscon2 40040114 synchro uhost_en b_ase_brst=4 hmc=20
otg_ctrl    0d8010 bsess_end bsess id DEVICE up
otg_irq_en  0000
otg_irq_src 0001
otg_outctrl 0000
otg_test    0000

syscon1     0105 cfg_lock self_pwr PULLUP
devstat     000f CFG ADD DEF ATT
sof         1ad2
irq_en      0039 epn_rx epn_tx ds_chg ep0
irq_src     0080 sof
dma_irq_en  0500 tx2_done rx2_eot
rxdma_cfg   1200
rxdma[2]    8000
txdma_cfg   1100
txdma[2]    c000

ep0 irqs 60 stat 0000
        (queue empty)

ep1in-bulk (txdma2 lch0) dbuf irqs 4 stat 0000
        req c0764a1c len 13/13 buf c7dc8000

ep2out-bulk (rxdma2 lch1) dbuf irqs 2 stat 0004 fifo_en
        req c07648ec len 32/64 buf c7dc4000


The H4 board also likely has 2 transceivers attached.  You likely want to
use the OTG one.  I seem to recall both attach to USB0 so you can only use
one at a time.

=> Yes I know. but we don't care OTG case. we assign the each port host and
device separately.

At the 2.6.9 -> 2.6.10 level as can be found on the web I initially did
some amount of checking for usb-device only and usb-host only.  I don't
think the OTG was fully working with the public code.  Others have touched
that code since then so it might be working more, but I'm don't recall it.

=> Is there's some change? from 2.6.9 to 2.6.10?

Regards,
Kyungmin Park
