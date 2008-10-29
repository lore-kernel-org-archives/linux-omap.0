From: Rick Bronson <rick@efn.org>
Subject: Re: What happened to the serial console on BeagleBoard with 2.6.28-rc2?
Date: Wed, 29 Oct 2008 09:44:46 -0700
Message-ID: <E1KvEA2-0002nH-8d@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:57619 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbYJ2Qoq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 12:44:46 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 13DC117005A
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 09:44:46 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1KvEA2-0002nH-8d
	for linux-omap@vger.kernel.org; Wed, 29 Oct 2008 09:44:46 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


  It looks like a race condition.  Somehow the 8250 ends up with the
LSB of the baud rate register set to 0xff when it's supposed to be
0x1a.  I'm still trying to figure it out :( The patch below gets it
working a little but there's still a problem after init runs.  Note
that you will need to undef DEBUG_LL in the config.

  Rick

--- linux-omap-2.6/drivers/serial/8250.c.~1~	2008-10-28 10:11:30.000000000 -0700
+++ linux-omap-2.6/drivers/serial/8250.c	2008-10-29 08:33:31.000000000 -0700
@@ -483,6 +483,7 @@ static inline int _serial_dl_read(struct
 /* Uart divisor latch write */
 static inline void _serial_dl_write(struct uart_8250_port *up, int value)
 {
+mdelay (2);
 	serial_outp(up, UART_DLL, value & 0xff);
 	serial_outp(up, UART_DLM, value >> 8 & 0xff);
 }
