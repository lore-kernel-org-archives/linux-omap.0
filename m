From: Arno Steffen <arno.steffen@googlemail.com>
Subject: [PATCH] OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT
Date: Fri, 26 Nov 2010 12:41:37 +0100
Message-ID: <AANLkTi=rVpQWnRmzw2XF3TzoQW6E9fHLKfrdZUi8-cJo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48089 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab0KZLli (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 06:41:38 -0500
Received: by iwn7 with SMTP id 7so605142iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 26 Nov 2010 03:41:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Arno Steffen <arno.steffen@googlemail.com>
---
 arch/arm/mach-omap2/control.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..5325297 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -309,7 +309,7 @@
 #define		FEAT_SGX_NONE		2

 #define OMAP3_IVA_SHIFT			12
-#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)
+#define OMAP3_IVA_MASK			(1 << OMAP3_IVA_SHIFT)
 #define		FEAT_IVA		0
 #define		FEAT_IVA_NONE		1

-- 
1.7.0.4
