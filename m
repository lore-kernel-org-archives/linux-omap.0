From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 5/7] ARM: OMAP4: pwrdm: add support for reading prev logic and mem states
Date: Mon, 11 Jun 2012 18:26:25 +0300
Message-ID: <1339428387-4800-6-git-send-email-t-kristo@ti.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50670 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730Ab2FKP0x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:26:53 -0400
In-Reply-To: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
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
 arch/arm/mach-omap2/powerdomain44xx.c |   59 +++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 030d10c..ab93f08 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -151,6 +151,34 @@ static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 	return v;
 }
 
+/**
+ * omap4_pwrdm_read_prev_logic_pwrst - read the previous logic powerstate
+ * @pwrdm: struct powerdomain * to read the state for
+ *
+ * Reads the previous logic powerstate for a powerdomain. This function
+ * must determine the previous logic powerstate by first checking the
+ * previous powerstate for the domain. If that was OFF, then logic has
+ * been lost. If previous state was RETENTION, the function reads the
+ * setting for the next retention logic state to see the actual value.
+ * In every other case, the logic is retained. Returns either
+ * PWRDM_LOGIC_MEM_PWRST_OFF or PWRDM_LOGIC_MEM_PWRST_RET depending
+ * whether the logic was retained or not.
+ */
+static int omap4_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
+{
+	int state;
+
+	state = omap4_pwrdm_read_prev_pwrst(pwrdm);
+
+	if (state == PWRDM_POWER_OFF)
+		return PWRDM_LOGIC_MEM_PWRST_OFF;
+
+	if (state != PWRDM_POWER_RET)
+		return PWRDM_LOGIC_MEM_PWRST_RET;
+
+	return omap4_pwrdm_read_logic_retst(pwrdm);
+}
+
 static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
 	u32 m, v;
@@ -179,6 +207,35 @@ static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 	return v;
 }
 
+/**
+ * omap4_pwrdm_read_prev_mem_pwrst - reads the previous memory powerstate
+ * @pwrdm: struct powerdomain * to read mem powerstate for
+ * @bank: memory bank index
+ *
+ * Reads the previous memory powerstate for a powerdomain. This function
+ * must determine the previous memory powerstate by first checking the
+ * previous powerstate for the domain. If that was OFF, then logic has
+ * been lost. If previous state was RETENTION, the function reads the
+ * setting for the next memory retention state to see the actual value.
+ * In every other case, the logic is retained. Returns either
+ * PWRDM_LOGIC_MEM_PWRST_OFF or PWRDM_LOGIC_MEM_PWRST_RET depending
+ * whether logic was retained or not.
+ */
+static int omap4_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	int state;
+
+	state = omap4_pwrdm_read_prev_pwrst(pwrdm);
+
+	if (state == PWRDM_POWER_OFF)
+		return PWRDM_LOGIC_MEM_PWRST_OFF;
+
+	if (state != PWRDM_POWER_RET)
+		return PWRDM_LOGIC_MEM_PWRST_RET;
+
+	return omap4_pwrdm_read_mem_retst(pwrdm, bank);
+}
+
 static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 {
 	u32 c = 0;
@@ -220,9 +277,11 @@ struct pwrdm_ops omap4_pwrdm_operations = {
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

