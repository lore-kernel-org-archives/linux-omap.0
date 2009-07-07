From: ye janboe <janboe.ye@gmail.com>
Subject: [PATCH] Clear the SDRC_POWER.PWRENA bit before putting the SDRAM into
	self-refresh before suspend
Date: Tue, 7 Jul 2009 16:44:20 -0500
Message-ID: <af3ea28a0907071444m7c9ef14i8eaf15b45b14db9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:63737 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbZGGVoY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 17:44:24 -0400
Received: by gxk26 with SMTP id 26so2407843gxk.13
        for <linux-omap@vger.kernel.org>; Tue, 07 Jul 2009 14:44:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi, Paul

I saw you clear clear the SDRC PWRENA bit during SDRC frequency change
but not during suspend.

Please review if it is necessary to clear PWRENA bit during suspend.

Thanks

Janboe Ye

rom 287db2e188391be0ac95128131724e0e035e945a Mon Sep 17 00:00:00 2001
From: janboe <janboe.ye@gmail.com>
Date: Tue, 7 Jul 2009 16:30:26 -0500
Subject: [PATCH] Clear the SDRC_POWER.PWRENA bit before putting the
SDRAM into self-refresh and then suspend

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/mach-omap2/sleep34xx.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index e5e2553..2bc0c3b 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -70,6 +70,7 @@ loop:
        ldr     r4, sdrc_power          @ read the SDRC_POWER register
        ldr     r5, [r4]                @ read the contents of SDRC_POWER
        orr     r5, r5, #0x40           @ enable self refresh on idle req
+       bic     r5, r5, #0x4            @ clear PWDENA
        str     r5, [r4]                @ write back to SDRC_POWER register

        cmp     r1, #0x0
-- 
1.6.3.1
