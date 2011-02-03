From: Mathias Nyman <mathias.nyman@nokia.com>
Subject: Re: serial8250: too much work for irq73
Date: Thu, 03 Feb 2011 17:05:32 +0200
Message-ID: <4D4AC43C.4060206@nokia.com>
References: <4D483062.9010809@mibtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:19724 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab1BCOxh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:53:37 -0500
In-Reply-To: <4D483062.9010809@mibtec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?ext_Robert_W=F6rle?= <rwoerle@mibtec.de>
Cc: linux-omap@vger.kernel.org

ext Robert W=F6rle wrote:
> Hi List
>=20
> I am running into issues , when using ttyS1 on a heavy loaded
> application. It trys to send and recieve around 60bytes every 100ms w=
ith
> 57600baud.  There is a PIC Microcontroller attached on the otherside
> which immidiatly returns the data when requested.
>=20
> After some hours , the kernel starts to flood with the above messages
> and the system gets into an unusable state.
>=20
> i am running 2.6.35.9 ( released from isee.com ) on their Igep Module=
 (
> arch igep0030).
>=20
> What would you guys do ? Anything i can provide you to help here ? It=
s
> really a major issue for us and showstopping an important release.
>=20
> Thanks in advance for any help or suggestion
>=20

Not sure if this is the same cause, but here's some code that fixed a s=
imilar issue:

Serial: 8250.c: Clear FIFOs before enabling them

There's a short time when FIFO's are disabled and interrupts enabled
between startup and set_termios.
If rx FIFO is not cleared before enabled, and there are lots of serial =
I/O,
an interrupt indicating FIFO data error can occur.
(LSR register bit 7 set, no other error bits set).

The current interrupt handle is unable to clear this interrupt and will=
 continue looping with a
flood of "too much work" messages.

This is seen on an omap board with ST16654 type uart if a key is kept p=
ressed in serial console while
booting.

Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
---
 drivers/serial/8250.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 5ed1b82..d3add25 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2403,6 +2403,8 @@ serial8250_set_termios(struct uart_port *port, st=
ruct ktermios *termios,
                if (fcr & UART_FCR_ENABLE_FIFO) {
                        /* emulated UARTs (Lucent Venus 167x) need two =
steps */
                        serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO)=
;
+                       serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO =
|
+                                   UART_FCR_CLEAR_RCVR | UART_FCR_CLEA=
R_XMIT);
                }
                serial_outp(up, UART_FCR, fcr);         /* set fcr */
        }
--=20





--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
