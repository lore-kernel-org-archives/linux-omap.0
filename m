From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] ARM: OMAP2+: Prepare class allocation for dynamically
 allocated modules
Date: Mon, 25 Mar 2019 11:38:15 -0700
Message-ID: <20190325183819.15400-4-tony@atomide.com>
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

For dynamically allocated sysconfig data we only need to allocate a new
class for the cases where the class is shared. For dynamically allocated
struct omap_hwmod we will always allocate a new class.

Let's add detection for when we need to allocate a new class by comparing
the class name against the module name. If they match, there's no need
to allocate a new calls as we don't have case of mixed platform data and
dts data initialized modules for the same class.

Let's also move the init of class data inside the spinlock.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3443,7 +3443,7 @@ static int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
 				      u32 idlemodes)
 {
 	struct omap_hwmod_class_sysconfig *sysc;
-	struct omap_hwmod_class *class;
+	struct omap_hwmod_class *class = NULL;
 	void __iomem *regs = NULL;
 	unsigned long flags;
 
@@ -3467,19 +3467,21 @@ static int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
 	}
 
 	/*
-	 * We need new oh->class as the other devices in the same class
+	 * We may need a new oh->class as the other devices in the same class
 	 * may not yet have ioremapped their registers.
 	 */
-	class = kmemdup(oh->class, sizeof(*oh->class), GFP_KERNEL);
-	if (!class)
-		return -ENOMEM;
-
-	class->sysc = sysc;
+	if (oh->class->name && strcmp(oh->class->name, data->name)) {
+		class = kmemdup(oh->class, sizeof(*oh->class), GFP_KERNEL);
+		if (!class)
+			return -ENOMEM;
+	}
 
 	spin_lock_irqsave(&oh->_lock, flags);
 	if (regs)
 		oh->_mpu_rt_va = regs;
-	oh->class = class;
+	if (class)
+		oh->class = class;
+	oh->class->sysc = sysc;
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 	_setup(oh, NULL);
 	spin_unlock_irqrestore(&oh->_lock, flags);
-- 
2.21.0
