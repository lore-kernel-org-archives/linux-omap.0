From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/5] ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm to SW_WKUP
Date: Mon, 1 Jun 2015 17:23:30 +0530
Message-ID: <1433159614-437-2-git-send-email-vigneshr@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433159614-437-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Legacy IPs like PWMSS, present under l4per2_7xx_clkdm, cannot support
smart-idle when its clock domain is in HW_AUTO on DRA7 SoCs. Hence,
program clock domain to SW_WKUP.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index 57d5df0c1fbd..7581e036bda6 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -331,7 +331,7 @@ static struct clockdomain l4per2_7xx_clkdm = {
 	.dep_bit	  = DRA7XX_L4PER2_STATDEP_SHIFT,
 	.wkdep_srcs	  = l4per2_wkup_sleep_deps,
 	.sleepdep_srcs	  = l4per2_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain mpu0_7xx_clkdm = {
-- 
2.4.1
