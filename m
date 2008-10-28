From: "Nathan Monson" <nmonson@gmail.com>
Subject: What happened to the serial console on BeagleBoard with 2.6.28-rc2?
Date: Mon, 27 Oct 2008 21:03:01 -0700
Message-ID: <e5e6ade50810272103x3083bf76yba574dc75b68e30e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:4634 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYJ1EDD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2008 00:03:03 -0400
Received: by qw-out-2122.google.com with SMTP id 3so1242045qwe.37
        for <linux-omap@vger.kernel.org>; Mon, 27 Oct 2008 21:03:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

I updated linux-omap git to 2.6.28-rc2, and now I've lost my serial
console.  The kernel seems to be working anyway, but without the
console I can't do much testing.

With DEBUG_LL on, here are the last lines I see during boot:

<6>io scheduler cfq registered (default)
<6>Serial: 8250/16550 driver4 ports, IRQ sharing enabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
<6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654

My console is on ttyS2.  Does something in ttyS2 initialization break
the serial console?

- Nathan
