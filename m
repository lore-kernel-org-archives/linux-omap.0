From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to support
 only SWSUP
Date: Thu, 18 Oct 2012 15:39:05 +0200
Message-ID: <50800679.2030202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56763 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab2JRNjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 09:39:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

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

Hi Tony,

Here is a fix that Miguel sent me some time back and that I forgot until
I face the crash again while trying to enable the ISS for test.

Regards,
Benoit

 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
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
-- 
1.7.0.4
