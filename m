From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [RFC PATCH 2/2] omap-serial: Allow board files to override serial_in/out
Date: Thu, 11 Aug 2011 15:50:07 -0400
Message-ID: <4E44326F.6010004@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:55007 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab1HKTuI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 15:50:08 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1QrbGZ-0006vI-BJ
	for linux-omap@vger.kernel.org; Thu, 11 Aug 2011 15:50:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds a way to override the default serial_in and serial_out
functions, typically from the board-??? file.

In some cases, mach-omap2/serial.c may already be overriding the
default serial_in/out functions. When this happens, old_serial_in/out
will be non-null and the board implementation should then call these=20
instead of going ahead and performing direct memory access.

Tested with 8250.c and omap-serial.c on a custom AM3505 system.

Signed-off-by: Rapha=EBl Ass=E9nat

--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -105,10 +105,20 @@
=20
 #ifndef __ASSEMBLER__
=20
+struct uart_port;
 struct omap_board_data;
=20
+struct omap_serio_funcs {
+	unsigned int	(*serial_in)(struct uart_port *, int);
+	void		(*serial_out)(struct uart_port *, int, int);
+=09
+	unsigned int	(*old_serial_in)(struct uart_port *, int);
+	void		(*old_serial_out)(struct uart_port *, int, int);
+};
+
 extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
+extern void omap_serial_init_port_serio(struct omap_board_data *bdata,=
 struct omap_serio_funcs *serio_funcs);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -696,6 +696,11 @@ static int __init omap_serial_early_init(void)
 }
 core_initcall(omap_serial_early_init);
=20
+void __init omap_serial_init_port(struct omap_board_data *bdata)
+{
+	omap_serial_init_port_serio(bdata, NULL);
+}
+
 /**
  * omap_serial_init_port() - initialize single serial port
  * @bdata: port specific board data pointer
@@ -707,7 +712,7 @@ core_initcall(omap_serial_early_init);
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(struct omap_board_data *bdata)
+void __init omap_serial_init_port_serio(struct omap_board_data *bdata,=
 struct omap_serio_funcs *serio_funcs)
 {
 	struct omap_uart_state *uart;
 	struct omap_hwmod *oh;
@@ -779,6 +784,15 @@ void __init omap_serial_init_port(struct omap_boar=
d_data *bdata)
 		p->serial_out =3D serial_out_override;
 	}
=20
+	if (serio_funcs) {
+		serio_funcs->old_serial_in =3D p->serial_in;
+		serio_funcs->old_serial_out =3D p->serial_out;
+		if (serio_funcs->serial_in)
+			p->serial_in =3D serio_funcs->serial_in;
+		if (serio_funcs->serial_out)
+			p->serial_out =3D serio_funcs->serial_out;
+	}
+
 	pdata =3D &ports[0];
 	pdata_size =3D 2 * sizeof(struct plat_serial8250_port);
 #else
@@ -792,6 +806,11 @@ void __init omap_serial_init_port(struct omap_boar=
d_data *bdata)
 	omap_up.irqflags =3D IRQF_SHARED;
 	omap_up.flags =3D UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
=20
+	if (serio_funcs) {
+		omap_up.serial_in =3D serio_funcs->serial_in;
+		omap_up.serial_out =3D serio_funcs->serial_out;
+	}
+
 	pdata =3D &omap_up;
 	pdata_size =3D sizeof(struct omap_uart_port_info);
 #endif

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
