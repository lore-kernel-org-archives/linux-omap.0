From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 08/19] OMAP2+: powerdomain: add voltagedomain to struct powerdomain
Date: Wed, 23 Mar 2011 17:00:22 -0700
Message-ID: <1300924833-26745-9-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49686 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933110Ab1CXAA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:27 -0400
Received: by iyb12 with SMTP id 12so11325411iyb.15
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:26 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Each powerdomain is associated with a powerdomain.  Add an entry to
struct powerdomain where the enclosing voltagedomain can be
referenced.

Modeled after similar relationship between clockdomains and powerdomains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 027f40b..cc03a0d 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -24,6 +24,8 @@
 
 #include <plat/cpu.h>
 
+#include "voltage.h"
+
 /* Powerdomain basic power states */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
@@ -78,6 +80,7 @@ struct powerdomain;
 /**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
+ * @voltdm: voltagedomain containing this powerdomain
  * @omap_chip: represents the OMAP chip types containing this pwrdm
  * @prcm_offs: the address offset from CM_BASE/PRM_BASE
  * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
@@ -98,6 +101,10 @@ struct powerdomain;
  */
 struct powerdomain {
 	const char *name;
+	union {
+		const char *name;
+		struct voltagedomain *ptr;
+	} voltdm;
 	const struct omap_chip_id omap_chip;
 	const s16 prcm_offs;
 	const u8 pwrsts;
-- 
1.7.4

