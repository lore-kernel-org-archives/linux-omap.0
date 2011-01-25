From: jean.pihet@newoldbits.com
Subject: [PATCH v2] OMAP: fix fncpy API call
Date: Tue, 25 Jan 2011 18:48:06 +0100
Message-ID: <1295977686-22765-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52256 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1AYRsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 12:48:17 -0500
Received: by wyb28 with SMTP id 28so37993wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 09:48:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Fix a potential problem with function types when calling the
fncpy API to copy the PM code functions to SRAM.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/include/plat/sram.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index d673f2c..f500fc3 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -18,10 +18,10 @@ extern void *omap_sram_push_address(unsigned long size);
 
 /* Macro to push a function to the internal SRAM, using the fncpy API */
 #define omap_sram_push(funcp, size) ({				\
-	typeof(&funcp) _res = NULL;				\
+	typeof(&(funcp)) _res = NULL;				\
 	void *_sram_address = omap_sram_push_address(size);	\
 	if (_sram_address)					\
-		_res = fncpy(_sram_address, &funcp, size);	\
+		_res = fncpy(_sram_address, &(funcp), size);	\
 	_res;							\
 })
 
-- 
1.7.1

