From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/13] tty_ldisc: add more limits to the @write_wakeup
Date: Wed, 23 Apr 2014 09:58:25 -0500
Message-ID: <1398265117-11793-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

In the uart_handle_cts_change(), uart_write_wakeup() is called after
we call @uart_port->ops->start_tx().

The Documentation/serial/driver tells us:
-----------------------------------------------
  start_tx(port)
	Start transmitting characters.

	Locking: port->lock taken.
	Interrupts: locally disabled.
-----------------------------------------------

So when the uart_write_wakeup() is called, the port->lock is taken by
the upper. See the following callstack:

	|_ uart_write_wakeup
	   |_ tty_wakeup
	      |_ ld->ops->write_wakeup

With the port->lock held, we call the @write_wakeup. Some implemetation of
the @write_wakeup does not notice that the port->lock is held, and it still
tries to send data with uart_write() which will try to grab the prot->lock.
A dead lock occurs, see the following log caught in the Bluetooth by uart:

--------------------------------------------------------------------
BUG: spinlock lockup suspected on CPU#0, swapper/0/0
 lock: 0xdc3f4410, .magic: dead4ead, .owner: swapper/0/0, .owner_cpu: 0
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    3.10.17-16839-ge4a1bef #1320
[<80014cbc>] (unwind_backtrace+0x0/0x138) from [<8001251c>] (show_stack+0x10/0x14)
[<8001251c>] (show_stack+0x10/0x14) from [<802816ac>] (do_raw_spin_lock+0x108/0x184)
[<802816ac>] (do_raw_spin_lock+0x108/0x184) from [<806a22b0>] (_raw_spin_lock_irqsave+0x54/0x60)
[<806a22b0>] (_raw_spin_lock_irqsave+0x54/0x60) from [<802f5754>] (uart_write+0x38/0xe0)
[<802f5754>] (uart_write+0x38/0xe0) from [<80455270>] (hci_uart_tx_wakeup+0xa4/0x168)
[<80455270>] (hci_uart_tx_wakeup+0xa4/0x168) from [<802dab18>] (tty_wakeup+0x50/0x5c)
[<802dab18>] (tty_wakeup+0x50/0x5c) from [<802f81a4>] (imx_rtsint+0x50/0x80)
[<802f81a4>] (imx_rtsint+0x50/0x80) from [<802f88f4>] (imx_int+0x158/0x17c)
[<802f88f4>] (imx_int+0x158/0x17c) from [<8007abe0>] (handle_irq_event_percpu+0x50/0x194)
[<8007abe0>] (handle_irq_event_percpu+0x50/0x194) from [<8007ad60>] (handle_irq_event+0x3c/0x5c)
--------------------------------------------------------------------

This patch adds more limits to the @write_wakeup, the one who wants to
implemet the @write_wakeup should follow the limits which avoid the deadlock.

Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 include/linux/tty_ldisc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index add26da..00c9d68 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -92,7 +92,10 @@
  *	This function is called by the low-level tty driver to signal
  *	that line discpline should try to send more characters to the
  *	low-level driver for transmission.  If the line discpline does
- *	not have any more data to send, it can just return.
+ *	not have any more data to send, it can just return. If the line
+ *	discipline does have some data to send, please arise a tasklet
+ *	or workqueue to do the real data transfer. Do not send data in
+ *	this hook, it may leads to a deadlock.
  *
  * int (*hangup)(struct tty_struct *)
  *
-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
