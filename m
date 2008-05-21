From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/6] clockdomain: add clkdm_get_pwrdm()
Date: Tue, 20 May 2008 18:41:35 -0600
Message-ID: <20080521004133.6131.52400.stgit@localhost.localdomain>
References: <20080521003910.6131.63409.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45902 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765641AbYEUAqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 20:46:04 -0400
In-Reply-To: <20080521003910.6131.63409.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add clkdm_get_pwrdm() to the clockdomain code.  It will return a
pointer to the powerdomain struct that the clockdomain is contained
within.  Used by the PM code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clockdomain.c       |   16 ++++++++++++++++
 include/asm-arm/arch-omap/clockdomain.h |    5 +++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ca944ec..6e5f892 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -315,6 +315,22 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
 }
 
 
+/**
+ * clkdm_get_pwrdm - return a ptr to the pwrdm that this clkdm resides in
+ * @clkdm: struct clockdomain *
+ *
+ * Return a pointer to the struct powerdomain that the specified clockdomain
+ * 'clkdm' exists in, or returns NULL if clkdm argument is NULL.
+ */
+struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm)
+{
+	if (!clkdm)
+		return NULL;
+
+	return clkdm->pwrdm;
+}
+
+
 /* Hardware clockdomain control */
 
 /**
diff --git a/include/asm-arm/arch-omap/clockdomain.h b/include/asm-arm/arch-omap/clockdomain.h
index e4280bd..d2a4551 100644
--- a/include/asm-arm/arch-omap/clockdomain.h
+++ b/include/asm-arm/arch-omap/clockdomain.h
@@ -91,6 +91,9 @@ int clkdm_register(struct clockdomain *clkdm);
 int clkdm_unregister(struct clockdomain *clkdm);
 struct clockdomain *clkdm_lookup(const char *name);
 
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
+struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
+
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
 
@@ -100,6 +103,4 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 
-int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
-
 #endif


