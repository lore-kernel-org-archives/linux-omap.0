From: jean.pihet@newoldbits.com
Subject: [PATCH 24/26] OMAP3+: voltage: export functions to plat/voltage.h
Date: Tue, 22 Nov 2011 16:06:08 +0100
Message-ID: <1321974370-25800-25-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252Ab1KVPHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:35 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:35 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Move some functions from mach-omap2/ dir to the plat/ dir.
The SmartReflex class driver is a user of the basic voltage domains
functions (enable, disable, reset).

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.h             |    1 -
 arch/arm/mach-omap2/vp.h                  |    2 --
 arch/arm/plat-omap/include/plat/voltage.h |    3 +++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index ebd8899..c2b7339 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -169,6 +169,5 @@ int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
 			  int (*fn)(struct voltagedomain *voltdm,
 				    struct powerdomain *pwrdm));
 int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
-void voltdm_reset(struct voltagedomain *voltdm);
 unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
 #endif
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 7c155d2..837cb8d 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -118,8 +118,6 @@ extern struct omap_vp_instance omap4_vp_iva;
 extern struct omap_vp_instance omap4_vp_core;
 
 void omap_vp_init(struct voltagedomain *voltdm);
-void omap_vp_enable(struct voltagedomain *voltdm);
-void omap_vp_disable(struct voltagedomain *voltdm);
 int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 			      unsigned long target_volt);
 int omap_vp_update_errorgain(struct voltagedomain *voltdm,
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 0a6a482..1842709 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -16,5 +16,8 @@ struct voltagedomain;
 struct voltagedomain *voltdm_lookup(const char *name);
 int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
+void voltdm_reset(struct voltagedomain *voltdm);
 
+void omap_vp_enable(struct voltagedomain *voltdm);
+void omap_vp_disable(struct voltagedomain *voltdm);
 #endif
-- 
1.7.5.4

