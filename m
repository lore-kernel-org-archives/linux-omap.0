From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
Date: Tue, 24 Nov 2009 12:37:03 +0200
Message-ID: <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34510 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708AbZKXKkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 05:40:47 -0500
In-Reply-To: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

In some ARM architectures, like OMAP3, the VFP context can be lost during
dynamic sleep cycle. For this purpose, there is now a function
vfp_pm_save_context() that should be called before the VFP is assumed to
lose context. Next VFP trap will then restore context automatically.

We need to have the last_VFP_context[cpu] cleared after the save in idle,
else the restore would fail to restore when it sees that the last_VFP_context
is same as the current threads vfp_state. This happens when the same
process/thread traps an exception post idle.

Main work for this patch was done by Peter and Rajendra. Some cleanup and
optimization by Tero.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/vfp/vfpmodule.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2d7423a..80a08bd 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -329,6 +329,31 @@ static void vfp_enable(void *unused)
 #ifdef CONFIG_PM
 #include <linux/sysdev.h>
 
+void vfp_pm_save_context(void)
+{
+	struct thread_info *thread = current_thread_info();
+	u32 fpexc = fmrx(FPEXC);
+	__u32 cpu = thread->cpu;
+
+	if (last_VFP_context[cpu]) {
+		if (!(fpexc & FPEXC_EN)) {
+			/* enable vfp now to save context */
+			vfp_enable(NULL);
+			fmxr(FPEXC, fmrx(FPEXC) | FPEXC_EN);
+		}
+		vfp_save_state(last_VFP_context[cpu], fpexc);
+
+		/* Disable vfp. The next inst traps an exception and restores*/
+		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+
+		/*
+		 * This is needed else the restore might fail if it sees
+		 * last_VFP_context if same as the current threads vfp_state.
+		 */
+		last_VFP_context[cpu] = NULL;
+	}
+}
+
 static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct thread_info *ti = current_thread_info();
-- 
1.5.4.3

