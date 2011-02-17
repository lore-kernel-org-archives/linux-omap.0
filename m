From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] OMAP2xxx: clock: fix low-frequency oscillator clock rate
Date: Wed, 16 Feb 2011 21:17:52 -0700
Message-ID: <20110217041751.16009.33809.stgit@twilight.localdomain>
References: <20110217041437.16009.52336.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55845 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab1BQES3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 23:18:29 -0500
In-Reply-To: <20110217041437.16009.52336.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP2420/2430 external 32-kHz low-frequency oscillator is a 32768
Hz oscillator, not a 32,000 Hz oscillator[1][2].  Fix this in the clock
tree.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

1. OMAP2420/22 Multimedia Processor Data Manual, Version P [SWPS019P],
   section 5.1.4 "External 32-kHz CMOS Clock" (note that it refers to
   a "32.768-kHz" clock; this presumably should be "32.768-KHz")

2. OMAP2430 Multimedia Processor ES2.1 Data Manual, Version V [SWPS023V],
   section 5.1.4 "External 32-kHz CMOS Clock" (note that it refers to
   a "32.768-kHz" clock; this presumably should be "32.768-KHz")
---
 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 693a0a8..fd5ba90 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -55,7 +55,7 @@
 static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
-	.rate		= 32000,
+	.rate		= 32768,
 	.clkdm_name	= "wkup_clkdm",
 };
 
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index f00f52e..0d069ef 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -55,7 +55,7 @@
 static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
-	.rate		= 32000,
+	.rate		= 32768,
 	.clkdm_name	= "wkup_clkdm",
 };
 


