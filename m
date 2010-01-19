From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: RE: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic
Date: Tue, 19 Jan 2010 09:19:35 -0800
Message-ID: <1263921575.3376.13.camel@localhost>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	 <20100116013515.10065.30649.stgit@baageli.muru.com>
	 <FCCFB4CDC6E5564B9182F639FC356087030070F293@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:61517 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab0ASRTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 12:19:39 -0500
Received: by iwn35 with SMTP id 35so3032230iwn.4
        for <linux-omap@vger.kernel.org>; Tue, 19 Jan 2010 09:19:38 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030070F293@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-01-19 at 06:56 +0530, Pandita, Vikram wrote:
>=20
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of Tony
> >Lindgren
> >Sent: Friday, January 15, 2010 7:35 PM
> >To: linux-arm-kernel@lists.infradead.org
> >Cc: linux-omap@vger.kernel.org
> >Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code ge=
neric
>=20
> UART_SCR 		-> this is the scratchpad register=20
> UART_OMAP_SCR	-> This is TI-only Supplementary control register
>=20
> You probably confused the two (as rightly so since SCR is same name).
> So there is no need to save/restore the UART_SCR register as you have=
 done, see inlined --=20
>=20
> >
> >Define arch_decomp_setup() the same way as some other
> >architectures do. Use arch_id to configure the debug uart
> >based on the machine_is by storing it into the uart
> >scratchpad register for DEBUG_LL code to use.
> >
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> <snip>
> >--- a/arch/arm/mach-omap2/serial.c
> >+++ b/arch/arm/mach-omap2/serial.c
> >@@ -161,11 +161,22 @@ static inline void serial_write_reg(struct pla=
t_serial8250_port *p, int offset,
> > static inline void __init omap_uart_reset(struct omap_uart_state *u=
art)
> > {
> > 	struct plat_serial8250_port *p =3D uart->p;
> >+	u8 scratchpad =3D 0;
> >+
> >+	/*
> >+	 * Save UART1 scratchpad register value for UART1 for DEBUG_LL.
> >+	 * See also include/plat/uncompress.h and include/mach/debug-macro=
=2ES.
> >+	 */
> >+	if (p->mapbase =3D=3D OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
> >+		scratchpad =3D serial_read_reg(p, UART_SCR);
>=20
> No need to save and restore the UART_SCR register.=20
> This never gets used in this function.
>=20
> What gets used is UART_OMAP_SCR which is OMAP specific supplimantry c=
ontrol register=20
> and not scratchpad.
>=20
> >
> > 	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
> > 	serial_write_reg(p, UART_OMAP_SCR, 0x08);
> > 	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
> > 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 <<=
 0));
> >+
> >+	if (p->mapbase =3D=3D OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
> >+		serial_write_reg(p, UART_SCR, scratchpad);
>=20
> Remove this as well. No need.=20
>=20
>=20
> <snip>
> >diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm=
/plat-
> >omap/include/plat/uncompress.h
> >index 13c305d..479bac8 100644
> >--- a/arch/arm/plat-omap/include/plat/uncompress.h
> >+++ b/arch/arm/plat-omap/include/plat/uncompress.h
> >@@ -19,62 +19,36 @@
> >
> > #include <linux/types.h>
> > #include <linux/serial_reg.h>
> >+
> >+#include <asm/mach-types.h>
> >+
> > #include <plat/serial.h>
> >
> >-unsigned int system_rev;
> >+static volatile u8 *uart1_base;
> >+static volatile u8 *uart_base;
> >+static volatile int uart_shift;
>=20
> Just like uart_base is stored in scratchpad,
> Somehow the uart_shift also needs to be stored so that boards with di=
fferent uart_shift requirements can be addressed. Where can we store th=
is another variable?=20

Since the base addresses are aligned, how about store the shift in the
least-significant 2 bits, and the rest is the base address.

Kevin

> <snip>
>=20
> > /*
> >+ * Macros to configure UART1 and debug UART
> >+ */
> >+#define _DEBUG_LL_ENTRY(mach, uart1, dbg_uart, shift, dbg_id, reset=
_fn)	\
> >+	if (machine_is_##mach()) {					\
> >+		uart1_base =3D (volatile u8 *)(uart1);			\
> >+		uart_base =3D (volatile u8 *)(dbg_uart);			\
> >+		uart_shift =3D (shift);					\
> >+		port =3D (dbg_id);					\
> >+		reset_fn;						\
> >+		break;							\
> >+	}
>=20
> Nice Idea... you are the man !!
>=20
> <snip>
> NrybX=C7=A7v^)=DE=BA{.n+{f{ay=1D=CA=87=DA=99,j=07fhz=1Ew=0Cj:+vwjm=07=
zZ+=DD=A2j"!


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
