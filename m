From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: musb (omap3) as host fails with reconnecting devices
Date: Tue, 11 Jan 2011 16:55:38 +0100
Message-ID: <4D2C7D7A.4030801@ahsoftware.de>
References: <4D05EE33.3060503@ahsoftware.de> <20101221120555.GD2803@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1047321.serverkompetenz.net ([85.214.67.163]:52884 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab1AKPzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 10:55:45 -0500
In-Reply-To: <20101221120555.GD2803@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello and sorry for answering late.

Am 21.12.2010 13:05, schrieb Felipe Balbi:
> Hi,
>
> On Mon, Dec 13, 2010 at 10:58:11AM +0100, Alexander Holler wrote:
>> I've tried to use a BT-dongle attached via a Mini-A<->Std A cable to
>> the OTG-port of a BeagleBoard Rev C4 (OMAP3530).
>>
>> That devices needs a firmware and disconnects/reconnects with a new
>> pid after it has received the firmware (ath3k).
>>
>> I'm currently trying it with a kernel v2.6.37-rc5.
>>
>> Using the device on an ehci-port it looks like that (which is as it
>> should be):
>> ----------------------------
>> Dec 11 09:16:04 beagle kernel: [ 101.033325] usb 1-2.1: new full speed
>> USB device using ehci-omap and address 4
>> Dec 11 09:16:04 beagle kernel: [ 101.150970] usb 1-2.1: New USB device
>> found, idVendor=0cf3, idProduct=3000
>> Dec 11 09:16:04 beagle kernel: [ 101.151000] usb 1-2.1: New USB device
>> strings: Mfr=0, Product=0, SerialNumber=0
>> Dec 11 09:16:04 beagle kernel: [ 101.287048] Bluetooth: Atheros AR30xx
>> firmware driver ver 1.0
>> Dec 11 09:16:04 beagle kernel: [ 101.615844] usbcore: registered new
>> interface driver ath3k
>> Dec 11 09:16:04 beagle kernel: [ 101.814056] usb 1-2.1: USB
>> disconnect, address 4
>> Dec 11 09:16:06 beagle kernel: [ 103.080200] usb 1-2.1: new full speed
>> USB device using ehci-omap and address 5
>> Dec 11 09:16:06 beagle kernel: [ 103.198242] usb 1-2.1: New USB device
>> found, idVendor=0cf3, idProduct=3005
>> Dec 11 09:16:06 beagle kernel: [ 103.198242] usb 1-2.1: New USB device
>> strings: Mfr=0, Product=0, SerialNumber=0
>> Dec 11 09:16:06 beagle kernel: [ 103.324493] Bluetooth: Core ver 2.15
>> ----------------------------
>>
>>
>> Because I haven't found another way to get musb_hdrc into host mode,
>> I'm doing the following:
>>
>> modprobe g_zero
>> echo host > /sys/devices/platform/musb_hdrc/mode
>>
>> I've read somewhere thats because there is no id-change-irq available
>> on omap<4 but I still wonder why the mini-a-cable is not recognized as
>> such e.g. on startup (it was connected all the time).
>
> not so true. twl4030-usb has ID pin IRQ. Check what's the linkstatus
> value on that driver. Enabling debugging for it should be enough.
>
>> Now the following happens when the driver (ath3k) will upload the new
>> firmware to the device:
>>
>> ----------------------------
>> Dec 11 10:16:29 beagle kernel: [ 147.498809] musb_giveback 325:
>> complete cd04d500 usb_api_blocking_completion+0x0/0x14 (0), dev2
>> ep2out, 4096/4096
>> Dec 11 10:16:29 beagle kernel: [ 147.498962] musb_schedule 1885: qh
>> cbcb6540 periodic slot 10
>> Dec 11 10:16:29 beagle kernel: [ 147.498992] musb_start_urb 252: qh
>> cbcb6540 urb cd04d500 dev2 ep2out-bulk, hw_ep 10, cbd55000/1024
>> Dec 11 10:16:29 beagle kernel: [ 147.498992] musb_ep_program 706: -->
>> hw10 urb cd04d500 spd2 dev2 ep2out h_addr00 h_port00 bytes 1024
>> Dec 11 10:16:29 beagle kernel: [ 147.499023] dma_channel_program 167:
>> ep10-Tx pkt_sz 64, dma_addr 0x8bd55000 length 1024, mode 1
>> Dec 11 10:16:29 beagle kernel: [ 147.499053] configure_channel 130:
>> ceb60e18, pkt_sz 64, addr 0x8bd55000, len 1024, mode 1
>> Dec 11 10:16:29 beagle kernel: [ 147.499053] musb_start_urb 290: Start
>> TX10 dma
>> Dec 11 10:16:29 beagle kernel: [ 147.500030] dma_controller_irq 316:
>> ch ceb60e18, 0x8bd55000 -> 0x8bd55400 (1024 / 1024) => complete
>>
>>
>> Dec 11 10:16:29 beagle kernel: [ 147.500030] musb_g_tx 476: <==
>> ep10in, txcsr b400
>>
>> This is wrong and should be musb_t_tx (I assume it got changed to
>
> did you mean musb_h_tx_start() ??

No, sorry, something like a typo. That should have been musb_host_tx.

The problem here is that the response to an already completed dma 
transfer in the past is decided because of a current state (devctl & 
MUSB_DEVCTL_HM). Therefor that will fail for all transfers, when the 
device disconnects right after it has received such a transfer. That 
means the the transfer occured while beeing in host state, but the 
response to transfer is generated as a response to a transfer in gadget 
mode, which then returns an error, even if that transfer was ok.

> If you could enable debugging on twl403-usb.c driver
> (drivers/usb/otg/twl4030-usb.c) and check what happens after you attach
> the device, I'd be glad.

Sorry, I will need some more time to do that, but I will do that this week.

Regards,

Alexander
