From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv5 5/9] OMAP3: Clock: Added IDLEST definitions for SGX
Date: Tue,  2 Feb 2010 16:52:23 +0200
Message-ID: <1265122347-2233-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265122347-2233-1-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-2-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-3-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-4-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52308 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab0BBNDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 08:03:18 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D3Bl0028595
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 15:03:15 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D2wJg029178
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 15:03:04 +0200
In-Reply-To: <1265122347-2233-5-git-send-email-tero.kristo@nokia.com>
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
index a76e835..d18da47 100644
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

