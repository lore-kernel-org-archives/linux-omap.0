From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to
 support only SWSUP
Date: Wed, 31 Oct 2012 04:43:12 -0600
Message-ID: <20121031104309.6557.72704.stgit@dusk.lan>
References: <20121031103607.6557.64591.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51161 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab2JaKqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 06:46:38 -0400
In-Reply-To: <20121031103607.6557.64591.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Miguel Vadillo <vadillo@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Miguel Vadillo <vadillo@ti.com>

Since CAM domain (ISS) has no module wake-up dependency
with any other clock domain of the device and the dynamic
dependency from L3_main_2 is always disabled, the domain
needs to be in force wakeup in order to be able to access
it for configure (sysconfig) it or use it.

Also since there is no clock in the domain managed automatically
by the hardware, there is no use to configure automatic
clock domain transition. SW should keep the SW_WKUP domain
transition as long as a module in the domain is required to
be functional.

Signed-off-by: Miguel Vadillo <vadillo@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index b56d06b..95192a0 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -359,7 +359,7 @@ static struct clockdomain iss_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CAM_CAM_CDOFFS,
 	.wkdep_srcs	  = iss_wkup_sleep_deps,
 	.sleepdep_srcs	  = iss_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain l3_dss_44xx_clkdm = {


