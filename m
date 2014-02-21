From: Chris Kimber <chris.kimber@enatel.net>
Subject: RE: USB lockups on BeagleBone/AM335x
Date: Fri, 21 Feb 2014 00:11:40 +0000
Message-ID: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C96@SRVEXCH01.enatel.local>
References: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C07@SRVEXCH01.enatel.local>
 <20140220224902.GB10878@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.enatel.co.nz ([131.203.63.198]:1912 "EHLO
	mail.enatel.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439AbaBUALt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Feb 2014 19:11:49 -0500
In-Reply-To: <20140220224902.GB10878@saruman.home>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "balbi@ti.com" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hey,

Thanks for the response.

I've disabled the DMA (CONFIG_MUSB_PIO_ONLY=y) but the problem still persists (for both USB sticks & USB serial ports).

Now it looks like dsps_interrupt() never fires and causes the hang up...

[   94.865635] tty ttyUSB0: serial_write - 11 byte(s)
[   94.865656] cp210x ttyUSB0: usb_serial_generic_write_start - length = 11, data = 54 45 53 54 49 4e 47 20 34 32 0a
[   94.865680] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot 10
[   94.865700] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 dev2 ep1out-bulk, hw_ep 10, ce43db00/11
[   94.865721] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2 dev2 ep1out h_addr00 h_port00 bytes 11
[   94.865740] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 count 11 buf ce43db00
[   94.865755] musb-hdrc musb-hdrc.1.auto: Start TX10 pio
[   94.865792] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(400)
[   94.865810] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0400 rx0000
[   94.865826] musb-hdrc musb-hdrc.1.auto: OUT/TX10 end, csr 2100
[   94.865866] musb-hdrc musb-hdrc.1.auto: complete ce481e80 usb_serial_generic_write_bulk_callback+0x0/0xd4 [usbserial] (0), dev2 ep1out, 11/11

[   94.865971] tty ttyUSB0: serial_write - 11 byte(s)
[   94.865991] cp210x ttyUSB0: usb_serial_generic_write_start - length = 11, data = 54 45 53 54 49 4e 47 20 34 33 0a
[   94.866015] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot 10
[   94.866035] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 dev2 ep1out-bulk, hw_ep 10, ce43db00/11
[   94.866055] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2 dev2 ep1out h_addr00 h_port00 bytes 11
[   94.866075] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 count 11 buf ce43db00
[   94.866089] musb-hdrc musb-hdrc.1.auto: Start TX10 pio

Chris

-----Original Message-----
From: Felipe Balbi [mailto:balbi@ti.com] 
Sent: Friday, 21 February 2014 11:49 a.m.
To: Chris Kimber
Cc: linux-omap@vger.kernel.org
Subject: Re: USB lockups on BeagleBone/AM335x

Hi,

On Thu, Feb 20, 2014 at 10:39:00PM +0000, Chris Kimber wrote:
> Hi,
> 
> I've been experiencing USB issues with a BeagleBone white rev A5.
> I've not seen any symptoms with the TI 3.2 kernel but I need to get 
> access to some of the later drivers and didn't fancy back porting...
> 
> So I've tried 3.8, 3,12 & 3.13 kernels with the patches from 
> https://github.com/beagleboard/kernel and they seem to be able to talk 
> to a USB memory stick but when making use of a cp210x and ftdi_sio 
> based USB to UART adaptor the controller hangs.
> 
> I've also tried linux-next, linux-usb and now linux-omap3 and they 
> seem to be more unstable and even communicating with a USB stick seems 
> flaky.
> 
> I've got a test app that just writes "TESTING <count>\n" to the tty 
> for ever.
> 
> Here's some dmesg from linux-omap3 (1fbb354). I've added -DDEBUG to 
> drivers/usb/{musb, serial}.
> 
> OK:
> [   16.573781] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.573802] cp210x ttyUSB0: usb_serial_generic_write_start - length = 11, data = 54 45 53 54 49 4e 47 20 34 32 0a
> [   16.573825] musb-hdrc musb-hdrc.1.auto: qh ce474b00 periodic slot 10
> [   16.573846] musb-hdrc musb-hdrc.1.auto: qh ce474b00 urb ce489700 dev2 ep1out-bulk, hw_ep 10, ce44f700/11
> [   16.573866] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce489700 spd2 dev2 ep1out h_addr00 h_port00 bytes 11
> [   16.573887] musb-hdrc musb-hdrc.1.auto: configure ep10/a4 packet_sz=64, mode=0, dma_addr=0x8e44f700, len=11 is_tx=1
> [   16.573905] musb-hdrc musb-hdrc.1.auto: Start TX10 dma
> [   16.573928] musb-hdrc musb-hdrc.1.auto: DMA transfer done on hw_ep=10 bytes=11/11
> [   16.573945] musb-hdrc musb-hdrc.1.auto: OUT/TX10 end, csr 3500, dma
> [   16.573986] musb-hdrc musb-hdrc.1.auto: complete ce489700 usb_serial_generic_write_bulk_callback+0x0/0xd4 [usbserial] (0), dev2 ep1out, 11/11
> 
> FAIL:
> [   16.574085] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574106] cp210x ttyUSB0: usb_serial_generic_write_start - length = 11, data = 54 45 53 54 49 4e 47 20 34 33 0a
> [   16.574129] musb-hdrc musb-hdrc.1.auto: qh ce474b00 periodic slot 10
> [   16.574149] musb-hdrc musb-hdrc.1.auto: qh ce474b00 urb ce489700 dev2 ep1out-bulk, hw_ep 10, ce44f700/11
> [   16.574169] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce489700 spd2 dev2 ep1out h_addr00 h_port00 bytes 11
> [   16.574191] musb-hdrc musb-hdrc.1.auto: configure ep10/a4 packet_sz=64, mode=0, dma_addr=0x8e44f700, len=11 is_tx=1
> [   16.574208] musb-hdrc musb-hdrc.1.auto: Start TX10 dma
> [   16.574231] musb-hdrc musb-hdrc.1.auto: DMA transfer done on hw_ep=10 bytes=11/11
> [   16.574302] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574322] cp210x ttyUSB0: usb_serial_generic_write_start - length = 11, data = 54 45 53 54 49 4e 47 20 34 34 0a
> [   16.574381] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574452] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574508] tty ttyUSB0: serial_write - 11 byte(s)
> ...
> [   16.930271] tty ttyUSB0: serial_write - 1 byte(s)
> 
> Then my test app blocks.
> 
> It looks like in the first fail case the DMA "succeeds", but the USB 
> controller doesn't send the frame and consequently the TXPKTRDY bit in 
> the csr register never gets cleared. Thus musb_is_tx_fifo_empty() 
> always returns false and consequently falls into
> cppi41_recheck_tx_req() waiting for the queue to clear.  Eventually we 
> must fill up some buffer and cause my sending app to block.
> 
> I've tried to force the FIFO to flush by setting the appropriate bits 
> in the csr after a timeout and that doesn't seem to do anything.
> 
> If I try and reboot the platform I get a punch of  warnings:
> 
> / # reboot
> The system is going down NOW!
> Sent SIGTERM to all processes
> [  990.007339] ------------[ cut here ]------------ [  990.014193] 
> WARNING: CPU: 0 PID: 100 at drivers/dma/cppi41.c:605 
> cppi41_dma_control+0x230/0x2a8() [  990.023567] Modules linked in: 
> cp210x usbserial [  990.028383] CPU: 0 PID: 100 Comm: blast Not 
> tainted 3.14.0-rc2+ #3 [  990.034967] [<c00148d8>] (unwind_backtrace) 
> from [<c00115cc>] (show_stack+0x10/0x14) [  990.043179] [<c00115cc>] 
> (show_stack) from [<c073b784>] (dump_stack+0x68/0x84) [  990.050823] 
> [<c073b784>] (dump_stack) from [<c003a4b0>] 
> (warn_slowpath_common+0x64/0x88) [  990.059375] [<c003a4b0>] 
> (warn_slowpath_common) from [<c003a4ec>] 
> (warn_slowpath_null+0x18/0x1c) [  990.068656] [<c003a4ec>] 
> (warn_slowpath_null) from [<c0434cf8>] 
> (cppi41_dma_control+0x230/0x2a8) [  990.077948] [<c0434cf8>] 
> (cppi41_dma_control) from [<c0543610>] 
> (cppi41_dma_channel_abort+0x108/0x148)
> [  990.087801] [<c0543610>] (cppi41_dma_channel_abort) from 
> [<c053e5c8>] (musb_cleanup_urb+0x40/0x100) [  990.097364] [<c053e5c8>] 
> (musb_cleanup_urb) from [<c053e7a8>] (musb_urb_dequeue+0x120/0x154) [  
> 990.106293] [<c053e7a8>] (musb_urb_dequeue) from [<c05240e0>] 
> (unlink1+0xb4/0xc4) [  990.114206] [<c05240e0>] (unlink1) from 
> [<c05254c8>] (usb_hcd_unlink_urb+0x60/0x80) [  990.122304] 
> [<c05254c8>] (usb_hcd_unlink_urb) from [<c052637c>] 
> (usb_kill_urb+0x50/0xc8) [  990.130917] [<c052637c>] (usb_kill_urb) 
> from [<bf002c90>] (usb_serial_generic_close+0x20/0x64 [usbserial]) [  
> 990.141145] [<bf002c90>] (usb_serial_generic_close [usbserial]) from 
> [<bf00fe88>] (cp210x_close+0xc/0x28 [cp210x]) [  990.152094] 
> [<bf00fe88>] (cp210x_close [cp210x]) from [<bf000024>] 
> (serial_port_shutdown+0x24/0x28 [usbserial]) [  990.162771] 
> [<bf000024>] (serial_port_shutdown [usbserial]) from [<c044d484>] 
> (tty_port_shutdown+0x6c/0x78) [  990.173071] [<c044d484>] 
> (tty_port_shutdown) from [<c044dee8>] (tty_port_close+0x24/0x4c) [  
> 990.181733] [<c044dee8>] (tty_port_close) from [<c0446120>] 
> (tty_release+0x118/0x49c) [  990.190029] [<c0446120>] (tty_release) 
> from [<c012c600>] (__fput+0xd4/0x1e4) [  990.197498] [<c012c600>] 
> (__fput) from [<c0055974>] (task_work_run+0xb4/0xc8) [  990.205045] 
> [<c0055974>] (task_work_run) from [<c003cae0>] (do_exit+0x3f8/0x948) [  
> 990.212865] [<c003cae0>] (do_exit) from [<c003d0f4>] 
> (do_group_exit+0x98/0xd4) [  990.220512] [<c003d0f4>] (do_group_exit) 
> from [<c004a9c4>] (get_signal_to_deliver+0x510/0x58c)
> [  990.229616] [<c004a9c4>] (get_signal_to_deliver) from [<c0010a28>] 
> (do_signal+0xa8/0x3b8) [  990.238260] [<c0010a28>] (do_signal) from 
> [<c0011034>] (do_work_pending+0x54/0x9c) [  990.246264] [<c0011034>] 
> (do_work_pending) from [<c000dea0>] (work_pending+0xc/0x20) [  
> 990.254441] ---[ end trace 6bbc95d827ba3e8c ]---
> 
> [  991.506236] ------------[ cut here ]------------ [  991.511118] 
> WARNING: CPU: 0 PID: 100 at drivers/usb/musb/musb_host.c:128 
> musb_h_tx_flush_fifo+0x78/0xc4() [  991.521219] Could not flush host 
> TX10 fifo: csr: 2503 [  991.526552] Modules linked in: cp210x usbserial
> [  991.531352] CPU: 0 PID: 100 Comm: blast Tainted: G        W    3.14.0-rc2+ #3
> [  991.538897] [<c00148d8>] (unwind_backtrace) from [<c00115cc>] 
> (show_stack+0x10/0x14) [  991.547081] [<c00115cc>] (show_stack) from 
> [<c073b784>] (dump_stack+0x68/0x84) [  991.554713] [<c073b784>] 
> (dump_stack) from [<c003a4b0>] (warn_slowpath_common+0x64/0x88) [  
> 991.563262] [<c003a4b0>] (warn_slowpath_common) from [<c003a554>] 
> (warn_slowpath_fmt+0x2c/0x3c) [  991.572456] [<c003a554>] 
> (warn_slowpath_fmt) from [<c053ccf0>] (musb_h_tx_flush_fifo+0x78/0xc4) 
> [  991.581651] [<c053ccf0>] (musb_h_tx_flush_fifo) from [<c053e62c>] 
> (musb_cleanup_urb+0xa4/0x100) [  991.590844] [<c053e62c>] 
> (musb_cleanup_urb) from [<c053e7a8>] (musb_urb_dequeue+0x120/0x154) [  
> 991.599759] [<c053e7a8>] (musb_urb_dequeue) from [<c05240e0>] 
> (unlink1+0xb4/0xc4) [  991.607669] [<c05240e0>] (unlink1) from 
> [<c05254c8>] (usb_hcd_unlink_urb+0x60/0x80) [  991.615762] 
> [<c05254c8>] (usb_hcd_unlink_urb) from [<c052637c>] 
> (usb_kill_urb+0x50/0xc8) [  991.624329] [<c052637c>] (usb_kill_urb) 
> from [<bf002c90>] (usb_serial_generic_close+0x20/0x64 [usbserial]) [  
> 991.634544] [<bf002c90>] (usb_serial_generic_close [usbserial]) from 
> [<bf00fe88>] (cp210x_close+0xc/0x28 [cp210x]) [  991.645487] 
> [<bf00fe88>] (cp210x_close [cp210x]) from [<bf000024>] 
> (serial_port_shutdown+0x24/0x28 [usbserial]) [  991.656156] 
> [<bf000024>] (serial_port_shutdown [usbserial]) from [<c044d484>] 
> (tty_port_shutdown+0x6c/0x78) [  991.666452] [<c044d484>] 
> (tty_port_shutdown) from [<c044dee8>] (tty_port_close+0x24/0x4c) [  
> 991.675095] [<c044dee8>] (tty_port_close) from [<c0446120>] 
> (tty_release+0x118/0x49c) [  991.683372] [<c0446120>] (tty_release) 
> from [<c012c600>] (__fput+0xd4/0x1e4) [  991.690824] [<c012c600>] 
> (__fput) from [<c0055974>] (task_work_run+0xb4/0xc8) [  991.698368] 
> [<c0055974>] (task_work_run) from [<c003cae0>] (do_exit+0x3f8/0x948) [  
> 991.706184] [<c003cae0>] (do_exit) from [<c003d0f4>] 
> (do_group_exit+0x98/0xd4) [  991.713821] [<c003d0f4>] (do_group_exit) 
> from [<c004a9c4>] (get_signal_to_deliver+0x510/0x58c)
> [  991.722921] [<c004a9c4>] (get_signal_to_deliver) from [<c0010a28>] 
> (do_signal+0xa8/0x3b8) [  991.731564] [<c0010a28>] (do_signal) from 
> [<c0011034>] (do_work_pending+0x54/0x9c) [  991.739561] [<c0011034>] 
> (do_work_pending) from [<c000dea0>] (work_pending+0xc/0x20) [  
> 991.747736] ---[ end trace 6bbc95d827ba3e8e ]---
> 
> Full dmesg: https://gist.github.com/anonymous/9124604
> 
> Anyone have any ideas on where else to look? 
> 
> I've put my defconfig here https://gist.github.com/anonymous/9124565
> (it's based from the 3.13 one from the beagleboard github) just in 
> case there is anything stupid going on.
> 
> Is the USB in a known state of flux?

the short answer: yes

The long answer:

AM335x ES1.0 silicon (the one you have on your BBW) has many, many, many known silicon bugs (mostly around CPPI 4.1 - the DMA controller) and it's *very* difficult to have a stable USB with DMA on that device.

Surely we shouldn't have such failures, but it takes time and effort to fix all of that in a way that doesn't regress any of the other numerous platforms the MUSB driver supports.

Just to make sure this is a DMA problem, can you see if disabling DMA altogether makes the test work ? (beware, throughput will *suck*).

cheers

--
balbi
