From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/7] OMAP: mux: Replace printk with pr_xxx macros
Date: Thu, 11 Nov 2010 22:35:15 +0100
Message-ID: <1289511321-18532-2-git-send-email-b-cousson@ti.com>
References: <1289511321-18532-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52503 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab0KKVf5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Nov 2010 16:35:57 -0500
In-Reply-To: <1289511321-18532-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Replace all the printk(KERN_XXX... with pr_xxx macros.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/mux.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 074536a..979e9d1 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -102,13 +102,13 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	}
 
 	if (found == 0) {
-		printk(KERN_ERR "mux: Could not set gpio%i\n", gpio);
+		pr_err("mux: Could not set gpio%i\n", gpio);
 		return -ENODEV;
 	}
 
 	if (found > 1) {
-		printk(KERN_INFO "mux: Multiple gpio paths (%d) for gpio%i\n",
-				found, gpio);
+		pr_info("mux: Multiple gpio paths (%d) for gpio%i\n",
+			found, gpio);
 		return -EINVAL;
 	}
 
@@ -118,8 +118,8 @@ int __init omap_mux_init_gpio(int gpio, int val)
 		mux_mode |= OMAP_MUX_MODE3;
 	else
 		mux_mode |= OMAP_MUX_MODE4;
-	printk(KERN_DEBUG "mux: Setting signal %s.gpio%i 0x%04x -> 0x%04x\n",
-			gpio_mux->muxnames[0], gpio, old_mode, mux_mode);
+	pr_debug("mux: Setting signal %s.gpio%i 0x%04x -> 0x%04x\n",
+		 gpio_mux->muxnames[0], gpio, old_mode, mux_mode);
 	omap_mux_write(mux_mode, gpio_mux->reg_offset);
 
 	return 0;
@@ -161,9 +161,9 @@ int __init omap_mux_init_signal(const char *muxname, int val)
 
 				old_mode = omap_mux_read(m->reg_offset);
 				mux_mode = val | i;
-				printk(KERN_DEBUG "mux: Setting signal "
-					"%s.%s 0x%04x -> 0x%04x\n",
-					m0_entry, muxname, old_mode, mux_mode);
+				pr_debug("mux: Setting signal "
+					 "%s.%s 0x%04x -> 0x%04x\n",
+					 m0_entry, muxname, old_mode, mux_mode);
 				omap_mux_write(mux_mode, m->reg_offset);
 				found++;
 			}
@@ -174,12 +174,12 @@ int __init omap_mux_init_signal(const char *muxname, int val)
 		return 0;
 
 	if (found > 1) {
-		printk(KERN_ERR "mux: Multiple signal paths (%i) for %s\n",
-				found, muxname);
+		pr_err("mux: Multiple signal paths (%i) for %s\n",
+		       found, muxname);
 		return -EINVAL;
 	}
 
-	printk(KERN_ERR "mux: Could not set signal %s\n", muxname);
+	pr_err("mux: Could not set signal %s\n", muxname);
 
 	return -ENODEV;
 }
@@ -462,8 +462,8 @@ static void __init omap_mux_package_fixup(struct omap_mux *p,
 			s++;
 		}
 		if (!found)
-			printk(KERN_ERR "mux: Unknown entry offset 0x%x\n",
-					p->reg_offset);
+			pr_err("mux: Unknown entry offset 0x%x\n",
+			       p->reg_offset);
 		p++;
 	}
 }
@@ -487,8 +487,8 @@ static void __init omap_mux_package_init_balls(struct omap_ball *b,
 			s++;
 		}
 		if (!found)
-			printk(KERN_ERR "mux: Unknown ball offset 0x%x\n",
-					b->reg_offset);
+			pr_err("mux: Unknown ball offset 0x%x\n",
+			       b->reg_offset);
 		b++;
 	}
 }
@@ -615,7 +615,7 @@ u16 omap_mux_get_gpio(int gpio)
 
 	offset = omap_mux_get_by_gpio(gpio);
 	if (offset == OMAP_MUX_TERMINATOR) {
-		printk(KERN_ERR "mux: Could not get gpio%i\n", gpio);
+		pr_err("mux: Could not get gpio%i\n", gpio);
 		return offset;
 	}
 
@@ -629,7 +629,7 @@ void omap_mux_set_gpio(u16 val, int gpio)
 
 	offset = omap_mux_get_by_gpio(gpio);
 	if (offset == OMAP_MUX_TERMINATOR) {
-		printk(KERN_ERR "mux: Could not set gpio%i\n", gpio);
+		pr_err("mux: Could not set gpio%i\n", gpio);
 		return;
 	}
 
@@ -687,7 +687,7 @@ static void __init omap_mux_init_list(struct omap_mux *superset)
 
 		entry = omap_mux_list_add(superset);
 		if (!entry) {
-			printk(KERN_ERR "mux: Could not add entry\n");
+			pr_err("mux: Could not add entry\n");
 			return;
 		}
 		superset++;
@@ -738,7 +738,7 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	mux_phys = mux_pbase;
 	mux_base = ioremap(mux_pbase, mux_size);
 	if (!mux_base) {
-		printk(KERN_ERR "mux: Could not ioremap\n");
+		pr_err("mux: Could not ioremap\n");
 		return -ENODEV;
 	}
 
-- 
1.7.0.4

