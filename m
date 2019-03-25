From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: OMAP2+: Make interconnect target module allocation
 functions static
Date: Mon, 25 Mar 2019 11:38:14 -0700
Message-ID: <20190325183819.15400-3-tony@atomide.com>
References: <20190325183819.15400-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325183819.15400-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Only omap_hwmod_init_module() gets called, the rest of the interconnect
target module allocation functions can be static.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3241,9 +3241,10 @@ static int omap_hwmod_init_regbits(struct device *dev,
  * @sysc_offs: sysc register offset
  * @syss_offs: syss register offset
  */
-int omap_hwmod_init_reg_offs(struct device *dev,
-			     const struct ti_sysc_module_data *data,
-			     s32 *rev_offs, s32 *sysc_offs, s32 *syss_offs)
+static int omap_hwmod_init_reg_offs(struct device *dev,
+				    const struct ti_sysc_module_data *data,
+				    s32 *rev_offs, s32 *sysc_offs,
+				    s32 *syss_offs)
 {
 	*rev_offs = -ENODEV;
 	*sysc_offs = 0;
@@ -3267,9 +3268,9 @@ int omap_hwmod_init_reg_offs(struct device *dev,
  * @data: module data
  * @sysc_flags: module configuration
  */
-int omap_hwmod_init_sysc_flags(struct device *dev,
-			       const struct ti_sysc_module_data *data,
-			       u32 *sysc_flags)
+static int omap_hwmod_init_sysc_flags(struct device *dev,
+				      const struct ti_sysc_module_data *data,
+				      u32 *sysc_flags)
 {
 	*sysc_flags = 0;
 
@@ -3341,9 +3342,9 @@ int omap_hwmod_init_sysc_flags(struct device *dev,
  * @data: module data
  * @idlemodes: module supported idle modes
  */
-int omap_hwmod_init_idlemodes(struct device *dev,
-			      const struct ti_sysc_module_data *data,
-			      u32 *idlemodes)
+static int omap_hwmod_init_idlemodes(struct device *dev,
+				     const struct ti_sysc_module_data *data,
+				     u32 *idlemodes)
 {
 	*idlemodes = 0;
 
@@ -3434,11 +3435,12 @@ static int omap_hwmod_check_module(struct device *dev,
  *
  * Note that the allocations here cannot use devm as ti-sysc can rebind.
  */
-int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
-			       const struct ti_sysc_module_data *data,
-			       struct sysc_regbits *sysc_fields,
-			       s32 rev_offs, s32 sysc_offs, s32 syss_offs,
-			       u32 sysc_flags, u32 idlemodes)
+static int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
+				      const struct ti_sysc_module_data *data,
+				      struct sysc_regbits *sysc_fields,
+				      s32 rev_offs, s32 sysc_offs,
+				      s32 syss_offs, u32 sysc_flags,
+				      u32 idlemodes)
 {
 	struct omap_hwmod_class_sysconfig *sysc;
 	struct omap_hwmod_class *class;
-- 
2.21.0
