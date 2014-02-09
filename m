From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 28/28] Remove LOCAL_TIMERS
Date: Sun,  9 Feb 2014 19:48:06 +0100
Message-ID: <1391971686-9517-29-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391971686-9517-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "moderated list:ARM
	SUB-ARCHITECT..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>
List-Id: linux-omap@vger.kernel.org

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/mach-omap2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 653b489..2817f1f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -54,7 +54,6 @@ config SOC_OMAP5
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
 	select HAVE_ARM_ARCH_TIMER
 	select ARM_ERRATA_798181 if SMP
-- 
1.8.4.2
