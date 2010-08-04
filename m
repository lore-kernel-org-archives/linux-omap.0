From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/3] OMAP: hwmod: Add hardreset management support
Date: Thu,  5 Aug 2010 00:12:47 +0200
Message-ID: <1280959968-23933-3-git-send-email-b-cousson@ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46321 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576Ab0HDWM7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 18:12:59 -0400
In-Reply-To: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

Most processor IPs does have a hardreset signal controlled by the PRM.
This is different of the softreset used for local IP reset from the
SYSCONFIG register.
The granularity can be much finer than orginal HWMOD, for ex, the IVA
hwmod contains 3 reset lines, the IPU 3 as well, the DSP 2...
Since this granularity is needed by the driver, we have to ensure
than one hwmod exist for each hardreset line.
We do expose as well an hardreset API at hwmod in order to assert / deassert
all the reset individual lines that belong to an hwmod.

- Store reset lines as hwmod resources that a driver can query by name like
  an irq or sdma line.

- Add two APIs for asserting / deasserting reset lines in hwmods
  processor that require manual reset control.
- Add one API to get the current reset state.
- If an hwmod contains only one line, an automatic assertion / de-assertion
  is done.
  -> de-assert the hardreset line only during enable from disable transition
  -> assert the hardreset line only during shutdown

Note: The hwmods with hardreset line and HWMOD_INIT_NO_RESET flag must be
kept in INITIALIZED state.
They can be properly enabled only if the hardreset line is de-asserted
before.

For information here is the list of IPs with HW reset control
on an OMAP4430 device:

RM_DSP_RSTCTRL
  1,1,'RST2','RW','1','DSP - MMU, cache and slave interface reset control'
  0,0,'RST1','RW','1','DSP - DSP reset control'

RM_IVA_RSTCTRL
  2,2,'RST3','RW','1','IVA logic and SL2 reset control'
  1,1,'RST2','RW','1','IVA Sequencer2 reset control'
  0,0,'RST1','RW','1','IVA sequencer1 reset control'

RM_IPU_RSTCTRL
  2,2,'RST3','RW','1','IPU MMU and CACHE interface reset control.'
  1,1,'RST2','RW','1','IPU Cortex M3 CPU2  reset control.'
  0,0,'RST1','RW','1','IPU Cortex M3 CPU1  reset control.'

PRM_RSTCTRL
  1,1,'RST_GLOBAL_COLD_SW','RW','0','Global COLD software reset control.'
  0,0,'RST_GLOBAL_WARM_SW','RW','0','Global WARM software reset control.'

RM_CPU0_CPU0_RSTCTRL
RM_CPU1_CPU1_RSTCTRL
  0,0,'RST','RW','0','Cortex A9 CPU0&1 warm local reset control'

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  180 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   21 +++
 2 files changed, 201 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 100115f..53b08e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -50,6 +50,7 @@
 #include <plat/powerdomain.h>
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/prcm.h>
 
 #include "cm.h"
 
@@ -909,6 +910,15 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
+	/*
+	 * If an IP contains only one HW reset line, then de-assert it in order
+	 * to allow to enable the clocks. Otherwise the PRCM will return
+	 * Intransition status, and the init will failed.
+	 */
+	if ((oh->_state == _HWMOD_STATE_INITIALIZED ||
+	     oh->_state == _HWMOD_STATE_DISABLED) && oh->rst_lines_cnt == 1)
+		omap_hwmod_hardreset_deassert(oh, oh->rst_lines[0].name);
+
 	/* XXX mux balls */
 
 	_add_initiator_dep(oh, mpu_oh);
@@ -982,6 +992,12 @@ static int _shutdown(struct omap_hwmod *oh)
 
 	if (oh->class->sysc)
 		_sysc_shutdown(oh);
