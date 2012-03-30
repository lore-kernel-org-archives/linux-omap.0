From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V4 3/4] ARM: OMAP2+: powerdomain: Add offset & mask fields to
 struct powerdomain
Date: Fri, 30 Mar 2012 21:33:54 +0530
Message-ID: <1333123435-27186-4-git-send-email-hvaibhav@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In case of AM33xx family of devices, there is no consistency between
PWRSTCTRL & PWRSTST register offsers in PRM space, for example -

PRM_XXX           PWRSTCTRL     PWRSTST
=======================================
PRM_PER_MOD:      0x0C,         0x08
PRM_WKUP_MOD:     0x04,         0x08
PRM_MPU_MOD:      0x00,         0x04
PRM_DEVICE_MOD:   NA,           NA

And also, there is no consistency between bit-offsets inside
PWRSTCTRL & PWRSTST register, for example -

PRM_XXX           LOGICRET  MEMON  MEMRET
=======================================
GFX_PWRCTRL:      2,        17,    6
PER_PWRCTRL:      3,        25,    29
MPU_PWRCTRL:      2,        18,    22
WKUP_PWRCTRL:     3,        NA,    NA

This means, we need to maintain and pass on all this information
in powerdomain handle; so adding fields for,
   - PWRSTCTRL/ST register offset
   - Logic retention state mask
   - mem_on/ret/pwrst/retst mask

Currently, this fields is only applicable and used for AM33XX devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..8fc50b2 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -92,6 +92,15 @@ struct powerdomain;
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
+ * @pwrstctrl_offs: (AM33XX only) XXX_PWRSTCTRL reg offset from prcm_offs
+ * @pwrstst_offs: (AM33XX only) XXX_PWRSTST reg offset from prcm_offs
+ * @logicretstate_mask: (AM33XX only) mask for logic retention bitfield
+ *	in @pwrstctrl_offs
+ * @mem_on_mask: (AM33XX only) mask for mem on bitfield in @pwrstctrl_offs
+ * @mem_ret_mask: (AM33XX only) mask for mem retention bitfield in @pwrstctrl_offs
+ * @mem_pwrst_mask: (AM33XX only) mask for mem state bitfield in @pwrstst_offs
+ * @mem_retst_mask: (AM33XX only) mask for mem retention state bitfield
+ *	in @pwrstctrl_offs
  * @state:
  * @state_counter:
  * @timer:
@@ -121,6 +130,14 @@ struct powerdomain {
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];

+	const u8 pwrstctrl_offs;
+	const u8 pwrstst_offs;
+	const u32 logicretstate_mask;
+	const u32 mem_on_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_ret_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_pwrst_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_retst_mask[PWRDM_MAX_MEM_BANKS];
+
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
--
1.7.0.4
