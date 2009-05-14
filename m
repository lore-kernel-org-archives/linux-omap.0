From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH] OMAP: UART: don't initialize membase and mapbase when its
	port is not enabled
Date: Thu, 14 May 2009 17:41:44 +0900
Message-ID: <4d34a0a70905140141t3f8e2b08uefb4141f904bfcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f133.google.com ([209.85.221.133]:65504 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZENInM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 04:43:12 -0400
Received: by qyk39 with SMTP id 39so2171593qyk.33
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 01:43:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?EUC-KR?B?seix1L/4?= <q1.kim@samsung.com>, Paul Mundt <paul.mundt@nokia.com>

Hi All,

We are using two UARTs port in OMAP3430 board shown as following
 UART 1 - not used
 UART 2 - BT
 UART 3 - console ("console=3DttyS2,115200n8" in 'bootargs' of bootload=
er)

Because we are not using UART port 1, I configured our board file as fo=
llowing
 735 static struct omap_uart_config omap3_boardname_uart_config __initd=
ata =3D {
 736         .enabled_uarts  =3D ((1 << 1) | (1 << 2)),
 737 };
However, I couldn't see any console message.

If I configured like
 735 static struct omap_uart_config omap3_boardname_uart_config __initd=
ata =3D {
 736         .enabled_uarts  =3D ((1 << 0) (1 << 1) | (1 << 2)),
 737 };
I could see console messages. But I think this is not the real solution=
=2E

Is it correct to use ttyS2, if I use UART3 as console UART?

Anyway, I kept track of this problem and I'm sending the patch.

Please let me know your opinion about this patch.

---
=46rom 88fc1f0872fd2c6ac42501027e5bf69156cce37f Mon Sep 17 00:00:00 200=
1
=46rom: Kim Kyuwon <q1.kim@samsung.com>
Date: Thu, 14 May 2009 17:05:35 +0900
Subject: [PATCH] OMAP: UART: don't initialize membase and mapbase when
its port is not enabled

If membase and mapbase are zero, its uart port which is registered to
serial8250(i.e serial8250_port[i]) is overridden, because the
serial8250_find_match_or_unsed() function consider this port as a
unused entry. This make the serial2850_console_setup function use
incorrect uart port, because co->index is used as the index of
serial8250_port. This patch prevent using wrong index of uart.

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/serial.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 4dcf39c..01c2da7 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -118,11 +118,8 @@ void __init omap_serial_init(void)
 	for (i =3D 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct plat_serial8250_port *p =3D serial_platform_data + i;

-		if (!(info->enabled_uarts & (1 << i))) {
-			p->membase =3D NULL;
-			p->mapbase =3D 0;
+		if (!(info->enabled_uarts & (1 << i)))
 			continue;
-		}

 		sprintf(name, "uart%d_ick", i+1);
 		uart_ick[i] =3D clk_get(NULL, name);
--=20
1.5.2.5


--=20
Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
