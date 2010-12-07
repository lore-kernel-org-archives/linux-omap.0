From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/14] OMAP: powerdomain: Infrastructure to put arch specific
	code
Date: Mon, 06 Dec 2010 18:25:04 -0700
Message-ID: <20101207012503.3708.30082.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41203 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab0LGBnq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:43:46 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Put infrastructure in place, so arch specific func pointers
can be hooked up to the platform-independent part of the
framework.
This is in preparation of splitting the powerdomain framework into
platform-independent part (for all omaps) and platform-specific
parts.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain.c             |   11 +++++-
 arch/arm/mach-omap2/powerdomains_data.c       |    2 +
 arch/arm/plat-omap/include/plat/powerdomain.h |   43 ++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6527ec3..3aa3eb3 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -80,6 +80,8 @@ static u16 pwrstst_reg_offs;
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
 
+static struct pwrdm_ops *arch_pwrdm;
+
 /* Private functions */
 
 static struct powerdomain *_pwrdm_lookup(const char *name)
@@ -211,6 +213,7 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 /**
  * pwrdm_init - set up the powerdomain layer
  * @pwrdm_list: array of struct powerdomain pointers to register
+ * @custom_funcs: func pointers for arch specfic implementations
  *
  * Loop through the array of powerdomains @pwrdm_list, registering all
  * that are available on the current CPU. If pwrdm_list is supplied
@@ -218,7 +221,7 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
  * registered.  No return value.  XXX pwrdm_list is not really a
  * "list"; it is an array.  Rename appropriately.
  */
-void pwrdm_init(struct powerdomain **pwrdm_list)
+void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops *custom_funcs)
 {
 	struct powerdomain **p = NULL;
 
@@ -234,6 +237,11 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
 		return;
 	}
 
+	if (!custom_funcs)
+		WARN(1, "powerdomain: No custom pwrdm functions registered\n");
+	else
+		arch_pwrdm = custom_funcs;
+
 	if (pwrdm_list) {
 		for (p = pwrdm_list; *p; p++)
 			_pwrdm_register(*p);
@@ -1074,4 +1082,3 @@ int pwrdm_post_transition(void)
 	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
 	return 0;
 }
-
diff --git a/arch/arm/mach-omap2/powerdomains_data.c b/arch/arm/mach-omap2/powerdomains_data.c
index 475763e..bf5b39b 100644
--- a/arch/arm/mach-omap2/powerdomains_data.c
+++ b/arch/arm/mach-omap2/powerdomains_data.c
@@ -149,5 +149,5 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 
 void pwrdm_fw_init(void)
 {
-	pwrdm_init(powerdomains_omap);
+	pwrdm_init(powerdomains_omap, NULL);
 }
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index e322b39..583758c 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -117,9 +117,50 @@ struct powerdomain {
 #endif
 };
 
+/**
+ * struct pwrdm_ops - Arch specfic function implementations
+ * @pwrdm_set_next_pwrst: Set the target power state for a pd
+ * @pwrdm_read_next_pwrst: Read the target power state set for a pd
+ * @pwrdm_read_pwrst: Read the current power state of a pd
+ * @pwrdm_read_prev_pwrst: Read the prev power state entered by the pd
+ * @pwrdm_set_logic_retst: Set the logic state in RET for a pd
+ * @pwrdm_set_mem_onst: Set the Memory state in ON for a pd
+ * @pwrdm_set_mem_retst: Set the Memory state in RET for a pd
+ * @pwrdm_read_logic_pwrst: Read the current logic state of a pd
+ * @pwrdm_read_prev_logic_pwrst: Read the previous logic state entered by a pd
+ * @pwrdm_read_logic_retst: Read the logic state in RET for a pd
+ * @pwrdm_read_mem_pwrst: Read the current memory state of a pd
+ * @pwrdm_read_prev_mem_pwrst: Read the previous memory state entered by a pd
+ * @pwrdm_read_mem_retst: Read the memory state in RET for a pd
+ * @pwrdm_clear_all_prev_pwrst: Clear all previous power states logged for a pd
+ * @pwrdm_enable_hdwr_sar: Enable Hardware Save-Restore feature for the pd
+ * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
+ * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
+ * @pwrdm_wait_transition: Wait for a pd state transition to complete
+ */
+struct pwrdm_ops {
+	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
+	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_prev_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_set_logic_retst)(struct powerdomain *pwrdm, u8 pwrst);
+	int	(*pwrdm_set_mem_onst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+	int	(*pwrdm_set_mem_retst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+	int	(*pwrdm_read_logic_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_prev_logic_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_logic_retst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
+	int	(*pwrdm_read_prev_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
+	int	(*pwrdm_read_mem_retst)(struct powerdomain *pwrdm, u8 bank);
+	int	(*pwrdm_clear_all_prev_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_enable_hdwr_sar)(struct powerdomain *pwrdm);
+	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
+	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
+	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
+};
 
 void pwrdm_fw_init(void);
-void pwrdm_init(struct powerdomain **pwrdm_list);
+void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops *custom_funcs);
 
 struct powerdomain *pwrdm_lookup(const char *name);
 


