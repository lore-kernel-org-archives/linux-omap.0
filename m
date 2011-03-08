From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP2/3: WKUP powerdomain: mark as being always on
Date: Mon, 07 Mar 2011 19:15:50 -0700
Message-ID: <20110308021546.31946.87970.stgit@twilight.localdomain>
References: <20110308021018.31946.29962.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33947 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab1CHCRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 21:17:20 -0500
In-Reply-To: <20110308021018.31946.29962.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Mark the WKUP powerdomain as being always on -- at least, as long as th=
e
chip has power.  This will be used to enable the powerdomain code to
determine whether a given powerdomain is ever able to power off.  While
here, update the file copyright.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/ar=
m/mach-omap2/powerdomains2xxx_3xxx_data.c
index 5b4dd97..96cda13 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -2,7 +2,7 @@
  * OMAP2/3 common powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
+ * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H=C3=B6gander
  *
@@ -76,4 +76,5 @@ struct powerdomain wkup_omap2_pwrdm =3D {
 	.name		=3D "wkup_pwrdm",
 	.prcm_offs	=3D WKUP_MOD,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+	.pwrsts		=3D PWRSTS_ON,
 };


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
