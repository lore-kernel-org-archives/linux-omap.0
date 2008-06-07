From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/16] ARM: OMAP2: Add clkdm_get_pwrdm()
Date: Fri,  6 Jun 2008 19:12:33 -0700
Message-ID: <1212804762-18413-6-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
 <1212804762-18413-4-git-send-email-tony@atomide.com>
 <1212804762-18413-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56695 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbYFGCMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:12:54 -0400
In-Reply-To: <1212804762-18413-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Add clkdm_get_pwrdm() to the clockdomain code.  It will return a
pointer to the powerdomain struct that the clockdomain is contained
within.  Used by the PM code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

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
index d2a4551..e71fee4 100644
--- a/include/asm-arm/arch-omap/clockdomain.h
+++ b/include/asm-arm/arch-omap/clockdomain.h
@@ -94,6 +94,9 @@ struct clockdomain *clkdm_lookup(const char *name);
 int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
 struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
 
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
+struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
+
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
 
