From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/12] ARM: OMAP2+: powerdomain: program memory bank
 next-power-state upon init
Date: Sun, 09 Dec 2012 10:53:37 -0700
Message-ID: <20121209175335.6933.37266.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39995 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934314Ab2LIRyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 12:54:47 -0500
In-Reply-To: <20121209174545.6933.59371.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

During powerdomain init, we were previously programming a reasonable
default for the powerdomain and logic next-power-state fields, but not
touching the memory bank next-power-state fields.  To ensure that the
previous OS or bootloader didn't leave the system in a bad state, program
the memory bank next-power-state bitfields to reasonable defaults.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index fdeabbf..a70e3f6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -563,21 +563,28 @@ int pwrdm_register_pwrdms(struct powerdomain **ps)
  *
  * Do whatever is necessary to initialize registered powerdomains and
  * powerdomain code.  Currently, this programs the next power state
- * for each powerdomain to ON.  This prevents powerdomains from
- * unexpectedly losing context or entering high wakeup latency modes
- * with non-power-management-enabled kernels.  Must be called after
- * pwrdm_register_pwrdms().  Returns -EACCES if called before
- * pwrdm_register_pwrdms(), or 0 upon success.
+ * for each powerdomain to ON, and programs the memory bank power
+ * states to follow the powerdomain power states.  This prevents
+ * powerdomains from unexpectedly losing context or entering high
+ * wakeup latency modes with non-power-management-enabled kernels.
+ * Must be called after pwrdm_register_pwrdms().  Returns -EACCES if
+ * called before pwrdm_register_pwrdms(), or 0 upon success.
  */
 int pwrdm_complete_init(void)
 {
 	struct powerdomain *temp_p;
+	int i;
 
 	if (list_empty(&pwrdm_list))
 		return -EACCES;
 
-	list_for_each_entry(temp_p, &pwrdm_list, node)
-		pwrdm_set_next_fpwrst(temp_p, PWRDM_FUNC_PWRST_ON);
+	list_for_each_entry(temp_p, &pwrdm_list, node) {
+		for (i = 0; i < temp_p->banks; i++) {
+			pwrdm_set_mem_onst(temp_p, i, PWRDM_POWER_ON);
+			pwrdm_set_mem_retst(temp_p, i, PWRDM_POWER_RET);
+		}
+		WARN_ON(pwrdm_set_next_fpwrst(temp_p, PWRDM_FUNC_PWRST_ON));
+	}
 
 	return 0;
 }


