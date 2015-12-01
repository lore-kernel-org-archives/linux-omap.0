From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] ARM: OMAP2+: Enable GPIO for dm814x
Date: Tue,  1 Dec 2015 15:38:17 -0800
Message-ID: <1449013103-23238-5-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

With the basic clocks now working we can enable GPIO.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index d5246b3..1b96cdf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -1230,8 +1230,6 @@ static struct omap_hwmod_ocp_if dm81xx_tptc3__alwon_l3_fast = {
 
 /*
  * REVISIT: Test and enable the following once clocks work:
- * dm81xx_l4_ls__gpio1
- * dm81xx_l4_ls__gpio2
  * dm81xx_l4_ls__mailbox
  * dm81xx_alwon_l3_slow__gpmc
  * dm81xx_default_l3_slow__usbss
@@ -1250,6 +1248,8 @@ static struct omap_hwmod_ocp_if *dm814x_hwmod_ocp_ifs[] __initdata = {
 	&dm81xx_l4_ls__wd_timer1,
 	&dm81xx_l4_ls__i2c1,
 	&dm81xx_l4_ls__i2c2,
+	&dm81xx_l4_ls__gpio1,
+	&dm81xx_l4_ls__gpio2,
 	&dm81xx_l4_ls__elm,
 	&dm81xx_l4_ls__mcspi1,
 	&dm81xx_alwon_l3_fast__tpcc,
-- 
2.6.2
