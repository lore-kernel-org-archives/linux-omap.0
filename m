From: Felipe Balbi <balbi@ti.com>
Subject: Re: musb (omap3) as host fails with reconnecting devices
Date: Tue, 21 Dec 2010 14:05:55 +0200
Message-ID: <20101221120555.GD2803@legolas.emea.dhcp.ti.com>
References: <4D05EE33.3060503@ahsoftware.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:44199 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828Ab0LUMGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 07:06:03 -0500
Content-Disposition: inline
In-Reply-To: <4D05EE33.3060503@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

Hi,

On Mon, Dec 13, 2010 at 10:58:11AM +0100, Alexander Holler wrote:
>I've tried to use a BT-dongle attached via a Mini-A<->Std A cable to 
>the OTG-port of a BeagleBoard Rev C4 (OMAP3530).
>
>That devices needs a firmware and disconnects/reconnects with a new 
>pid after it has received the firmware (ath3k).
>
>I'm currently trying it with a kernel v2.6.37-rc5.
>
>Using the device on an ehci-port it looks like that (which is as it 
>should be):
>----------------------------
>Dec 11 09:16:04 beagle kernel: [  101.033325] usb 1-2.1: new full 
>speed USB device using ehci-omap and address 4
>Dec 11 09:16:04 beagle kernel: [  101.150970] usb 1-2.1: New USB 
>device found, idVendor=0cf3, idProduct=3000
>Dec 11 09:16:04 beagle kernel: [  101.151000] usb 1-2.1: New USB 
>device strings: Mfr=0, Product=0, SerialNumber=0
>Dec 11 09:16:04 beagle kernel: [  101.287048] Bluetooth: Atheros 
>AR30xx firmware driver ver 1.0
>Dec 11 09:16:04 beagle kernel: [  101.615844] usbcore: registered new 
>interface driver ath3k
>Dec 11 09:16:04 beagle kernel: [  101.814056] usb 1-2.1: USB 
>disconnect, address 4
>Dec 11 09:16:06 beagle kernel: [  103.080200] usb 1-2.1: new full 
>speed USB device using ehci-omap and address 5
>Dec 11 09:16:06 beagle kernel: [  103.198242] usb 1-2.1: New USB 
>device found, idVendor=0cf3, idProduct=3005
>Dec 11 09:16:06 beagle kernel: [  103.198242] usb 1-2.1: New USB 
>device strings: Mfr=0, Product=0, SerialNumber=0
>Dec 11 09:16:06 beagle kernel: [  103.324493] Bluetooth: Core ver 2.15
>----------------------------
>
>
>Because I haven't found another way to get musb_hdrc into host mode, 
>I'm doing the following:
>
>modprobe g_zero
>echo host > /sys/devices/platform/musb_hdrc/mode
>
>I've read somewhere thats because there is no id-change-irq available 
>on omap<4 but I still wonder why the mini-a-cable is not recognized as 
>such e.g. on startup (it was connected all the time).

not so true. twl4030-usb has ID pin IRQ. Check what's the linkstatus
value on that driver. Enabling debugging for it should be enough.

>Now the following happens when the driver (ath3k) will upload the new 
>firmware to the device:
>
>----------------------------
>Dec 11 10:16:29 beagle kernel: [  147.498809] musb_giveback 325: 
>complete cd04d500 usb_api_blocking_completion+0x0/0x14 (0), dev2 
>ep2out, 4096/4096
>Dec 11 10:16:29 beagle kernel: [  147.498962] musb_schedule 1885: qh 
>cbcb6540 periodic slot 10
>Dec 11 10:16:29 beagle kernel: [  147.498992] musb_start_urb 252: qh 
>cbcb6540 urb cd04d500 dev2 ep2out-bulk, hw_ep 10, cbd55000/1024
>Dec 11 10:16:29 beagle kernel: [  147.498992] musb_ep_program 706: --> 
>hw10 urb cd04d500 spd2 dev2 ep2out h_addr00 h_port00 bytes 1024
>Dec 11 10:16:29 beagle kernel: [  147.499023] dma_channel_program 167: 
>ep10-Tx pkt_sz 64, dma_addr 0x8bd55000 length 1024, mode 1
>Dec 11 10:16:29 beagle kernel: [  147.499053] configure_channel 130: 
>ceb60e18, pkt_sz 64, addr 0x8bd55000, len 1024, mode 1
>Dec 11 10:16:29 beagle kernel: [  147.499053] musb_start_urb 290: 
>Start TX10 dma
>Dec 11 10:16:29 beagle kernel: [  147.500030] dma_controller_irq 316: 
>ch ceb60e18, 0x8bd55000 -> 0x8bd55400 (1024 / 1024) => complete
>
>
>Dec 11 10:16:29 beagle kernel: [  147.500030] musb_g_tx 476: <== 
>ep10in, txcsr b400
>
>This is wrong and should be musb_t_tx (I assume it got changed to 

did you mean musb_h_tx_start() ??

If you could enable debugging on twl403-usb.c driver
(drivers/usb/otg/twl4030-usb.c) and check what happens after you attach
the device, I'd be glad.

I was wondering if it was a VBUS error, but it doesn't seem like that as
DevCtl shows VBUS above VBUS Valid. So, for now, no clue.

-- 
balbi
