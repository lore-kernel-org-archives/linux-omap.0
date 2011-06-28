From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: [RFC] OMAP3: powerdomains: Match silicon revision to select the
 correct "core_pwrdm" definition
Date: Tue, 28 Jun 2011 15:22:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370A4D8EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48012 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab1F1Jz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 05:55:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5S9tPUR011212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 04:55:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5S9tOKW015577
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:25:24 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Premi, Sanjeev" <premi@ti.com>

powerdomains3xxx_data.c defines core_3xxx_pre_es3_1_pwrdm and
core_3xxx_es3_1_pwrdm to take care of differences in "core_pwrdm"
implementations across revisions.
However,_pwrdm_lookup("core_pwrdm") always matches the first definition for
3630 ES 1.1 and 1.2 which is incorrect. This patch fixes this issue by adding
code to match silicon revision as well while looking up "core_pwrdm" in
_pwrdm_lookup().
core_3xxx_es3_1_pwrdm is different from core_3xxx_pre_es3_1_pwrdm in
that the former adds hardware save-restore support for USBTLL for 3430
ES3.1 and for 3630 ES1.1 and ES1.2.
However,with this change, issuing a standby command (by suspending to RAM)
seems to crash the system on a 3630 ES1.2., with or without the USB support
enabled.
I'm not very sure about how the USBTLL setting effects the suspend operation of
the rest of the system.


Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index eaed0df..cc2b6e6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -29,6 +29,7 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/prcm.h>
+#include <plat/cpu.h>

 #include "pm.h"

@@ -53,6 +54,22 @@ static struct powerdomain *_pwrdm_lookup(const char *name)

        list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
                if (!strcmp(name, temp_pwrdm->name)) {
+                       if (!strcmp(name, "core_pwrdm") && cpu_is_omap3630()) {
+                               if (omap_rev() > OMAP3630_REV_ES1_0) {
+                               /*
+                                * match omap_chip info for OMAP3630 Rev ES1.1, 
+                                * ES1.2 or higher
+                                */
+                                       if (!(temp_pwrdm->omap_chip.oc
+                                               & CHIP_GE_OMAP3630ES1_1))
+                                               continue;
+                               } else {
+                               /* match omap_chip info for OMAP3630 Rev ES1.0 */
+                                       if (!(temp_pwrdm->omap_chip.oc
+                                                & CHIP_IS_OMAP3630ES1))
+                                               continue;
+                               }
+                       }
                        pwrdm = temp_pwrdm;
                        break;
                }
-- 
1.7.1
