From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2 2/2]: Introducing 'gpmc-nand.c' for GPMC specific
 NAND init
Date: Wed, 06 Jan 2010 16:34:57 +0200
Message-ID: <1262788497.3177.14.camel@localhost>
References: <64662.192.168.10.89.1259933932.squirrel@dbdmail.itg.ti.com>
	 <20091204220138.GJ24013@atomide.com>
	 <ce9ab5790912062229xae89bb3m6965b4f4465f11c3@mail.gmail.com>
	 <ce9ab5790912070529h1143355du691ce6a23f5ddb56@mail.gmail.com>
	 <20091207175644.GA24013@atomide.com> <20091208235725.GA24013@atomide.com>
	 <ce9ab5790912132226n6480c029ve93def5ebec1e2c9@mail.gmail.com>
	 <ce9ab5790912140147v23e3705aucf6d25c56aaaab31@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49128 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214Ab0AFOfR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 09:35:17 -0500
In-Reply-To: <ce9ab5790912140147v23e3705aucf6d25c56aaaab31@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>

On Mon, 2009-12-14 at 15:17 +0530, Vimal Singh wrote:
> From 6170aa1c63c49a3f09e76258f400230b742fdd6f Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Wed, 25 Nov 2009 18:23:15 +0530
> Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND ini=
t
>=20
> Introducing 'gpmc-nand.c' for GPMC specific NAND init.
> For example: GPMC timing parameters and all.
> This patch also migrates gpmc related calls from 'nand/omap2.c'
> to 'gpmc-nand.c'.
>=20
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    3 +
>  arch/arm/mach-omap2/gpmc-nand.c        |  137 ++++++++++++++++++++++=
++++++++++
>  arch/arm/plat-omap/include/plat/nand.h |    6 ++
>  drivers/mtd/nand/omap2.c               |   26 +------
>  4 files changed, 149 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/gpmc-nand.c

I assume this is material for Tony and the omap tree.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
