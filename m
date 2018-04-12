From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 04/14] ARM: OMAP2: Add functions to save and restore omap hwmod context en-masse.
Date: Thu, 12 Apr 2018 09:23:49 +0530
Message-ID: <1523505239-16229-5-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <Russ.Dill@ti.com>

This is used to support suspend modes like RTC-only and hibernate where
the state of these registers is lost.

After the PRCM loses context in the case of an RTC+DDR cycle omap_hwmod
attempts to return all hwmods to their previous state, however certain
hwmods cannot just be disabled when in their default state, which is why
they need the special handling present in that patch when no driver is
present.

In RTC+DDR mode, even if all drivers are present, the modules are all
returned to their previous state before any driver resume happens so we
will still face the issue described above. This can be prevented by
calling _reidle on all hwmods that need it for any module that is being
disabled to return to it's previous state.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 67 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |  4 +++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 90ad8e7..f6782b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4096,3 +4096,70 @@ const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh)
 
 	return oh->main_clk;
 }
+
+/**
+ * omap_hwmod_save_context - Saves the HW reset line state of submodules
+ * @oh: struct omap_hwmod *
+ * @unused: (unused, caller should pass NULL)
+ *
+ * Saves the HW reset line state of all the submodules in the hwmod
+ */
+static int omap_hwmod_save_context(struct omap_hwmod *oh, void *unused)
+{
+	int i;
+
+	for (i = 0; i < oh->rst_lines_cnt; i++)
+		oh->rst_lines[i].context =
+				_read_hardreset(oh, oh->rst_lines[i].name);
+	return 0;
+}
+
+/**
+ * omap_hwmod_restore_context - Restores the HW reset line state of submodules
+ * @oh: struct omap_hwmod *
+ * @unused: (unused, caller should pass NULL)
+ *
+ * Restores the HW reset line state of all the submodules in the hwmod
+ */
+static int omap_hwmod_restore_context(struct omap_hwmod *oh, void *unused)
+{
+	int i;
+
+	for (i = 0; i < oh->rst_lines_cnt; i++)
+		if (oh->rst_lines[i].context)
+			_assert_hardreset(oh, oh->rst_lines[i].name);
+		else
+			_deassert_hardreset(oh, oh->rst_lines[i].name);
+
+	if (oh->_state == _HWMOD_STATE_ENABLED) {
+		if (soc_ops.enable_module)
+			soc_ops.enable_module(oh);
+	} else {
+		if (oh->flags & HWMOD_NEEDS_REIDLE)
+			_reidle(oh);
+		else if (soc_ops.disable_module)
+			soc_ops.disable_module(oh);
+	}
+
+	return 0;
+}
+
+/**
+ * omap_hwmods_save_context - Saves the HW reset line state for all hwmods
+ *
+ * Saves the HW reset line state of all the registered hwmods
+ */
+void omap_hwmods_save_context(void)
+{
+	omap_hwmod_for_each(omap_hwmod_save_context, NULL);
+}
+
+/**
+ * omap_hwmods_restore_context - Restores the HW reset line state for all hwmods
+ *
+ * Restores the HW reset line state of all the registered hwmods
+ */
+void omap_hwmods_restore_context(void)
+{
+	omap_hwmod_for_each(omap_hwmod_restore_context, NULL);
+}
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index f35638b..b5e050e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -168,6 +168,7 @@ struct omap_hwmod_rst_info {
 	const char	*name;
 	u8		rst_shift;
 	u8		st_shift;
+	u8		context;
 };
 
 /**
@@ -678,6 +679,9 @@ int omap_hwmod_for_each_by_class(const char *classname,
 
 const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
 
+void omap_hwmods_save_context(void);
+void omap_hwmods_restore_context(void);
+
 /*
  *
  */
-- 
1.9.1
