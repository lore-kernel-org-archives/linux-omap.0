From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: musb (omap3) as host fails with reconnecting devices
Date: Mon, 13 Dec 2010 10:58:11 +0100
Message-ID: <4D05EE33.3060503@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

I've tried to use a BT-dongle attached via a Mini-A<->Std A cable to the 
OTG-port of a BeagleBoard Rev C4 (OMAP3530).

That devices needs a firmware and disconnects/reconnects with a new pid 
after it has received the firmware (ath3k).

I'm currently trying it with a kernel v2.6.37-rc5.

Using the device on an ehci-port it looks like that (which is as it 
should be):
----------------------------
Dec 11 09:16:04 beagle kernel: [  101.033325] usb 1-2.1: new full speed 
USB device using ehci-omap and address 4
Dec 11 09:16:04 beagle kernel: [  101.150970] usb 1-2.1: New USB device 
found, idVendor=0cf3, idProduct=3000
Dec 11 09:16:04 beagle kernel: [  101.151000] usb 1-2.1: New USB device 
strings: Mfr=0, Product=0, SerialNumber=0
Dec 11 09:16:04 beagle kernel: [  101.287048] Bluetooth: Atheros AR30xx 
firmware driver ver 1.0
Dec 11 09:16:04 beagle kernel: [  101.615844] usbcore: registered new 
interface driver ath3k
Dec 11 09:16:04 beagle kernel: [  101.814056] usb 1-2.1: USB disconnect, 
address 4
Dec 11 09:16:06 beagle kernel: [  103.080200] usb 1-2.1: new full speed 
USB device using ehci-omap and address 5
Dec 11 09:16:06 beagle kernel: [  103.198242] usb 1-2.1: New USB device 
found, idVendor=0cf3, idProduct=3005
Dec 11 09:16:06 beagle kernel: [  103.198242] usb 1-2.1: New USB device 
strings: Mfr=0, Product=0, SerialNumber=0
Dec 11 09:16:06 beagle kernel: [  103.324493] Bluetooth: Core ver 2.15
----------------------------


Because I haven't found another way to get musb_hdrc into host mode, I'm 
doing the following:

modprobe g_zero
echo host > /sys/devices/platform/musb_hdrc/mode

I've read somewhere thats because there is no id-change-irq available on 
omap<4 but I still wonder why the mini-a-cable is not recognized as such 
e.g. on startup (it was connected all the time).

Now the following happens when the driver (ath3k) will upload the new 
firmware to the device:

----------------------------
Dec 11 10:16:29 beagle kernel: [  147.498809] musb_giveback 325: 
complete cd04d500 usb_api_blocking_completion+0x0/0x14 (0), dev2 ep2out, 
4096/4096
Dec 11 10:16:29 beagle kernel: [  147.498962] musb_schedule 1885: qh 
cbcb6540 periodic slot 10
Dec 11 10:16:29 beagle kernel: [  147.498992] musb_start_urb 252: qh 
cbcb6540 urb cd04d500 dev2 ep2out-bulk, hw_ep 10, cbd55000/1024
Dec 11 10:16:29 beagle kernel: [  147.498992] musb_ep_program 706: --> 
hw10 urb cd04d500 spd2 dev2 ep2out h_addr00 h_port00 bytes 1024
Dec 11 10:16:29 beagle kernel: [  147.499023] dma_channel_program 167: 
ep10-Tx pkt_sz 64, dma_addr 0x8bd55000 length 1024, mode 1
Dec 11 10:16:29 beagle kernel: [  147.499053] configure_channel 130: 
ceb60e18, pkt_sz 64, addr 0x8bd55000, len 1024, mode 1
Dec 11 10:16:29 beagle kernel: [  147.499053] musb_start_urb 290: Start 
TX10 dma
Dec 11 10:16:29 beagle kernel: [  147.500030] dma_controller_irq 316: ch 
ceb60e18, 0x8bd55000 -> 0x8bd55400 (1024 / 1024) => complete


Dec 11 10:16:29 beagle kernel: [  147.500030] musb_g_tx 476: <== ep10in, 
txcsr b400

This is wrong and should be musb_t_tx (I assume it got changed to 
musb_g_tx because the device disconnects after it has received the new 
firmware).


Dec 11 10:16:29 beagle kernel: [  147.500061] dma_controller_irq 357: 
!!!!!!!!!!!!!! IRQ DONE !!!!!!!!!!!!!!
Dec 11 10:16:29 beagle kernel: [  147.500091] musb_interrupt 1596: ** 
IRQ peripheral usb0028 tx0000 rx0000
Dec 11 10:16:29 beagle kernel: [  147.500091] musb_stage0_irq 462: <== 
Power=e0, DevCtl=19, int_usb=0x28
Dec 11 10:16:29 beagle kernel: [  147.500122] musb_stage0_irq 784: 
DISCONNECT (a_host) as Host, devctl 19
Dec 11 10:16:29 beagle kernel: [  147.500152] musb_platform_try_idle 
130: a_wait_bcon inactive, for idle timer for 1101 ms
Dec 11 10:16:29 beagle kernel: [  147.500244] musb_hub_control 356: port 
status 00010100
Dec 11 10:16:29 beagle kernel: [  147.500274] musb_hub_control 290: 
clear feature 16
Dec 11 10:16:29 beagle kernel: [  147.500305] usb 2-1: USB disconnect, 
address 2
Dec 11 10:16:32 beagle kernel: [  150.493621] musb_urb_dequeue 2156: 
urb=cd04d500, dev2 ep2out
Dec 11 10:16:32 beagle kernel: [  150.493652] musb_cleanup_urb 2109: 
abort TX10 DMA for urb cd04d500 --> 0
Dec 11 10:16:32 beagle kernel: [  150.493682] musb_giveback 325: 
complete cd04d500 usb_api_blocking_completion+0x0/0x14 (0), dev2 ep2out, 
1024/1024
Dec 11 10:16:32 beagle kernel: [  150.493713] ath3k_load_firmware: Error 
in firmware loading err = -110,len = 1024, size = 1024
Dec 11 10:16:32 beagle kernel: [  150.493835] ath3k: probe of 2-1:1.0 
failed with error -5
Dec 11 10:16:32 beagle kernel: [  150.493988] usbcore: registered new 
interface driver ath3k
Dec 11 10:16:32 beagle kernel: [  150.494964] musb_hub_control 356: port 
status 00000100
Dec 11 10:16:32 beagle kernel: [  150.532531] musb_hub_control 356: port 
status 00000100
Dec 11 10:16:32 beagle kernel: [  150.571563] musb_hub_control 356: port 
status 00000100
Dec 11 10:16:32 beagle kernel: [  150.610626] musb_hub_control 356: port 
status 00000100
Dec 11 10:16:32 beagle kernel: [  150.649688] musb_hub_control 356: port 
status 00000100
----------------------------

When I now reenable the host mode, the device lost it's firmware and the 
same sequence starts again.

I almost know nothing about the musb-hw and reading the source it looks 
like that problem isn't easy to solve. So I haven't read any docs about 
the HW in question and just asking here for help.

Regards,

Alexander
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
