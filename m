From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 05/10] ARM: OMAP: clockdomain: add support for preventing autodep delete
Date: Tue, 25 Sep 2012 12:32:40 +0300
Message-ID: <1348565565-14744-6-git-send-email-t-kristo@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab2IYJdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 05:33:06 -0400
In-Reply-To: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Some clockdomains bug out if their autodeps are deleted before idle.
This happens namely with OMAP3 PER domain, it will bug out if it
doesn't have wakedeps enabled when it enters off-mode. This patch
adds support for new flag 'CLKDM_NO_AUTODEP_DISABLE' which does this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    3 +++
 arch/arm/mach-omap2/clockdomain.h |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8c8518c..2fa433a 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -201,6 +201,9 @@ void _clkdm_del_autodeps(struct clockdomain *clkdm)
 	if (!autodeps || clkdm->flags & CLKDM_NO_AUTODEPS)
 		return;
 
+	if (clkdm->flags & CLKDM_NO_AUTODEP_DISABLE)
+		return;
+
 	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 5601dc1..9b8733e 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -34,6 +34,9 @@
  * CLKDM_ACTIVE_WITH_MPU: The PRCM guarantees that this clockdomain is
  *     active whenever the MPU is active.  True for interconnects and
  *     the WKUP clockdomains.
+ * CLKDM_NO_AUTODEP_DISABLE: Prevent clockdomain code from deleting autodeps.
+ *     Needed for PER domain on omap3, as it will bug out with off-mode if
+ *     wakedeps are removed.
  */
 #define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
 #define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
@@ -41,6 +44,7 @@
 #define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
 #define CLKDM_NO_AUTODEPS			(1 << 4)
 #define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
+#define CLKDM_NO_AUTODEP_DISABLE		(1 << 6)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
-- 
1.7.4.1

