From: Bryan Wu <bryan.wu@analog.com>
Subject: [Question] Always got STALL in MUSB Host driver
Date: Thu, 15 Nov 2007 18:48:57 +0800
Message-ID: <1195123737.3698.24.camel@roc-desktop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear Tony and David, 

I struggled in MUSB driver of Blackfin for a long time. Currently, usb
device mode should be ok, but USB host mode driver still got weird
response.

Blackfin BF54x USB OTG contoller is a single port OTG controller, which
has EP0 to EP7 8 bi-directional endpoints. And EP0 FIFO size is 64 x 2,
EP1 to EP4 FIFO size is 128 x 2 and EP5 to EP7 is 1024 x 2, totally 7232
bytes. So EP5 is selected as musb->bulk_ep.

Double buffering is automatically as Hardware manual said:

"Each endpoint FIFO can buffer one or two packets (in double-buffered
mode). The double buffered mode is automatically enabled when the soft-
ware programs a maximum packet size for an endpoint that is less than
half the actual FIFO size for that endpoint. Double-buffering is recom-
mended for most applications to improve efficiency by reducing the
frequency with which each endpoint needs to be serviced."

I noticed the comments of musb_host.c:
"+ double buffered OUT/TX endpoints saw stalls(!) with certain usbtest
*       configurations, but otherwise double buffering passes basic
tests."

And my driver always got STALL in IN/RX endpoints as below (USB device
is a high-speed 1G USB Flash disk):
---
Start INQUIRY SCSI command:
1. send out 31 bytes to ep2out-bulk (though hardware EP5 OUT)

musb_start_urb 214: qh 03bfd520 urb 03b79800 dev2 ep2out-bulk, hw_ep 5, 03bfda60/31
musb_ep_program 653: --> hw5 urb 03b79800 spd3 dev2 ep2out h_addr00 h_port00 bytes 31
musb_write_fifo 112: TX ep5 fifo ffc03ca8 count 31 buf 03bfda60
musb_start_urb 256: Start TX5 pio
musb_interrupt 1582: ** IRQ host usb0008 tx0020 rx0000
musb_host_tx 1194: OUT/TX5 end, csr 2000
__musb_giveback 304: complete 03b79800 (0), dev2 ep2out, 31/31

2. wait for 36 bytes from ep1in-bulk (though hardware EP5 IN)
musb_start_urb 214: qh 03bfd520 urb 0301d200 dev2 ep1in-bulk, hw_ep 5, 030000c0/36
musb_ep_program 653: <-- hw5 urb 0301d200 spd3 dev2 ep1in h_addr00 h_port00 bytes 36
musb_interrupt 1582: ** IRQ host usb0008 tx0000 rx0020
musb_host_rx 1419: <== hw 5 rxcsr 0040, urb actual 0 (+dma 0)
musb_host_rx 1424: RX end 5 STALL
__musb_giveback 304: complete 0301d200 (-32), dev2 ep1in, 0/36

Got STALL here

musb_start_urb 214: qh 03bfd520 urb 03b79800 dev2 ep0out, hw_ep 0, 0300a500/8
musb_ep_program 653: --> hw0 urb 03b79800 spd3 dev2 ep0out h_addr00 h_port00 bytes 8
musb_write_fifo 112: TX ep0 fifo ffc03c80 count 8 buf 0300a500
musb_start_urb 256: Start TX0 pio
musb_interrupt 1582: ** IRQ host usb0008 tx0001 rx0000
musb_h_ep0_irq 1043: <== csr0 0000, qh 03bfd520, count 0, urb 03b79800, stage 1
musb_h_ep0_continue 978: start no-DATA
musb_h_ep0_irq 1132: ep0 STATUS, csr 0060
musb_interrupt 1582: ** IRQ host usb0008 tx0001 rx0000
musb_h_ep0_irq 1043: <== csr0 0041, qh 03bfd520, count 0, urb 03b79800, stage 4
__musb_giveback 304: complete 03b79800 (0), dev2 ep0out, 0/0

3. wait for 13 bytes from ep1in-bulk (though hardware EP5 IN)
musb_start_urb 214: qh 03bfd520 urb 03b79800 dev2 ep1in-bulk, hw_ep 5, 03bfda60/13
musb_ep_program 653: <-- hw5 urb 03b79800 spd3 dev2 ep1in h_addr00 h_port00 bytes 13
musb_interrupt 1582: ** IRQ host usb0008 tx0000 rx0020
musb_host_rx 1419: <== hw 5 rxcsr 0040, urb actual 0 (+dma 0)
musb_host_rx 1424: RX end 5 STALL
__musb_giveback 304: complete 03b79800 (-32), dev2 ep1in, 0/13

Got STALL again.
----

Is this issue related with double buffering or other setting?
If you guys got any idea, please give me some help.
Because my USB protocol analyzer is broken, I can't get some help from the instrument.

Thanks a lot
-Bryan Wu
