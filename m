From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCHv2 1/4] OMAP4: clockdata: Make compiler shut up about possible
 uninitialized variable
Date: Fri, 12 Aug 2011 17:27:35 +0200
Message-ID: <CAFULf_wBTEVHYTPyJqWt09gNaenWHiVJCLvNdeRG204TkeBe6Q@mail.gmail.com>
References: <CAFULf_yAOTABxF_OV2xacF2CMhNVEguwSpgDHNbkeKKZif4ncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35866 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1HLP1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 11:27:36 -0400
Received: by vxi9 with SMTP id 9so2453955vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 08:27:35 -0700 (PDT)
In-Reply-To: <CAFULf_yAOTABxF_OV2xacF2CMhNVEguwSpgDHNbkeKKZif4ncA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Stop `warning: 'cpu_clkflg' may be used uninitialized in this
function' from compiler.

Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
---
V2: Oops.. Add missing sob.

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
