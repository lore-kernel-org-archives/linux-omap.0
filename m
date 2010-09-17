From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Query] Garbled characters on gtkterm
Date: Fri, 17 Sep 2010 11:34:00 -0700
Message-ID: <20100917183400.GH29610@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB032953A021@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52819 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab0IQSeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 14:34:05 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032953A021@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [100917 10:36]:
> Hi,
> While trying to boot kernel image on N800 I am seeing
> lot of garbled characters along with the trace in gtkterm.
> 
> I have configured the terminal as follows:
> Port: ttyS0
> Speed: 115200
> Parity: none
> Bits:8
> Stopbits: 1
> Flow control: none
> End of delay(ms): 0
> 
> Can someone help me if I am missing anything in my configuration?

> [    0.000000] Linux version 2.6.36-rc4-00040-g4c1f85c-dirty (x0016154@omaplbp) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #7 Fri Sep 17 15:57:29 IST 2010

Quite recent kernel, good :)

> 
> [    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387f
> 
> [    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
> 
> [    0.000000] Machine: Nokia N800
> 
> [    0.000000] Ignoring unrecognised tag 0x414f4d50
> 
> [    0.000000] bootconsole [earlycon0] enabled
> 
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> ....
> <<Garbled characters>>

I'm not seeing these, just booted my n800 last night with the cbus
patches from Felipe. I believe all I did was yes "" | ARCH=arm make oldconfig
on the n8x0_defconfig that we still have around.

I've seen things like that with some USB serial dongles earlier,
I believe that the pl2303 based one worked, and then the ftdi
driver one produced garbage. AFAIK, this was related to some
problem with the serial port level shifter, I think this was
with n810.

Regards,

Tony
