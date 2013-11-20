From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: check for module address space during
 init
Date: Wed, 20 Nov 2013 22:14:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1311202211310.30143@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Suman Anna <s-anna@ti.com>, rnayak@ti.com, tony@atomide.com, nm@ti.com, santosh.shilimkar@ti.com, stefan.roese@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Commit 6423d6df1440a8acfc2f375d7cbc4cd66c2e6910 upstream.  Applies on
v3.12.  This fixes boot-time crashes on AM335x-based boards:

http://marc.info/?l=linux-omap&m=138495738502704&w=2

...

The hwmod init sequence involves initializing and idling all the
hwmods during bootup. If a module class has sysconfig, the init
sequence utilizes the module register base for performing any
sysc configuration.

The module address space is being removed from hwmod database and
retrieved from the <reg> property of the corresponding DT node.
If a hwmod does not have its corresponding DT node defined and the
memory address space is not defined in the corresponding
omap_hwmod_ocp_if, then the module register target address space
would be NULL and any sysc programming would result in a NULL
pointer dereference and a kernel boot hang.

Handle this scenario by checking for a valid module address space
during the _init of each hwmod, and leaving it in the registered
state if no module register address base is defined in either of
the hwmod data or the DT data.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
[paul@pwsan.com: use -ENXIO rather than -ENOMEM to indicate a missing address
 space error; fixed checkpatch.pl problem]
Cc: Stefan Roese <stefan.roese@gmail.com>
Cc: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: added -stable notes]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d9ee0ff094d4..3d5db8c83b3c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2361,21 +2361,23 @@ static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
  * Cache the virtual address used by the MPU to access this IP block's
  * registers.  This address is needed early so the OCP registers that
  * are part of the device's address space can be ioremapped properly.
- * No return value.
+ *
+ * Returns 0 on success, -EINVAL if an invalid hwmod is passed, and
+ * -ENXIO on absent or invalid register target address space.
  */
-static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
+static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 {
 	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start = NULL;
 	struct device_node *np;
 
 	if (!oh)
-		return;
+		return -EINVAL;
 
 	_save_mpu_port_index(oh);
 
 	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
-		return;
+		return -ENXIO;
 
 	mem = _find_mpu_rt_addr_space(oh);
 	if (!mem) {
@@ -2384,7 +2386,7 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 
 		/* Extract the IO space from device tree blob */
 		if (!of_have_populated_dt())
-			return;
+			return -ENXIO;
 
 		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
 		if (np)
@@ -2395,13 +2397,14 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 
 	if (!va_start) {
 		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
-		return;
+		return -ENXIO;
 	}
 
 	pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
 		 oh->name, va_start);
 
 	oh->_mpu_rt_va = va_start;
+	return 0;
 }
 
 /**
@@ -2414,8 +2417,8 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
  * registered at this point.  This is the first of two phases for
  * hwmod initialization.  Code called here does not touch any hardware
  * registers, it simply prepares internal data structures.  Returns 0
- * upon success or if the hwmod isn't registered, or -EINVAL upon
- * failure.
+ * upon success or if the hwmod isn't registered or if the hwmod's
+ * address space is not defined, or -EINVAL upon failure.
  */
 static int __init _init(struct omap_hwmod *oh, void *data)
 {
@@ -2424,8 +2427,14 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
-	if (oh->class->sysc)
-		_init_mpu_rt_base(oh, NULL);
+	if (oh->class->sysc) {
+		r = _init_mpu_rt_base(oh, NULL);
+		if (r < 0) {
+			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
+			     oh->name);
+			return 0;
+		}
+	}
 
 	r = _init_clocks(oh, NULL);
 	if (r < 0) {
-- 
1.8.4.3
