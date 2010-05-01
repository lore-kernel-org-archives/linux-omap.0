From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: omap-pm: omap3_pm_defconfig no longer booting on Overo
Date: Sat, 01 May 2010 10:32:41 -0500
Message-ID: <4BDC4999.4050003@gmail.com>
References: <4BD93413.6000409@gmail.com> <8739yckbyy.fsf@deeprootsystems.com> <4BDB9C05.5050307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060405000800030906050009"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38888 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0EAPct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 11:32:49 -0400
Received: by gyg13 with SMTP id 13so560561gyg.19
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 08:32:48 -0700 (PDT)
In-Reply-To: <4BDB9C05.5050307@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405000800030906050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 04/30/2010 10:12 PM, Peter Tseng wrote:
> On 04/30/2010 02:54 PM, Kevin Hilman wrote:
>> Peter Tseng<tsenpet09@gmail.com>  writes:
>>
>>> Since the rc5 tag, omap3_pm_defconfig from the pm branch no longer boots
>>> on the Gumstix Overo.
>>> I am certain that a build back in the rc3 days worked. Unfortunately, I
>>> don't know about rc4, or anything that happenend in the intervening time.
>>>
>>> Any clues on how to fix? If necessary, I'll provide what info I can to
>>> help diagnose the issue if told what to do.
>>
>> First step is to enable CONFIG_LL_DEBUG and CONFIG_EARLYPRINTK in the
>> defconfig (I should have these enabled by default in omap3_pm_defconfig)
>>
>> Then, boot adding 'earlyprintk' to your boot cmdline and post the
>> resulting bootlog here.
>
> Here it is. (Forgot to also send to mailing list the first time around)
>
> Peter Tseng

DISCLAIMER: I dont have a overo, so no idea if this would work.. but 
here you go..

Attached is a diff which probably will help you with the specific 
changes needed for making pm boot on overo. hope it helps..

a.diff is the change you would probably need for the overo file to fix 
it up once for all

the patch file is cleaning up the unnecessary BUG() in resource34xx.c 
which caused the lockup -> elegant fix will potentially need more 
cleaning up.. but lets just leave it at the fact that srf is going to go 
away in a month or so..

Regards,
Nishanth Menon

--------------060405000800030906050009
Content-Type: text/x-patch;
 name="a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="a.diff"

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8848c7c..a93ae3d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -49,6 +49,8 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
+#include "pm.h"
+#include "omap3-opp.h"
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
@@ -71,6 +73,26 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
+/*
+ * FIXME: These are not the optimal setup values to be used on overo
+ * Hacked from board-3430sdp.c
+ */
+static struct prm_setup_vc omap3_setuptime_table = {
+	.clksetup = 0xff,
+	.voltsetup_time1 = 0xfff,
+	.voltsetup_time2 = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+	.vdd0_on = 0x30,
+	.vdd0_onlp = 0x20,
+	.vdd0_ret = 0x1e,
+	.vdd0_off = 0x00,
+	.vdd1_on = 0x2c,
+	.vdd1_onlp = 0x20,
+	.vdd1_ret = 0x1e,
+	.vdd1_off = 0x00,
+};
+
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
@@ -384,6 +406,8 @@ static void __init overo_init_irq(void)
 {
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap3_pm_init_opp_table();
+	omap3_pm_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();

--------------060405000800030906050009
Content-Type: text/x-patch;
 name="0001-OMAP3-PM-quickly-hack-fix-up-init_opp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-OMAP3-PM-quickly-hack-fix-up-init_opp.patch"

>From 54d5b1b47560fc4d790834c760dc5140d48e25ab Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Sat, 1 May 2010 10:25:25 -0500
Subject: [RFC] [PATCH] OMAP3: PM: quickly hack fix up init_opp

init_opp is seen to crash, in resource34xx.c BUG() causes
a kernel oops when OPP layer is not registered!

Original Report:
http://marc.info/?l=linux-omap&m=127268352116119&w=2

Cc: Peter Tseng <tsenpet09@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Reported-by: Peter Tseng <tsenpet09@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>

---
Completely untested!! just for a dry-run and srf is going to go off
in a month, so this is more or less a curio..

 arch/arm/mach-omap2/resource34xx.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index c6cce8b..2297385 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -226,14 +226,36 @@ void init_opp(struct shared_resource *resp)
 		dpll1_clk = clk_get(NULL, "dpll1_ck");
 		dpll2_clk = clk_get(NULL, "dpll2_ck");
 		ret = freq_to_opp(&opp_id, OPP_MPU, dpll1_clk->rate);
-		BUG_ON(ret); /* TBD Cleanup handling */
+		if (ret) {
+			pr_err("%s: initializing %s failed! !match for %ld\n",
+				__func__, resp->name, dpll1_clk->rate);
+			if (dpll1_clk)
+				clk_put(dpll1_clk);
+			if (dpll2_clk)
+				clk_put(dpll2_clk);
+			dpll1_clk = NULL;
+			dpll2_clk = NULL;
+			vdd1_resp = NULL;
+			return;
+		}
 		curr_vdd1_opp = opp_id;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		vdd2_resp = resp;
 		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
 		l3_clk = clk_get(NULL, "l3_ick");
 		ret = freq_to_opp(&opp_id, OPP_L3, l3_clk->rate);
-		BUG_ON(ret); /* TBD Cleanup handling */
+		if (ret) {
+			pr_err("%s: initializing %s failed! !match for %ld\n",
+				__func__, resp->name, l3_clk->rate);
+			if (l3_clk)
+				clk_put(l3_clk);
+			if (dpll3_clk)
+				clk_put(dpll3_clk);
+			l3_clk = NULL;
+			dpll3_clk = NULL;
+			vdd1_resp = NULL;
+			return;
+		}
 		curr_vdd2_opp = opp_id;
 	}
 	resp->curr_level = opp_id;
-- 
1.7.0.4


--------------060405000800030906050009--
