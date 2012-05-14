From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 6/8] ARM: OMAP4: pwrdm: add support for reading prev logic and mem states
Date: Mon, 14 May 2012 13:03:14 +0300
Message-ID: <1336989796-26594-7-git-send-email-t-kristo@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44094 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679Ab2ENKDn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:03:43 -0400
In-Reply-To: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

On OMAP4, there is no support to read previous logic state
or previous memory state achieved when a power domain transitions
to RET. Instead there are module level context registers.

In order to support the powerdomain level logic/mem_off_counters
on OMAP4, instead use the previous power state achieved (RET) and
the *programmed* logic/mem RET state to derive if a powerdomain lost
logic or did not.

If the powerdomain is programmed to enter RET state and lose logic
in RET state, knowing that the powerdomain entered RET is good enough
to derive that the logic was lost as well, in such cases.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain44xx.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 601325b..ab00736 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -151,6 +151,21 @@ static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 	return v;
 }
 
+static int omap4_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
+{
+	int state;
+
+	state = omap4_pwrdm_read_prev_pwrst(pwrdm);
+
+	if (state == PWRDM_POWER_OFF)
+		return PWRDM_POWER_OFF;
+
+	if (state != PWRDM_POWER_RET)
+		return PWRDM_POWER_ON;
+
+	return omap4_pwrdm_read_logic_retst(pwrdm);
+}
+
 static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
 	u32 m, v;
@@ -179,6 +194,21 @@ static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 	return v;
 }
 
+static int omap4_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	int state;
+
+	state = omap4_pwrdm_read_prev_pwrst(pwrdm);
+
+	if (state == PWRDM_POWER_OFF)
+		return PWRDM_POWER_OFF;
+
+	if (state != PWRDM_POWER_RET)
+		return PWRDM_POWER_ON;
+
+	return omap4_pwrdm_read_mem_retst(pwrdm, bank);
+}
+
 static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 {
 	u32 c = 0;
@@ -217,9 +247,11 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
+	.pwrdm_read_prev_logic_pwrst	= omap4_pwrdm_read_prev_logic_pwrst,
 	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
 	.pwrdm_read_mem_pwrst	= omap4_pwrdm_read_mem_pwrst,
 	.pwrdm_read_mem_retst	= omap4_pwrdm_read_mem_retst,
+	.pwrdm_read_prev_mem_pwrst	= omap4_pwrdm_read_prev_mem_pwrst,
 	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
 	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
-- 
1.7.4.1

