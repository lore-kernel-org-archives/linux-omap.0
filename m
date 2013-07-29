From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 2/2] ARM: OMAP2+: hwmod: Do the late part of init and setup/reset on first enable
Date: Mon, 29 Jul 2013 14:42:42 +0530
Message-ID: <1375089162-30664-3-git-send-email-rnayak@ti.com>
References: <1375089162-30664-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50282 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3G2JNY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 05:13:24 -0400
In-Reply-To: <1375089162-30664-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

Instead of doing a complete init and setup(including reset) of all modules
early at boot, do it when a module is asked to be enabled the first time.
This should get rid of all the need for having all the rest of PM frameworks
in place quite early at boot, and should also make sure reset happens only
when drivers are initializing the modules.

For the modules which do not have drivers build in, do this as part of a
late initcall.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e49159c..7e4d602 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2082,6 +2082,9 @@ static int _enable_preprogram(struct omap_hwmod *oh)
 	return oh->class->enable_preprogram(oh);
 }
 
+static int _init_late(struct omap_hwmod *oh, void *data);
+static void _setup_iclk_autoidle(struct omap_hwmod *oh);
+
 /**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
@@ -2094,9 +2097,17 @@ static int _enable(struct omap_hwmod *oh)
 {
 	int r;
 	int hwsup = 0;
+	bool needs_reset;
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
+	if (oh->_state == _HWMOD_STATE_REGISTERED) {
+		_init_late(oh, NULL);
+		_setup_iclk_autoidle(oh);
+		if (!(oh->flags & HWMOD_INIT_NO_RESET))
+			needs_reset = true;
+	}
+
 	/*
 	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left in enabled
 	 * state at init.  Now that someone is really trying to enable
@@ -2200,6 +2211,9 @@ static int _enable(struct omap_hwmod *oh)
 			clkdm_hwmod_disable(oh->clkdm, oh);
 	}
 
+	if (needs_reset)
+		r = _reset(oh);
+
 	return r;
 }
 
@@ -3309,13 +3323,27 @@ static int __init omap_hwmod_setup_all(void)
 	_ensure_mpu_hwmod_is_setup(NULL);
 
 	omap_hwmod_for_each(_init_early, NULL);
-	omap_hwmod_for_each(_init_late, NULL);
-	omap_hwmod_for_each(_setup, NULL);
 
 	return 0;
 }
 omap_core_initcall(omap_hwmod_setup_all);
 
+static int __init omap_hwmod_setup_rest(void)
+{
+	struct omap_hwmod *oh;
+
+	_ensure_mpu_hwmod_is_setup(NULL);
+
+	list_for_each_entry(oh, &omap_hwmod_list, node) {
+		if (oh->_state == _HWMOD_STATE_REGISTERED) {
+			_init_late(oh, NULL);
+			_setup(oh, NULL);
+		}
+	}
+	return 0;
+}
+omap_late_initcall(omap_hwmod_setup_rest);
+
 /**
  * omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
-- 
1.7.9.5

