From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 15:52:56 +0530
Message-ID: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40797 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab2IUKXF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Sep 2012 06:23:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

Overrun also causes an internal flag to be set, which disables further
reception. Before the next frame can
be received, the MPU must:
=E2=80=A2 Reset the RX FIFO.
=E2=80=A2 clear the internal flag.

In the uart mode a dummy read is needed. Add the same.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- functional testing on omap4sdp
- Verified idle and suspend path hits off on beagle.

 drivers/tty/serial/omap-serial.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index a0d4460..bc22a2b 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -334,6 +334,13 @@ static unsigned int check_modem_status(struct uart=
_omap_port *up)
 static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int l=
sr)
 {
 	unsigned int flag;
+	unsigned char ch =3D 0;
+
+	if (!(lsr & UART_LSR_BRK_ERROR_BITS))
+		return;
+
+	if (likely(lsr & UART_LSR_DR))
+		ch =3D serial_in(up, UART_RX);
=20
 	up->port.icount.rx++;
 	flag =3D TTY_NORMAL;
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
