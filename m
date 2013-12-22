From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: AM335x USB DMA seems broken on ISOC URBs
Date: Sun, 22 Dec 2013 02:59:46 -0300
Message-ID: <20131222055945.GA7194@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44913 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876Ab3LVF7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Dec 2013 00:59:31 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hello,

While doing some experiments with the stk1160 driver (for "Easycap" TV =
video
capture devices), ran into problems using v3.13-rc4. The problem is tha=
t the
stk1160 IRQ handler receives no URBs at all.

When configuring with CONFIG_MUSB_PIO_ONLY this looks solved, but the
bandwidth requirements are too large for PIO (it's a raw video device) =
and the
video can't get captured.

Interesting enough, using an old backported for v3.2 stk1160 driver, th=
is same
setup works with TI PSP v3.2 kernel. So, I guess it's some software bug=
 in
either the cppi41 dmaengine or the musb.

I tried to compare the PSP to the mainline drivers but they seems *very=
*
different and really beyond my understanding.

Any ideas on how can I help debugging this?

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
