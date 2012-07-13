From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 8/8] ARM: OMAP3: do not delete per_clkdm autodeps during idle
Date: Fri, 13 Jul 2012 17:19:45 +0300
Message-ID: <1342189185-5306-9-git-send-email-t-kristo@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33583 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163026Ab2GMOU5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 10:20:57 -0400
In-Reply-To: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Previously, PER clock domain was always enabled, as the usecounts
for this domain incorrectly always showed positive value. On HW
level though, the domain enters idle as it is set in HW supervised
mode. Now, when the usecounts reflect real values, PER domain
will be put to HWSUP sleep mode, which means its autodeps are deleted.
Removing wakedeps for PER domain will cause multiple problems.
First of all, coming back from idle, PER domain remains idle as the
wakedeps have been disabled for the domain, and this causes a crash
with the GPIO code, as the resume code attempts to access domain
which is not active. Just enabling the interface clocks for the GPIO
does not help, as they are autoidled and don't bring the domain out
of idle. Secondly, there are multiple erratas for omap3, which say
that the wakedeps should be enabled for the PER domain, see e.g.
errata i582 for omap3630.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index 6038adb..5658440 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
 static struct clockdomain per_clkdm = {
 	.name		= "per_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_NO_AUTODEP_DISABLE,
 	.dep_bit	= OMAP3430_EN_PER_SHIFT,
 	.wkdep_srcs	= per_wkdeps,
 	.sleepdep_srcs	= per_sleepdeps,
-- 
1.7.4.1

