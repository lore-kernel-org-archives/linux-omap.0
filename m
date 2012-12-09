From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/12] ARM: OMAP2+: powerdomain: add ability to test for
 supported power states
Date: Sun, 09 Dec 2012 10:53:32 -0700
Message-ID: <20121209175326.6933.2601.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39993 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934326Ab2LIRyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 12:54:46 -0500
In-Reply-To: <20121209174545.6933.59371.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add pwrdm_supports_fpwrst(), intended for use by the PM code to avoid
attempting to program a powerdomain to a power state that it doesn't
support.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |    1 +
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 86fe84c..6ba79df 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1495,3 +1495,36 @@ int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm)
 	return ret;
 }
 
+/**
+ * pwrdm_supports_fpwrst - does the powerdomain @pwrdm support the @fpwrst power
+ * state?
+ * @pwrdm: struct powerdomain * pointing to a powerdomain to test
+ * @fpwrst: functional power state
+ *
+ * Returns true if the powerdomain pointed to by @pwrdm can enter the
+ * functional power state @fpwrst, or false if not.
+ */
+bool pwrdm_supports_fpwrst(struct powerdomain *pwrdm, u8 fpwrst)
+{
+	u8 pwrst, logic;
+	int ret;
+
+	if (!pwrdm || IS_ERR(pwrdm))
+		return false;
+
+	ret = _pwrdm_fpwrst_to_pwrst(pwrdm, fpwrst, &pwrst, &logic);
+	if (ret)
+		return false;
+
+	pr_debug("%s: pwrdm %s: set fpwrst %0x\n", __func__, pwrdm->name,
+		 fpwrst);
+
+	if (pwrdm->pwrsts_logic_ret && pwrst == PWRDM_POWER_RET &&
+	    !(pwrdm->pwrsts_logic_ret & (1 << logic)))
+		return false;
+
+	if (!(pwrdm->pwrsts & (1 << pwrst)))
+		return false;
+
+	return true;
+}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index aa1c9ae..52be8cd 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -260,6 +260,7 @@ extern int pwrdm_set_fpwrst(struct powerdomain *pwrdm,
 			    enum pwrdm_func_state fpwrst);
 extern int pwrdm_read_fpwrst(struct powerdomain *pwrdm);
 extern int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm);
+extern bool pwrdm_supports_fpwrst(struct powerdomain *pwrdm, u8 fpwrst);
 
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);


