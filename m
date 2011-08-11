From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [RFC PATCH 1/2] omap-serial: Overriding omap-serial built in serial_in/out
 functions
Date: Thu, 11 Aug 2011 15:48:43 -0400
Message-ID: <4E44321B.4050009@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:54465 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab1HKTsp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 15:48:45 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1QrbFD-0006tf-Ug
	for linux-omap@vger.kernel.org; Thu, 11 Aug 2011 15:48:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch provides a mean to replace the default serial_in and serial_=
out
implementations provided by omap-serial.c. Inspired from the 8250.c dri=
ver.

Overridding those functions provide a very flexible way to implement sp=
ecial
features such as GPIO connected modem lines. (By catching values writte=
n
to MCR or rewriting values read from MSR on the fly).

Signed-off-by: Rapha=EBl Ass=E9nat <raph@8d.com>

--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -63,6 +63,8 @@ struct omap_uart_port_info {
 	resource_size_t		mapbase;	/* resource base */
 	unsigned long		irqflags;	/* request_irq flags */
 	upf_t			flags;		/* UPF_* flags */
+	unsigned int		(*serial_in)(struct uart_port *, int);
+	void			(*serial_out)(struct uart_port *, int, int);
 };
=20
 struct uart_omap_dma {
@@ -102,6 +104,9 @@ struct uart_omap_port {
 	unsigned char		efr;
=20
 	int			use_dma;
+=09
+	unsigned int		(*serial_in)(struct uart_port *, int);
+	void			(*serial_out)(struct uart_port *, int, int);
 	/*
 	 * Some bits in registers are cleared on a read, so they must
 	 * be saved whenever the register is read but the bits will not
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -51,14 +51,23 @@ static int serial_omap_start_rxdma(struct uart_omap=
_port *up);
=20
 static inline unsigned int serial_in(struct uart_omap_port *up, int of=
fset)
 {
-	offset <<=3D up->port.regshift;
-	return readw(up->port.membase + offset);
+	if (up->serial_in) {
+		return up->serial_in(&up->port, offset);
+	}
+	else {
+		offset <<=3D up->port.regshift;
+		return readw(up->port.membase + offset);
+	}
 }
=20
 static inline void serial_out(struct uart_omap_port *up, int offset, i=
nt value)
 {
-	offset <<=3D up->port.regshift;
-	writew(value, up->port.membase + offset);
+	if (up->serial_out) {
+		up->serial_out(&up->port, offset, value);
+	} else {
+		offset <<=3D up->port.regshift;
+		writew(value, up->port.membase + offset);
+	}
 }
=20
 static inline void serial_omap_clear_fifos(struct uart_omap_port *up)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
