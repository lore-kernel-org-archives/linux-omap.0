From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/5] bus: ti-sysc: Add missing kerneldoc comments
Date: Tue, 25 Jun 2019 18:33:14 -0500
Message-ID: <20190625233315.22301-5-s-anna@ti.com>
References: <20190625233315.22301-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625233315.22301-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

A few fields in various structures is missing the corresponding
kerneldoc comments. Add them. Also, fixed the comment for sidlemodes.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/bus/ti-sysc.c                 | 7 +++++++
 include/linux/platform_data/ti-sysc.h | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 3030c9eadfb1..ccdd1f0871f9 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -54,15 +54,22 @@ static const char * const clock_names[SYSC_MAX_CLOCKS] = {
  * @module_size: size of the interconnect target module
  * @module_va: virtual address of the interconnect target module
  * @offsets: register offsets from module base
+ * @mdata: ti-sysc to hwmod translation data for a module
  * @clocks: clocks used by the interconnect target module
  * @clock_roles: clock role names for the found clocks
  * @nr_clocks: number of clocks used by the interconnect target module
+ * @rsts: resets used by the interconnect target module
  * @legacy_mode: configured for legacy mode if set
  * @cap: interconnect target module capabilities
  * @cfg: interconnect target module configuration
+ * @cookie: data used by legacy platform callbacks
  * @name: name if available
  * @revision: interconnect target module revision
+ * @enabled: sysc runtime enabled status
  * @needs_resume: runtime resume needed on resume from suspend
+ * @child_needs_resume: runtime resume needed for child on resume from suspend
+ * @disable_on_idle: status flag used for disabling modules with resets
+ * @idle_work: work structure used to perform delayed idle on a module
  * @clk_enable_quirk: module specific clock enable quirk
  * @clk_disable_quirk: module specific clock disable quirk
  * @reset_done_quirk: module specific reset done quirk
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 7d009dc08a54..1a0905435b32 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -72,7 +72,7 @@ struct sysc_regbits {
 
 /**
  * struct sysc_capabilities - capabilities for an interconnect target module
- *
+ * @type: sysc type identifier for the module
  * @sysc_mask: bitmask of supported SYSCONFIG register bits
  * @regbits: bitmask of SYSCONFIG register bits
  * @mod_quirks: bitmask of module specific quirks
@@ -87,8 +87,9 @@ struct sysc_capabilities {
 /**
  * struct sysc_config - configuration for an interconnect target module
  * @sysc_val: configured value for sysc register
+ * @syss_mask: configured mask value for SYSSTATUS register
  * @midlemodes: bitmask of supported master idle modes
- * @sidlemodes: bitmask of supported master idle modes
+ * @sidlemodes: bitmask of supported slave idle modes
  * @srst_udelay: optional delay needed after OCP soft reset
  * @quirks: bitmask of enabled quirks
  */
-- 
2.21.0
