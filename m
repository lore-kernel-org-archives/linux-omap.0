From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH] Serial: Avoid populating uart_list in early
	init phase
Date: Wed, 30 Jun 2010 20:13:04 +0530
Message-ID: <AANLkTimHkAujlsEXf7dbkek48yltLe8w-ajeMWNqzShL@mail.gmail.com>
References: <61551.192.168.10.88.1277384156.squirrel@dbdmail.itg.ti.com>
	<87zkykxdqe.fsf@deeprootsystems.com>
	<17901.10.24.255.17.1277473301.squirrel@dbdmail.itg.ti.com>
	<871vbvt72x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60633 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab0F3OnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 10:43:06 -0400
Received: by gyd12 with SMTP id 12so429616gyd.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Jun 2010 07:43:05 -0700 (PDT)
In-Reply-To: <871vbvt72x.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

>
> Your inline patch is still getting mangled somehow. =A0It looks like
> you're using a webmail client (SquirrelMail) that seems to be alterin=
g
> the whitespace in the patch. =A0The attached .zip worked fine. =A0Ple=
ase
> spend some time figuring out how to use git send-email directly
>

Have been trying to setup git-send quite some time, but firewall is blo=
cking.
Will try to get this enabled somehow.

> However, I just discovered another snag...
>
> I did some more testing on Zoom3 and discovered that because we do th=
e
> HWMOD_INIT_NO_IDLE, and omap_serial_init[_port] is never called on Zo=
om3
> (since it only uses debug board UART) the UART hwmods are left active
> are never disabled (since they are not used.) =A0This prevents retent=
ion :(
>

Yes I was able to reproduce this as said.

But I was trying to set this option from flags field from uart_hmwod
in omap_hwmod data file as below

=2Eflags          =3D (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),

But strangely it doesn't work, but works only when we set the flag
from serial_early_init phase
any idea why so?

It was hitting retention for zoom2 with earlier suggested changes as
below: [ttyS3->console]

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c
b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 1d7f827..9307f58 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -96,7 +96,7 @@ static struct plat_serial8250_port serial_platform_da=
ta[] =3D {

 static struct platform_device zoom_debugboard_serial_device =3D {
        .name                   =3D "serial8250",
-       .id                     =3D PLAT8250_DEV_PLATFORM,
+       .id                     =3D PLAT8250_DEV_PLATFORM + 4,
        .dev                    =3D {
                .platform_data  =3D serial_platform_data,
        },
diff --git a/arch/arm/mach-omap2/board-zoom2.c
b/arch/arm/mach-omap2/board-zoom2.c
index 803ef14..c858b43 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -80,6 +80,7 @@ static struct omap_board_mux board_mux[] __initdata =3D=
 {
 static void __init omap_zoom2_init(void)
 {
        omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+       omap_serial_init();
        zoom_peripherals_init();
        zoom_debugboard_init();
 }


---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
