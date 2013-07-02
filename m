From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 2/9] ARM: OMAP2+: CM code: Reintroduce SW_SLEEP for OMAP4 class of devices
Date: Tue, 2 Jul 2013 16:58:11 +0530
Message-ID: <1372764498-32503-3-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41804 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab3GBL30 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 07:29:26 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Commit 65aa94b (ARM: OMAP4: clockdomain/CM code: Update supported transition modes)
removed SW_SLEEP mode for clockdomains on OMAP4 class of devices. Not having
SW_SLEEP mode works fine for OMAP4/5 devices but it gets in the way of other
devices like AM335x which have the same hardware underneath but support only
SW_SLEEP/SW_WKUP modes. So far, AM335x has been uses its own set of PRM/CM
APIs and hence the lack of SW_SLEEP mode in the OMAP4 code was not a problem.
However we would like to consolidate the AM335x and OMAP4 code and reintroducing
this mode is necessary. Doing so also makes the API consistent with what
the comments states.

While here also fixup a trivial typo in the comment.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index f0290f5..2d1d4ef 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -237,7 +237,7 @@ void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs)
 }
 
 /**
- * omap4_cminst_clkdm_force_sleep - try to take a clockdomain out of idle
+ * omap4_cminst_clkdm_force_wakeup - try to take a clockdomain out of idle
  * @part: PRCM partition ID that the clockdomain registers exist in
  * @inst: CM instance register offset (*_INST macro)
  * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
@@ -250,6 +250,20 @@ void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, part, inst, cdoffs);
 }
 
+/**
+ * omap4_cminst_clkdm_force_sleep - try to put a clockdomain to idle
+ * @part: PRCM partition ID that the clockdomain registers exist in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * Put a clockdomain referred to by (@part, @inst, @cdoffs) to idle,
+ * forcing it to sleep.  No return value.
+ */
+void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs)
+{
+	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
+}
+
 /*
  *
  */
@@ -404,7 +418,7 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
 
 static int omap4_clkdm_sleep(struct clockdomain *clkdm)
 {
-	omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
+	omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
 					clkdm->cm_inst, clkdm->clkdm_offs);
 	return 0;
 }
-- 
1.8.1

