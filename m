From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/18] ARM: OMAP2+: prcm: add omap_test_timeout to prcm-common.h
Date: Tue, 4 Mar 2014 18:19:02 +0200
Message-ID: <1393949958-816-3-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45093 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaCDQUJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:09 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to move cm/prm to drivers. These will still use
omap_test_timeout, but will not have access to common.h header under
mach-omap2 anymore.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 0e841fd..e982598 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -429,6 +429,26 @@
 # ifndef __ASSEMBLER__
 
 /**
+ * omap_test_timeout - busy-loop, testing a condition
+ * @cond: condition to test until it evaluates to true
+ * @timeout: maximum number of microseconds in the timeout
+ * @index: loop index (integer)
+ *
+ * Loop waiting for @cond to become true or until at least @timeout
+ * microseconds have passed.  To use, define some integer @index in the
+ * calling code.  After running, if @index == @timeout, then the loop has
+ * timed out.
+ */
+#define omap_test_timeout(cond, timeout, index)			\
+({								\
+	for (index = 0; index < timeout; index++) {		\
+		if (cond)					\
+			break;					\
+		udelay(1);					\
+	}							\
+})
+
+/**
  * struct omap_prcm_irq - describes a PRCM interrupt bit
  * @name: a short name describing the interrupt type, e.g. "wkup" or "io"
  * @offset: the bit shift of the interrupt inside the IRQ{ENABLE,STATUS} regs
-- 
1.7.9.5

