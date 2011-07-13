From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 5/5] omap: voltage: changed parameter of omap_voltage_lookup to const
Date: Wed, 13 Jul 2011 17:00:38 +0300
Message-ID: <1310565638-13140-6-git-send-email-t-kristo@ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35760 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab1GMOCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 10:02:35 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com

This fixes a couple of compilation warnings with OMAP SMPS regulator
driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.c             |    2 +-
 arch/arm/plat-omap/include/plat/voltage.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 7e3c512..832fa7a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -1036,7 +1036,7 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
  * a pointer to the voltage domain structure corresponding to the
  * VDD<name>. Else retuns error pointer.
  */
-struct voltagedomain *omap_voltage_domain_lookup(char *name)
+struct voltagedomain *omap_voltage_domain_lookup(const char *name)
 {
 	int i;
 
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 46573bf..76d314c 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -159,7 +159,7 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
 /* API to get the voltagedomain pointer */
-struct voltagedomain *omap_voltage_domain_lookup(char *name);
+struct voltagedomain *omap_voltage_domain_lookup(const char *name);
 
 int omap_voltage_late_init(void);
 #else
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

