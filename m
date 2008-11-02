From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] serial: Flush posted write on 34xx to make 8250 work (Re:
	What happened to the serial console on BeagleBoard with 2.6.28-rc2?)
Date: Sun, 2 Nov 2008 12:50:21 -0800
Message-ID: <20081102205019.GJ28924@atomide.com>
References: <E1KwhIl-0001an-Ro@amazonia.comcast.net> <200811021126.13514.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d01dLTUuW90fS44H"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58172 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbYKBUuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2008 15:50:25 -0500
Content-Disposition: inline
In-Reply-To: <200811021126.13514.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: rick@efn.org, linux-omap@vger.kernel.org, nmonson@gmail.com, felipe.contreras@gmail.com, tom.leiming@gmail.com


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* David Brownell <david-b@pacbell.net> [081102 11:26]:
> On Sunday 02 November 2008, Rick Bronson wrote:
> > > Is that what you saw too?
> > 
> >   Yep, that's what I saw, but only if I had DEBUG_LL=y.  Without that
> > I had nothing except "Uncompressing Linux........".  
> 
> I don't have DEBUG_LL=y ... if you had some kind of network
> link configured over USB, could you SSH in?  (I can.)
> 
> 
> >   I guess we don't see this problem on the other 2 ports since they
> > are mapped MT_MEMORY_SO and not MT_DEVICE (L4_34XX_PHYS).
> 
> Hmm, inconsistency is to be avoided.  :)
> 
> I wonder what the root cause is ... is the driver missing
> various barriers needed to make MT_DEVICE work?  Or is the
> MT_DEVICE incorrect in the first place?  "git whatchanged"
> didn't show any recent changes that seemed (on a quick
> glance) to affect I/O at that level.  Maybe it was one of
> the other TTY changes interacting here.

Yeah I don't know what may have changed, or have things just
gotten faster now with cortex since 2.6.27?

Anyways, this patch fixes the issue for me without marking
things strongly ordered. Rick, does this work for you?

Regards,

Tony

--d01dLTUuW90fS44H
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="flush-posted-8250.patch"

>From 57eea529292418a20a119c5b18d7636cf44992ae Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 31 Oct 2008 16:47:42 -0700
Subject: [PATCH] serial: Flush posted write on 34xx to make 8250 work

On omap34xx, we need to flush posted writes for TX.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 5f383d8..629a16c 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -413,6 +413,13 @@ serial_out(struct uart_8250_port *up, int offset, int value)
 
 	case UPIO_MEM:
 		writeb(value, up->port.membase + offset);
+#ifdef CONFIG_ARCH_OMAP
+		/* Flush posted write for TX */
+		if (cpu_is_omap34xx() && is_omap_port(up) &&
+			(save_offset == UART_TX || save_offset == UART_IER ||
+				save_offset == UART_LCR))
+			value = serial_in(up, UART_LCR); /* Safe to read */
+#endif
 		break;
 
 	case UPIO_RM9000:

--d01dLTUuW90fS44H--
