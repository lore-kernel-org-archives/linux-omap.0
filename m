From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv7 4/7] OMAP3: Clock: Added IDLEST definitions for SGX
Date: Fri, 12 Mar 2010 17:39:14 +0200
Message-ID: <1268408357-15621-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1268408357-15621-1-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-2-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35057 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758148Ab0CLNyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 08:54:54 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsV26019358
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 15:54:52 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsV8l003701
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 15:54:35 +0200
In-Reply-To: <1268408357-15621-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Added definitions for OMAP3430ES2_ST_SGX_SHIFT and OMAP3430ES2_ST_SGX_MASK
as these were missing.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6923deb..60f9b16 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -379,6 +379,10 @@
 #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT		1
 #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK		(1 << 1)
 
+/* CM_IDLEST_SGX */
+#define OMAP3430ES2_ST_SGX_SHIFT			1
+#define OMAP3430ES2_ST_SGX_MASK				(1 << 1)
+
 /* CM_ICLKEN_SGX */
 #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT		0
 #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_MASK		(1 << 0)
-- 
1.5.4.3

