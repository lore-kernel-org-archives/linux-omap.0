From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/12] OMAP4: powerdomain: Update DSS logic state for ES2
Date: Fri, 24 Sep 2010 01:08:17 -0600
Message-ID: <20100924070815.14014.90011.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33651 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab0IXHJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:09:04 -0400
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Rajendra Nayak <rnayak@ti.com>

DSS on ES2 supports only OSWR, hence remove the support
for CSWR from the powerdomain framework.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomains44xx.h        |    2 +-
 arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-oma=
p2/powerdomains44xx.h
index c721951..9c01b55 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.h
+++ b/arch/arm/mach-omap2/powerdomains44xx.h
@@ -98,7 +98,7 @@ static struct powerdomain dss_44xx_pwrdm =3D {
 	.prcm_offs	  =3D OMAP4430_PRM_DSS_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
-	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
+	.pwrsts_logic_ret =3D PWRSTS_OFF,
 	.banks		  =3D 1,
 	.pwrsts_mem_ret	=3D {
 		[0] =3D PWRDM_POWER_OFF,	/* dss_mem */
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/p=
lat-omap/include/plat/powerdomain.h
index fb6ec74..3ea7220 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -32,6 +32,7 @@
=20
 /* Powerdomain allowable state bitfields */
 #define PWRSTS_ON		(1 << PWRDM_POWER_ON)
+#define PWRSTS_OFF		(1 << PWRDM_POWER_OFF)
 #define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
 				 (1 << PWRDM_POWER_ON))
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
