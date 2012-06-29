From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix Wake-up power domain power status
Date: Fri, 29 Jun 2012 15:49:11 -0500
Message-ID: <1341002951-11839-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723Ab2F2UtY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 16:49:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The wake-up power domain is an alway-on power domain and so this power domain
does not have a power state status (PM_PWSTST_xxx) register that indicates the
current state. However, during the registering of the wake-up power domain the
state of the domain is queried by calling pwrdm_read_pwrst(). This actually
tries to read a register that does not exist and returns a value of 0 that
indicates that the current state is OFF. The OFF state count of the wake-up
power domain is then set to 1 and the current state to OFF. Both of which are
incorrect.

To fix this, if a power domain only supports the ON state, do not attempt to
read the power state status register and simply return ON as the current power
state.

This is based upon Tony's current linux-omap master branch.

Testing:
- Boot tested on OMAP4460 panda.
- Boot tested on OMAP3430 beagle and validated CORE RET still working (using
  Paul's 32k timer patch [1]).

[1] http://marc.info/?l=linux-omap&m=134000053229888&w=2

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index eefe179..8a509b1 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -535,6 +535,9 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
+	if (pwrdm->pwrsts == PWRSTS_ON)
+		return PWRDM_POWER_ON;
+
 	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
 		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
 
-- 
1.7.9.5

