From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 3/5] ARM: OMAP: Fix 24xx mcbsp clocks
Date: Thu, 29 May 2008 12:50:48 -0400
Message-ID: <1212079850-28202-4-git-send-email-edubezval@gmail.com>
References: <1212079850-28202-1-git-send-email-edubezval@gmail.com>
 <1212079850-28202-2-git-send-email-edubezval@gmail.com>
 <1212079850-28202-3-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49619 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbYE2Quw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 12:50:52 -0400
In-Reply-To: <1212079850-28202-3-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

From: Tony Lindgren <tony@atomide.com>

Fix 24xx mcbsp clocks

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.h |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index ee39794..00ca071 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1820,7 +1820,8 @@ static struct clk gpt12_fck = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp1_ick",
+	.name		= "mcbsp_ick",
+	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1830,7 +1831,8 @@ static struct clk mcbsp1_ick = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp1_fck",
+	.name		= "mcbsp_fck",
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1840,7 +1842,8 @@ static struct clk mcbsp1_fck = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp2_ick",
+	.name		= "mcbsp_ick",
+	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1850,7 +1853,8 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp2_fck",
+	.name		= "mcbsp_fck",
+	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1860,7 +1864,8 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp3_ick",
+	.name		= "mcbsp_ick",
+	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1870,7 +1875,8 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
+	.name		= "mcbsp_fck",
+	.id		= 3,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1880,7 +1886,8 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp4_ick",
+	.name		= "mcbsp_ick",
+	.id		= 4,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1890,7 +1897,8 @@ static struct clk mcbsp4_ick = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
+	.name		= "mcbsp_fck",
+	.id		= 4,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1900,7 +1908,8 @@ static struct clk mcbsp4_fck = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp5_ick",
+	.name		= "mcbsp_ick",
+	.id		= 5,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1910,7 +1919,8 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp5_fck",
+	.name		= "mcbsp_fck",
+	.id		= 5,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
-- 
1.5.5.GIT

