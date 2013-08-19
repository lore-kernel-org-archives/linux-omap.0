From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: AM335x, early printk
Date: Mon, 19 Aug 2013 13:21:07 +0200
Message-ID: <5211FFA3.6060407@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48070 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3HSLVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Aug 2013 07:21:08 -0400
Received: from localhost ([127.0.0.1] helo=[172.123.10.21])
	by Galois.linutronix.de with esmtp (Exim 4.72)
	(envelope-from <bigeasy@linutronix.de>)
	id 1VBNWF-0005RN-Rd
	for linux-omap@vger.kernel.org; Mon, 19 Aug 2013 13:21:07 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I activated:
[*] Kernel low-level debugging functions
     Kernel low-level debugging port (Kernel low-level debugging
      messages via OMAP2PLUS UART)
     Low-level debug console UART (AM33XX UART1)
[*] Early printk

and booted my am335x-evm.
I haven't seen any "early" output in the decompressor or during the
kernel boot. I believe that all I saw is just regular ttyO0 output.
I saw also:
|44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
|console [ttyO0] enabled
and I would also except the bootconsole (if any) to be deactivated here.

What am I missing?

Sebastian
