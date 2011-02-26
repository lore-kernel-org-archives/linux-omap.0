From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/4] OMAP2/3: clockdomains: remove warnings on an OMAP3-only
	compile
Date: Fri, 25 Feb 2011 17:20:07 -0700
Message-ID: <20110226002006.28142.52520.stgit@twilight.localdomain>
References: <20110226001601.28142.46636.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46817 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab1BZAUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 19:20:49 -0500
In-Reply-To: <20110226001601.28142.46636.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Resolve these compile-time gcc warnings on OMAP3-only kernel compiles:

.../mach-omap2/clockdomains2xxx_3xxx_data.c:95: warning: 'dsp_24xx_wkdeps' defined but not used
.../mach-omap2/clockdomains2xxx_3xxx_data.c:119: warning: 'mpu_24xx_wkdeps' defined but not used
.../mach-omap2/clockdomains2xxx_3xxx_data.c:147: warning: 'core_24xx_wkdeps' defined but not used

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index ffdfe54..f9df791 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -89,6 +89,8 @@ static struct clkdm_dep gfx_sgx_wkdeps[] = {
 
 /* 24XX-specific possible dependencies */
 
+#ifdef CONFIG_ARCH_OMAP2
+
 /* Wakeup dependency source arrays */
 
 /* 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP */
@@ -168,6 +170,8 @@ static struct clkdm_dep core_24xx_wkdeps[] = {
 	{ NULL },
 };
 
+#endif
+
 
 /* 2430-specific possible wakeup dependencies */
 


