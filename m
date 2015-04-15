From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 18/35] ARM: OMAP3+: cpuidle: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:05 +0300
Message-ID: <1429102402-5276-19-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42519 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521AbbDOMxB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:01 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 arch/arm/mach-omap2/cpuidle44xx.c |    2 +-
 arch/arm/mach-omap2/pm.h          |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index aa7b379..0f149d8 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -323,7 +323,7 @@ static struct cpuidle_driver omap3_idle_driver = {
  * Registers the OMAP3 specific cpuidle driver to the cpuidle
  * framework with the valid set of states.
  */
-int __init omap3_idle_init(void)
+int omap3_idle_init(void)
 {
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 01e398a..72e47d7 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -231,7 +231,7 @@ static struct cpuidle_driver omap4_idle_driver = {
  * Registers the OMAP4+ specific cpuidle driver to the cpuidle
  * framework with the valid set of states.
  */
-int __init omap4_idle_init(void)
+int omap4_idle_init(void)
 {
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 425bfcd..dc02ce8 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -16,8 +16,8 @@
 #include "powerdomain.h"
 
 #ifdef CONFIG_CPU_IDLE
-extern int __init omap3_idle_init(void);
-extern int __init omap4_idle_init(void);
+int omap3_idle_init(void);
+int omap4_idle_init(void);
 #else
 static inline int omap3_idle_init(void)
 {
-- 
1.7.9.5

