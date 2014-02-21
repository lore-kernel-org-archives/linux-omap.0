From: Chris Kimber <chris.kimber@enatel.net>
Subject: Re: USB lockups on BeagleBone/AM335x
Date: Fri, 21 Feb 2014 15:27:09 +1300
Message-ID: <5306B97D.8070306@enatel.net>
References: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C07@SRVEXCH01.enatel.local> <20140220224902.GB10878@saruman.home> <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C96@SRVEXCH01.enatel.local> <20140221011405.GB19336@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.enatel.co.nz ([131.203.63.198]:1808 "EHLO
	mail.enatel.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaBUC1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Feb 2014 21:27:17 -0500
In-Reply-To: <20140221011405.GB19336@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "balbi@ti.com" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hey

On 21/02/2014 2:14 p.m., Felipe Balbi wrote:
> Hi,
>
> (please avoid top-posting)
>
> On Fri, Feb 21, 2014 at 12:11:40AM +0000, Chris Kimber wrote:
>> Hey,
>>
>> Thanks for the response.
>>
>> I've disabled the DMA (CONFIG_MUSB_PIO_ONLY=y) but the problem still
>> persists (for both USB sticks & USB serial ports).
> hmm, that's weird.
>
>> Now it looks like dsps_interrupt() never fires and causes the hang
>> up...
>>
>> [   94.865635] tty ttyUSB0: serial_write - 11 byte(s)
>> [   94.865656] cp210x ttyUSB0: usb_serial_generic_write_start - length = 11, data = 54 45 53 54 49 4e 47 20 34 32 0a
>> [   94.865680] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot 10
>> [   94.865700] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 dev2 ep1out-bulk, hw_ep 10, ce43db00/11
>> [   94.865721] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2 dev2 ep1out h_addr00 h_port00 bytes 11
>> [   94.865740] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 count 11 buf ce43db00
>> [   94.865755] musb-hdrc musb-hdrc.1.auto: Start TX10 pio
>> [   94.865792] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(400)
>> [   94.865810] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0400 rx0000
>> [   94.865826] musb-hdrc musb-hdrc.1.auto: OUT/TX10 end, csr 2100
>> [   94.865866] musb-hdrc musb-hdrc.1.auto: complete ce481e80 usb_serial_generic_write_bulk_callback+0x0/0xd4 [usbserial] (0), dev2 ep1out, 11/11
> so the first one completed just fine.
>
>> [   94.865971] tty ttyUSB0: serial_write - 11 byte(s)
>> [   94.865991] cp210x ttyUSB0: usb_serial_generic_write_start - length = 11, data = 54 45 53 54 49 4e 47 20 34 33 0a
>> [   94.866015] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot 10
>> [   94.866035] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 dev2 ep1out-bulk, hw_ep 10, ce43db00/11
>> [   94.866055] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2 dev2 ep1out h_addr00 h_port00 bytes 11
>> [   94.866075] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 count 11 buf ce43db00
>> [   94.866089] musb-hdrc musb-hdrc.1.auto: Start TX10 pio
> can you dump TXCSR, DEVCTL and IRQ registers when this happens ?
>
I added the IRQ registers to the debugfs interface..

IntrTX      : 0000
IntrRX      : 0000
IntrTXE     : ffff
IntrRXE     : fffe
IntrUSB     : 08
IntrUSBE    : f7
TxCSRp      : 0000
DevCtl      : 5d

Oddly the VBUSERR bit is set, if I disconnect the USB cable then it goes 
to 0. I just tried plugging in via powered hub and that doesn't change 
the status.

Chris

