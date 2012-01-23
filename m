From: Paul Walmsley <paul@pwsan.com>
Subject: omap-serial RX DMA polling?
Date: Sun, 22 Jan 2012 17:33:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48425 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab2AWAdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jan 2012 19:33:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: govindraj.raja@ti.com
Cc: khilman@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello Govindraj

while trying to track down some of the serial-related PM issues in 
v3.3-rc1, I noticed that the omap-serial.c driver sets a 1 microsecond 
polling timer when DMA is enabled (uart_dma.rx_timer) (!)  This seems 
quite broken from both the DMA and PM points of view.

>From a DMA point of view, the DMA transfer should automatically start 
when there is data to transfer, and stop when there is no data left, based 
on the DMA request lines.  So timer-driven polling should not be needed at 
all.

>From a PM point of view, this short timer will effectively prevent the MPU 
from going into a low-power state whenever there is data in the FIFO.  
This will more than erase any energy consumption or CPU efficiency 
benefits of doing DMA.  Interrupt-driven PIO should be much more efficient 
than this, since at least the MPU can enter a low-power state while 
waiting for the FIFO to fill.

So basically, the broken timeout calculations used in the interrupt-driven 
PIO mode (which set a 1 microsecond PM QoS constraint), plus the 1 
microsecond polling timer used in DMA mode, mean that this driver is 
pretty bad from a PM perspective.

I sent some patches to fix the interrupt-driven PIO receive part of the 
problem, which you've probably seen.  But I'm hoping that you can describe 
further why the driver needs this RX DMA polling timer?  Shouldn't it be 
unnecessary?  If it's truly unavoidable, then we should presumably not 
even bother with RX DMA at all.



 - Paul
