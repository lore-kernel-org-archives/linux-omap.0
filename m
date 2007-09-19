From: "Nazim Khan" <nazim.asad@gmail.com>
Subject: Issue with the USB Host Controller DMA Mode on Davinci Board
	(broken !rx_reinit)
Date: Wed, 19 Sep 2007 11:31:08 +0530
Message-ID: <ef9503490709182301lf521c1byeb144224685a8a3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

I am trying to get my Wireless Card working with MUSB DMA Mode enabled
at full speed.
The moment I insert Zydas modules the musb starts giving me following
rx_reinit errors.
(Without DMA Mode Enable, the driver works fine).

I observe the same problem while connecting the device in high speed mode also.
Though enabling the DMA mode is working fine with my High Speed USB Disk.

Any clues what could be going wrong here?

Kernel 2.6.18
USB Wireless Adapter - Zydas 1211b

------------------ Console Snapshot ---------------------
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Starting Host Controller
musb_hdrc: version 2.2a/db-0.5.1/dbg, cppi-dma, host, debug=3
musb_hdrc: USB Host mode controller at c5002000 using DMA, IRQ 12
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.18 musb-hcd
usb usb1: SerialNumber: musb_hdrc
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb 1-1: new full speed USB device using musb_hdrc and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
musb_ep_program 899: broken !rx_reinit, ep3 csr 3200
musb_ep_program 899: broken !rx_reinit, ep3 csr 3000
usb 1-1.2: new full speed USB device using musb_hdrc and address 3
usb 1-1.2: not running at top speed; connect to a high speed hub
usb 1-1.2: Product: USB2.0 WLAN
usb 1-1.2: Manufacturer: ZyDAS
usb 1-1.2: configuration #1 chosen from 1 choice
Starting Zydas
ZD1211B - version 2.18.0.0
vendor_id = 0ace
product_id = 1215
USB 1.1 Host
Release Ver = 4810
EEPORM Ver = 4810
Finsih download Firmware. Ready to reboot
musb_ep_program 899: broken !rx_reinit, ep4 csr 3200
musb_ep_program 899: broken !rx_reinit, ep4 csr 3000
musb_ep_program 899: broken !rx_reinit, ep4 csr 3200
musb_ep_program 899: broken !rx_reinit, ep4 csr 3000
PA type: 0
PHYNEWLayout = 1
Airoha AL2230S_RF
musb_ep_program 899: broken !rx_reinit, ep4 csr 3200
musb_ep_program 899: broken !rx_reinit, ep4 csr 3000
musb_ep_program 899: broken !rx_reinit, ep4 csr 3200
musb_ep_program 899: broken !rx_reinit, ep4 csr 3000
musb_ep_program 899: broken !rx_reinit, ep4 csr 3200
AllowedChannel = 000107ff
Region:16
musb_ep_program 899: broken !rx_reinit, ep4 csr 3000
musb_ep_program 899: broken !rx_reinit, ep4 csr 3200

-----------------------------------------------------------------------------------------
