From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: Update timer clock aliases (fwd)
Date: Thu, 29 Nov 2012 17:17:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211291713530.20529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44079 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab2K2RRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 12:17:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

well it seems that I did miss at least one important clock patch for v3.8.  
This appears to be needed to avoid failures when attempting to set parent 
clocks for GPTIMER5-7 on OMAP4.  Could you consider this one for late 
v3.8?  If you prefer, I can send a pull request for it.  Otherwise, will 
send it as part of the v3.8-rc1 integration fixes.

thanks,


- Paul

---------- Forwarded message ----------
Date: Thu, 29 Nov 2012 11:02:17 -0600
From: Jon Hunter <jon-hunter@ti.com>
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>,
    linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] ARM: OMAP4: Update timer clock aliases


On 11/29/2012 04:53 AM, Paul Walmsley wrote:
> Hi Jon,
> 
> On Wed, 7 Nov 2012, Jon Hunter wrote:
> 
>> Commit "ARM: dts: OMAP4: Update timer addresses" updated the device-tree
>> names of the OMAP4 timers 5-7 because the default address for the timers
>> was changed from the L3 address to the MPU private address. When booting
>> with device-tree, this introduces a regression when attempting to set
>> the parent clock of timers 5-7 to the sys_clk_div_ck. Therefore, update
>> the clock aliases for timer 5-7 to reflect the updated device-tree name
>> for the timers.
> 
> Reviewing my E-mail inbox, just saw that this one is marked as being 
> needed for v3.8.  Is that still the case?  If so, we should ask Tony to 
> take an updated version of this patch, given the recent CCF conversion.

Yes this is still needed for v3.8.

> Following is the updated patch.

Thanks, looks good to me.

Cheers
Jon


From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 29 Nov 2012 03:47:46 -0700
Subject: [PATCH] ARM: OMAP4: Update timer clock aliases

Commit "ARM: dts: OMAP4: Update timer addresses" updated the device-tree
names of the OMAP4 timers 5-7 because the default address for the timers
was changed from the L3 address to the MPU private address. When booting
with device-tree, this introduces a regression when attempting to set
the parent clock of timers 5-7 to the sys_clk_div_ck. Therefore, update
the clock aliases for timer 5-7 to reflect the updated device-tree name
for the timers.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[paul@pwsan.com: updated to apply after the CCF conversion]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index aa56c3e..a1f0b55 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1935,10 +1935,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4803e000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("48086000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("48088000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("49038000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("40138000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
 };
 
-- 
1.7.10.4

