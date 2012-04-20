From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 6/8] ARM: OMAP4: PM: support ret_logic/mem_off_counters
Date: Fri, 20 Apr 2012 12:19:49 +0300
Message-ID: <1334913591-26312-7-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab2DTJUV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:20:21 -0400
In-Reply-To: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Axel Haslam <axelhaslam@gmail.com>, Rajendra Nayak <rnayak@ti.com>

From: Axel Haslam <axelhaslam@gmail.com>

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

Signed-off-by: Axel Haslam <axelhaslam@gmail.com>
[rnayak@ti.com: Updated changelog, updated patch to support mem counters]
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 96ad3dbe..068f06b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -124,18 +124,22 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 static void _update_logic_membank_counters(struct powerdomain *pwrdm)
 {
 	int i;
-	u8 prev_logic_pwrst, prev_mem_pwrst;
+	int logic_pwrst, mem_pwrst;
+
+	logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
+	if (logic_pwrst == -EINVAL)
+		logic_pwrst = pwrdm_read_logic_retst(pwrdm);
 
-	prev_logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
 	if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
-	    (prev_logic_pwrst == PWRDM_POWER_OFF))
+	    (logic_pwrst == PWRDM_POWER_OFF))
 		pwrdm->ret_logic_off_counter++;
 
 	for (i = 0; i < pwrdm->banks; i++) {
-		prev_mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
-
+		mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
+		if (mem_pwrst == -EINVAL)
+			mem_pwrst = pwrdm_read_mem_retst(pwrdm, i);
 		if ((pwrdm->pwrsts_mem_ret[i] == PWRSTS_OFF_RET) &&
-		    (prev_mem_pwrst == PWRDM_POWER_OFF))
+		    (mem_pwrst == PWRDM_POWER_OFF))
 			pwrdm->ret_mem_off_counter[i]++;
 	}
 }
-- 
1.7.4.1