+	/*
+	 * If an IP contains only one HW reset line, then assert it
+	 * before disabling the clocks and shutting down the IP.
+	 */
+	if (oh->rst_lines_cnt == 1)
+		omap_hwmod_hardreset_assert(oh, oh->rst_lines[0].name);
 
 	/* clocks and deps are already disabled in idle */
 	if (oh->_state == _HWMOD_STATE_ENABLED) {
@@ -1040,6 +1056,16 @@ static int _setup(struct omap_hwmod *oh, void *data)
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
+	/*
+	 * In the case of hwmod with hardreset that should not be
+	 * de-assert at boot time, we have to keep the module
+	 * initialized, because we cannot enable it properly with the
+	 * reset asserted. Exit without warning because that behavior is
+	 * expected.
+	 */
+	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt == 1)
+		return 0;
+
 	r = _omap_hwmod_enable(oh);
 	if (r) {
 		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
@@ -1450,6 +1476,160 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 	return r;
 }
 
+/* offset between the reset control and the reset status registers */
+#define RST_CTRL_ST_OFFSET 4
+
+/**
+ * _lookup_reset - reset the hwmod
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line in the context of this hwmod
+ *
+ * Return the bit position of the reset line that match the
+ * input name. Return -ENOENT if not found.
+ */
+u8 _lookup_reset(struct omap_hwmod *oh, const char *name)
+{
+	int i;
+
+	for (i = 0; i < oh->rst_lines_cnt; i++) {
+		const char *rst_line = oh->rst_lines[i].name;
+		if (!strcmp(rst_line, name)) {
+			u8 shift = oh->rst_lines[i].rst_shift;
+			pr_debug("omap_hwmod: %s: _lookup_reset: %s: %d\n",
+				 oh->name, rst_line, shift);
+
+			return shift;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * omap_hwmod_reset_assert - assert the HW reset line of submodules
+ * contained in the hwmod module.
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to lookup and assert
+ *
+ * Some IP like dsp, ipu or iva contain processor that require
+ * an HW reset line to be assert / deassert in order to enable fully
+ * the IP.
+ */
+int omap_hwmod_hardreset_assert(struct omap_hwmod *oh, const char *name)
+{
+	u8 shift;
+	u32 mask;
+
+	if (!oh)
+		return -EINVAL;
+
+	/* XXX For the moment only OMAP4 is supported */
+	if (!cpu_is_omap44xx()) {
+		pr_warning("%s only supported on OMAP4\n", __func__);
+		return -EINVAL;
+	}
+
+	shift = _lookup_reset(oh, name);
+	if (IS_ERR_VALUE(shift))
+		return shift;
+
+	mask = 1 << shift;
+	omap4_prm_rmw_reg_bits(mask, mask, oh->prcm.omap4.rstctrl_reg);
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_hardreset_deassert - deassert the HW reset line of submodules
+ * contained in the hwmod module.
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to look up and deassert
+ *
+ * Some IP like dsp, ipu or iva contain processor that require
+ * an HW reset line to be assert / deassert in order to enable fully
+ * the IP.
+ */
+int omap_hwmod_hardreset_deassert(struct omap_hwmod *oh, const char *name)
+{
+	u8 shift;
+	u32 mask;
+	int c = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	/* XXX For the moment only OMAP4 is supported */
+	if (!cpu_is_omap44xx()) {
+		pr_warning("%s only supported on OMAP4\n", __func__);
+		return -EINVAL;
+	}
+
+	shift = _lookup_reset(oh, name);
+	if (IS_ERR_VALUE(shift))
+		return shift;
+
+	mask = 1 << shift;
+
+	/* Check the current status to avoid de-asserting the line twice */
+	if (omap4_prm_read_bits_shift(oh->prcm.omap4.rstctrl_reg, mask) == 0) {
+		pr_warning("omap_hwmod: %s: reset already de-asserted\n",
+			   oh->name);
+		return 0;
+	}
+
+	/* Clear the reset status by writing 1 to the status bit */
+	omap4_prm_rmw_reg_bits(0xffffffff, mask, oh->prcm.omap4.rstctrl_reg
+						 + RST_CTRL_ST_OFFSET);
+	/* de-assert the reset control line */
+	omap4_prm_rmw_reg_bits(mask, 0, oh->prcm.omap4.rstctrl_reg);
+	/* wait the status to be set */
+	omap_test_timeout(omap4_prm_read_bits_shift(oh->prcm.omap4.rstctrl_reg
+						    + RST_CTRL_ST_OFFSET, mask),
+			  MAX_MODULE_RESET_WAIT, c);
+
+	if (c == MAX_MODULE_RESET_WAIT) {
+		pr_warning("omap_hwmod: %s: failed to reset in %d usec\n",
+			   oh->name, MAX_MODULE_RESET_WAIT);
+		return -EBUSY;
+	} else {
+		pr_debug("omap_hwmod: %s: reset %s in %d usec\n",
+			 oh->name, name, c);
+	}
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_hw_reset_state - read the HW reset line state of submodules
+ * contained in the hwmod module
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to look up and read
+ *
+ * Return the state of the reset line.
+ */
+int omap_hwmod_hardreset_state(struct omap_hwmod *oh, const char *name)
+{
+	u8 shift;
+	u32 mask;
+
+	if (!oh)
+		return -EINVAL;
+
+	/* XXX For the moment only OMAP4 is supported */
+	if (!cpu_is_omap44xx()) {
+		pr_warning("%s only supported on OMAP4\n", __func__);
+		return -EINVAL;
+	}
+
+	shift = _lookup_reset(oh, name);
+	if (IS_ERR_VALUE(shift))
+		return shift;
+
+	mask = 1 << shift;
+
+	return omap4_prm_read_bits_shift(oh->prcm.omap4.rstctrl_reg, mask);
+}
+
 /**
  * omap_hwmod_count_resources - count number of struct resources needed by hwmod
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 5506d80..5941183 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -108,6 +108,19 @@ struct omap_hwmod_dma_info {
 };
 
 /**
+ * struct omap_hwmod_rst_info - IPs reset lines use by hwmod
+ * @name: name of the reset line (module local name)
+ * @rst_shift: Offset of the reset bit
+ *
+ * @name should be something short, e.g., "cpu0" or "rst". It is defined
+ * locally to the hwmod.
+ */
+struct omap_hwmod_rst_info {
+	const char	*name;
+	u8		rst_shift;
+};
+
+/**
  * struct omap_hwmod_opt_clk - optional clocks used by this hwmod
  * @role: "sys", "32k", "tv", etc -- for use in clk_get()
  * @clk: opt clock: OMAP clock name
@@ -327,10 +340,12 @@ struct omap_hwmod_omap2_prcm {
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
  * @clkctrl_reg: PRCM address of the clock control register
+ * @rstctrl_reg: adress of the XXX_RSTCTRL register located in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  */
 struct omap_hwmod_omap4_prcm {
 	void __iomem	*clkctrl_reg;
+	void __iomem	*rstctrl_reg;
 	u8		submodule_wkdep_bit;
 };
 
@@ -449,6 +464,7 @@ struct omap_hwmod {
 	struct omap_device		*od;
 	struct omap_hwmod_irq_info	*mpu_irqs;
 	struct omap_hwmod_dma_info	*sdma_reqs;
+	struct omap_hwmod_rst_info	*rst_lines;
 	union {
 		struct omap_hwmod_omap2_prcm omap2;
 		struct omap_hwmod_omap4_prcm omap4;
@@ -469,6 +485,7 @@ struct omap_hwmod {
 	u8				response_lat;
 	u8				mpu_irqs_cnt;
 	u8				sdma_reqs_cnt;
+	u8				rst_lines_cnt;
 	u8				opt_clks_cnt;
 	u8				masters_cnt;
 	u8				slaves_cnt;
@@ -495,6 +512,10 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh);
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
+int omap_hwmod_hardreset_assert(struct omap_hwmod *oh, const char *name);
+int omap_hwmod_hardreset_deassert(struct omap_hwmod *oh, const char *name);
+int omap_hwmod_hardreset_state(struct omap_hwmod *oh, const char *name);
+
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
 
 int omap_hwmod_reset(struct omap_hwmod *oh);
-- 
1.6.1.3

