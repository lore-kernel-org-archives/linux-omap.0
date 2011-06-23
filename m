From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 19/25] ARM: pm: samsung: no need to call flush_cache_all()
Date: Thu, 23 Jun 2011 20:15:27 +0100
Message-ID: <E1QZpN9-0005nL-O7@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The core suspend code calls flush_cache_all() immediately prior to
calling the suspend finisher function, so remove these needless calls
from the finisher functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-s3c2412/pm.c |    2 --
 arch/arm/mach-s3c2416/pm.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2412/pm.c b/arch/arm/mach-s3c2412/pm.c
index fecd854..9a1fb89 100644
--- a/arch/arm/mach-s3c2412/pm.c
+++ b/arch/arm/mach-s3c2412/pm.c
@@ -41,8 +41,6 @@ static void s3c2412_cpu_suspend(unsigned long arg)
 {
 	unsigned long tmp;
 
-	flush_cache_all();
-
 	/* set our standby method to sleep */
 
 	tmp = __raw_readl(S3C2412_PWRCFG);
diff --git a/arch/arm/mach-s3c2416/pm.c b/arch/arm/mach-s3c2416/pm.c
index 268fda7..9e67a2a 100644
--- a/arch/arm/mach-s3c2416/pm.c
+++ b/arch/arm/mach-s3c2416/pm.c
@@ -26,8 +26,6 @@ extern void s3c2412_sleep_enter(void);
 
 static void s3c2416_cpu_suspend(unsigned long arg)
 {
-	flush_cache_all();
-
 	/* enable wakeup sources regardless of battery state */
 	__raw_writel(S3C2443_PWRCFG_SLEEP, S3C2443_PWRCFG);
 
-- 
1.7.4.4
