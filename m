From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCHv3 1/3] OMAP UART: Add omap-serial driver support.
Date: Mon, 23 Nov 2009 19:11:59 +0200
Message-ID: <1258996319.18407.49.camel@localhost>
References: <35817.192.168.10.88.1256713980.squirrel@dbdmail.itg.ti.com>
	 <45113.192.168.10.88.1258095234.squirrel@dbdmail.itg.ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26080 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZKWRML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 12:12:11 -0500
In-Reply-To: <45113.192.168.10.88.1258095234.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2009-11-13 at 12:23 +0530, Govindraj.R wrote:
> From 4756e3743c7acd2de1030b2bd432c1b19f0b9ff5 Mon Sep 17 00:00:00 200=
1
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Fri, 13 Nov 2009 12:01:54 +0530
> Subject: [PATCH] OMAP UART: Add omap-serial driver support.
>=20
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>=20
> It adds support for the following features:
> 1. It supports Interrupt mode and DMA mode of operation.
> 2. Supports Hardware flow control and sofware flow control.
> 3. Debug Console support on all UARTs.
>=20
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |  115 +++
>  drivers/serial/Kconfig                        |   23 +
>  drivers/serial/Makefile                       |    1 +
>  drivers/serial/omap-serial.c                  | 1330 +++++++++++++++=
++++++++++
>  include/linux/serial_core.h                   |    3 +
>  5 files changed, 1472 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
>  create mode 100644 drivers/serial/omap-serial.c

Did you address the irq storm problems pointed by Mika Westerberg?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
