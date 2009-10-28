From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 2/3] omap: mux: add interface for encoded mux configration
Date: Wed, 28 Oct 2009 15:07:44 +0200
Message-ID: <6acc1e45771b767fb89947455837ffcdbde01b95.1256734115.git.mike@compulab.co.il>
References: <cover.1256734115.git.mike@compulab.co.il>
 <afa6b6ded8db35578a200c71938174a61eaa4ef9.1256734115.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:55717 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbZJ1NRf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 09:17:35 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N38PD-0007Rr-Hr
	for linux-omap@vger.kernel.org; Wed, 28 Oct 2009 08:17:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 705C39A0366
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 15:17:38 +0200 (IST)
In-Reply-To: <afa6b6ded8db35578a200c71938174a61eaa4ef9.1256734115.git.mike@compulab.co.il>
In-Reply-To: <cover.1256734115.git.mike@compulab.co.il>
References: <cover.1256734115.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/plat-omap/include/plat/mux.h |    3 +++
 arch/arm/plat-omap/mux.c              |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index f3c1d8a..edc3ff9 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -846,6 +846,7 @@ struct omap_mux_cfg {
 	struct pin_config	*pins;
 	unsigned long		size;
 	int			(*cfg_reg)(const struct pin_config *cfg);
+	int			(*cfg_pin)(unsigned long pin_config);
 };
 
 #ifdef	CONFIG_OMAP_MUX
@@ -854,11 +855,13 @@ extern int omap1_mux_init(void);
 extern int omap2_mux_init(void);
 extern int omap_mux_register(struct omap_mux_cfg *);
 extern int omap_cfg_reg(unsigned long reg_cfg);
+extern int omap_cfg_pin(unsigned long pin_config);
 #else
 /* boot loader does it all (no warnings from CONFIG_OMAP_MUX_WARNINGS) */
 static inline int omap1_mux_init(void) { return 0; }
 static inline int omap2_mux_init(void) { return 0; }
 static inline int omap_cfg_reg(unsigned long reg_cfg) { return 0; }
+static inline int omap_cfg_pin(unsigned long pin_config) { return 0; }
 #endif
 
 #endif
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 05aebca..94b37c1 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -77,7 +77,24 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 	return mux_cfg->cfg_reg(reg);
 }
 EXPORT_SYMBOL(omap_cfg_reg);
+
+int __init_or_module omap_cfg_pin(unsigned long pin_config)
+{
+	if (mux_cfg == NULL) {
+		printk(KERN_ERR "MUX: pin mux table not initialized\n");
+		return -ENODEV;
+	}
+
+	if (!mux_cfg->cfg_pin) {
+		printk(KERN_ERR "MUX: cfg_pin interface is not supported\n");
+		return -ENODEV;
+	}
+
+	return mux_cfg->cfg_pin(pin_config);
+}
+EXPORT_SYMBOL(omap_cfg_pin);
 #else
 #define omap_mux_init() do {} while(0)
 #define omap_cfg_reg(x)	do {} while(0)
+#define omap_cfg_pin(x)	do {} while(0)
 #endif	/* CONFIG_OMAP_MUX */
-- 
1.6.0.6

