From: jean.pihet@newoldbits.com
Subject: [PATCH 10/26] OMAP2+: rename struct omap_sr_class_data to smartreflex_class_data
Date: Tue, 22 Nov 2011 16:05:54 +0100
Message-ID: <1321974370-25800-11-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078Ab1KVPHH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:07 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:07 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Makes the code non-OMAP specific.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
 arch/arm/mach-omap2/smartreflex.c        |    4 ++--
 arch/arm/mach-omap2/smartreflex.h        |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 190f330..c9ea22f 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -43,7 +43,7 @@ static int sr_class3_configure(struct smartreflex *sr)
 }
 
 /* SR class3 structure */
-static struct omap_sr_class_data class3_data = {
+static struct smartreflex_class_data class3_data = {
 	.enable = sr_class3_enable,
 	.disable = sr_class3_disable,
 	.configure = sr_class3_configure,
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e856d9f..3b10245 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -37,7 +37,7 @@
 /* sr_list contains all the instances of smartreflex module */
 static LIST_HEAD(sr_list);
 
-static struct omap_sr_class_data *sr_class;
+static struct smartreflex_class_data *sr_class;
 static struct omap_sr_pmic_data *sr_pmic_data;
 static struct dentry		*sr_dbg_dir;
 
@@ -554,7 +554,7 @@ void sr_disable(struct smartreflex *sr)
  * with the smartreflex driver during init. Returns 0 on success else the
  * error value.
  */
-int sr_register_class(struct omap_sr_class_data *class_data)
+int sr_register_class(struct smartreflex_class_data *class_data)
 {
 	struct smartreflex *sr;
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 3341584..0573995 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -199,7 +199,7 @@ struct omap_sr_dev_attr {
 #define SR_CLASS3	0x3
 
 /**
- * struct omap_sr_class_data - Smartreflex class driver info
+ * struct smartreflex_class_data - Smartreflex class driver info
  *
  * @enable:		API to enable a particular class smaartreflex.
  * @disable:		API to disable a particular class smartreflex.
@@ -211,7 +211,7 @@ struct omap_sr_dev_attr {
  *			Can be used by the SR driver to take any class
  *			based decisions.
  */
-struct omap_sr_class_data {
+struct smartreflex_class_data {
 	int (*enable)(struct smartreflex *sr);
 	int (*disable)(struct smartreflex *sr, int is_volt_reset);
 	int (*configure)(struct smartreflex *sr);
@@ -282,7 +282,7 @@ int sr_configure_errgen(struct smartreflex *sr);
 int sr_configure_minmax(struct smartreflex *sr);
 
 /* API to register the smartreflex class driver with the smartreflex driver */
-int sr_register_class(struct omap_sr_class_data *class_data);
+int sr_register_class(struct smartreflex_class_data *class_data);
 #else
 static inline void omap_sr_enable(struct smartreflex *sr) {}
 static inline void omap_sr_disable(struct smartreflex *sr) {}
-- 
1.7.5.4

