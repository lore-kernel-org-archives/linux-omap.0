From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] OMAP3 pwrdm: add hardware save-and-restore (SAR) support
Date: Wed, 25 Jun 2008 18:09:37 -0600
Message-ID: <20080626000934.18779.8432.stgit@localhost.localdomain>
References: <20080626000415.18779.25924.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36914 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYFZAQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 20:16:42 -0400
In-Reply-To: <20080626000415.18779.25924.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, r-woodruff2@ti.com

OMAP3430ES2+ introduces a new feature: optional powerdomain context
hardware save-and-restore (SAR).  Currently, this feature only applies
to USBHOST and USBTLL module context when the USBHOST or CORE
powerdomains enter a low-power sleep state[1].  This feature avoids
re-enumeration of USB devices when the powerdomains return from idle,
which is potentially time-consuming.

This patch adds support for enabling and disabling hardware
save-and-restore to the powerdomain code.  Three new functions are
added, pwrdm_enable_hdwr_sar(), pwrdm_disable_hdwr_sar(), and
pwrdm_can_hdwr_sar().  A new struct powerdomain "flags" field is
added, with a PWRDM_HAS_HDWR_SAR flag to indicate powerdomains with
SAR support.

Thanks to Jouni H=C3=B6gander <jouni.hogander@nokia.com> for reviewing =
an
earlier version of these patches, and Richard Woodruff <r-woodruff2@ti.=
com>
for clarifying the purpose of these bits.


1.  For the USBHOST controller module, context loss occurs when the
    USBHOST powerdomain enters off-idle.  For USBTLL, context loss
    occurs either if CORE enters off-idle, or if the CORE logic is
    configured to turn off when CORE enters retention-idle (OSWR).
    34xx ES2 TRM 4.8.6.1.1, 4.8.6.1.2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/powerdomain.c       |   68 +++++++++++++++++++++++=
++++++++
 include/asm-arm/arch-omap/powerdomain.h |   11 +++++
 2 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
index 3a8dae0..7615f9d 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1003,6 +1003,74 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomai=
n *pwrdm)
 }
=20
 /**
+ * pwrdm_enable_hdwr_sar - enable automatic hardware SAR for a pwrdm
+ * @pwrdm: struct powerdomain *
+ *
+ * Enable automatic context save-and-restore upon power state change
+ * for some devices in a powerdomain.  Warning: this only affects a
+ * subset of devices in a powerdomain; check the TRM closely.  Returns
+ * -EINVAL if the powerdomain pointer is null or if the powerdomain
+ * does not support automatic save-and-restore, or returns 0 upon
+ * success.
+ */
+int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
+		return -EINVAL;
+
+	pr_debug("powerdomain: %s: setting SAVEANDRESTORE bit\n",
+		 pwrdm->name);
+
+	prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
+			     pwrdm->prcm_offs, PM_PWSTCTRL);
+
+	return 0;
+}
+
+/**
+ * pwrdm_disable_hdwr_sar - disable automatic hardware SAR for a pwrdm
+ * @pwrdm: struct powerdomain *
+ *
+ * Disable automatic context save-and-restore upon power state change
+ * for some devices in a powerdomain.  Warning: this only affects a
+ * subset of devices in a powerdomain; check the TRM closely.  Returns
+ * -EINVAL if the powerdomain pointer is null or if the powerdomain
+ * does not support automatic save-and-restore, or returns 0 upon
+ * success.
+ */
+int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
+		return -EINVAL;
+
+	pr_debug("powerdomain: %s: clearing SAVEANDRESTORE bit\n",
+		 pwrdm->name);
+
+	prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
+			     pwrdm->prcm_offs, PM_PWSTCTRL);
+
+	return 0;
+}
+
+/**
+ * pwrdm_has_hdwr_sar - test whether powerdomain supports hardware SAR
+ * @pwrdm: struct powerdomain *
+ *
+ * Returns 1 if powerdomain 'pwrdm' supports hardware save-and-restore
+ * for some devices, or 0 if it does not.
+ */
+bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
+{
+	return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
+}
+
+/**
  * pwrdm_wait_transition - wait for powerdomain power transition to fi=
nish
  * @pwrdm: struct powerdomain * to wait for
  *
diff --git a/include/asm-arm/arch-omap/powerdomain.h b/include/asm-arm/=
arch-omap/powerdomain.h
index 39b7df6..0e79459 100644
--- a/include/asm-arm/arch-omap/powerdomain.h
+++ b/include/asm-arm/arch-omap/powerdomain.h
@@ -38,6 +38,10 @@
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
=20
=20
+/* Powerdomain flags */
+#define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore suppo=
rt */
+
+
 /*
  * Number of memory banks that are power-controllable.	On OMAP3430, th=
e
  * maximum is 4.
@@ -96,6 +100,9 @@ struct powerdomain {
 	/* Possible logic power states when pwrdm in RETENTION */
 	const u8 pwrsts_logic_ret;
=20
+	/* Powerdomain flags */
+	const u8 flags;
+
 	/* Number of software-controllable memory banks in this powerdomain *=
/
 	const u8 banks;
=20
@@ -151,6 +158,10 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain=
 *pwrdm);
 int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
=20
+int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
+int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
+bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
+
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
=20
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
