From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv3 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Fri, 20 Nov 2009 15:21:26 +0530
Message-ID: <d6a0f7aa0911200151xb948a28kf4f22d79e61b993e@mail.gmail.com>
References: <35552.192.168.10.88.1256713953.squirrel@dbdmail.itg.ti.com>
	 <44977.192.168.10.88.1258095220.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:26939 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZKTJvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 04:51:20 -0500
Received: by qw-out-2122.google.com with SMTP id 3so706646qwe.37
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 01:51:26 -0800 (PST)
In-Reply-To: <44977.192.168.10.88.1258095220.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "Pandita, Vikram" <vikram.pandita@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

I have not seen any comments on this patch series yet.

Tony,
Is there something I need to modify?

Or it can be unstreamed now?

---
Regards,
Govindraj.R


On Fri, Nov 13, 2009 at 12:23 PM, Govindraj.R <govindraj.raja@ti.com> w=
rote:
>
> From 8dae69c5e17421123b88414021289974e968fd02 Mon Sep 17 00:00:00 200=
1
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Fri, 13 Nov 2009 12:09:38 +0530
> Subject: [PATCH] OMAP UART: Adding support for omap-serial driver.
>
> The Following series of patch adds support for OMAP3430-HIGH SPEED UA=
RT Controller.
>
> Govindraj R (3):
> =A0OMAP UART: Add omap-serial driver support.
> =A0OMAP UART: Add platform data for omap-serial driver.
> =A0OMAP UART: Add omap-serial driver support in omap_3430sdp_defconfi=
g
>
> =A0arch/arm/configs/omap_3430sdp_defconfig =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0335 +++++--
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0115 +++
> =A0drivers/serial/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 23 +
> =A0drivers/serial/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 +
> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
1330 +++++++++++++++++++++++++
> =A0include/linux/serial_core.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A03 +
> =A07 files changed, 1714 insertions(+), 94 deletions(-)
> =A0create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
> =A0create mode 100644 drivers/serial/omap-serial.c
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
