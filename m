From: jean.pihet@newoldbits.com
Subject: [PATCH] OMAP: fix fncpy API call
Date: Tue, 25 Jan 2011 18:21:19 +0100
Message-ID: <1295976079-21228-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51754 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1AYRVc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 12:21:32 -0500
Received: by wwi17 with SMTP id 17so4230443wwi.1
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 09:21:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Fix a potential problem with function types when calling the
fncpy API to copy the PM code functions to SRAM.

Tested on OMAP3 in low power modes (RET/OFF)
using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/include/plat/sram.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index d673f2c..6a2166d 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -21,7 +21,7 @@ extern void *omap_sram_push_address(unsigned long size);
 	typeof(&funcp) _res = NULL;				\
 	void *_sram_address = omap_sram_push_address(size);	\
 	if (_sram_address)					\
-		_res = fncpy(_sram_address, &funcp, size);	\
+		_res = fncpy(_sram_address, &(funcp), size);	\
 	_res;							\
 })
 
-- 
1.7.1

