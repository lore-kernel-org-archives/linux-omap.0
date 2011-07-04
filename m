From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [PATCH 3/5] am3505/3517: Skip TWL
Date: Mon, 04 Jul 2011 15:33:43 -0400
Message-ID: <4E121597.9020904@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:48786 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab1GDTzq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 15:55:46 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Qdotr-0001Kb-Ui
	for linux-omap@vger.kernel.org; Mon, 04 Jul 2011 15:33:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In cpu.h, OMAP35XX_CLASS is currently defined as 0x35000034.
the cpu_is_omap34xx() return 1 even on am3505 and am3517.

I'm not sure if the CPU class bits should be changed to 0x35
(redefining OMAP35XX_CLASS to 0x35000035). So instead, I'm
adding code to explicitely ignore am3505 and am3517.

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 07d6140..13b9fbd 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -266,7 +266,7 @@ int __init omap3_twl_init(void)
 {
 	struct voltagedomain *voltdm;
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx() || cpu_is_omap3505() || cpu_is_omap3517() )
 		return -ENODEV;
 
 	if (cpu_is_omap3630()) {
