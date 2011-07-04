From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [PATCH 1/5] am3505/3517: Add CHIP_IS macro
Date: Mon, 04 Jul 2011 15:30:31 -0400
Message-ID: <4E1214D7.2030104@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:48744 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1GDTzn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 15:55:43 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Qdoql-0001Ia-L5
	for linux-omap@vger.kernel.org; Mon, 04 Jul 2011 15:30:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Create a CHIP_IS macro fore AM35xx CPUs.

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 8198bb6..f3def59 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -439,6 +439,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP4430ES2_1		(1 << 12)
 #define CHIP_IS_OMAP4430ES2_2		(1 << 13)
 #define CHIP_IS_TI816X			(1 << 14)
+#define CHIP_IS_AM35XX			(1 << 15)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
