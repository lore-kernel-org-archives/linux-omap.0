From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCH 1/4] OMAP4: clockdata: Make compiler shut up about possible
 uninitialized variable
Date: Thu, 4 Aug 2011 20:02:02 +0200
Message-ID: <CAFULf_yAOTABxF_OV2xacF2CMhNVEguwSpgDHNbkeKKZif4ncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65101 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1HDSCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 14:02:03 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so1319292vws.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 11:02:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Stop `warning: 'cpu_clkflg' may be used uninitialized in this
function' from compiler.
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c
b/arch/arm/mach-omap2/clock44xx_data.c
index 2af0e3f..a9c19c8 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3368,7 +3368,7 @@ static struct omap_clk omap44xx_clks[] = {
 int __init omap4xxx_clk_init(void)
 {
 	struct omap_clk *c;
-	u32 cpu_clkflg;
+	u32 cpu_clkflg = 0;

 	if (cpu_is_omap44xx()) {
 		cpu_mask = RATE_IN_4430;
-- 
1.7.1
