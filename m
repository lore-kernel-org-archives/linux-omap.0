From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/5] OMAP4: powerdomain: Update DSS logic state for ES2
Date: Thu, 16 Sep 2010 18:28:25 +0530
Message-ID: <1284641906-24231-5-git-send-email-rnayak@ti.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com>
 <1284641906-24231-2-git-send-email-rnayak@ti.com>
 <1284641906-24231-3-git-send-email-rnayak@ti.com>
 <1284641906-24231-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33699 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab0IPNoI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 09:44:08 -0400
In-Reply-To: <1284641906-24231-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

DSS on ES2 supports only OSWR, hence remove the support
for CSWR from the powerdomain framework.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Beno=C3=83=C2=AEt Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
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
--=20
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
