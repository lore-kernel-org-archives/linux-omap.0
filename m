From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 8/8] OMAP: mux: Add __func__ macro to pr_xxx macros
Date: Tue, 16 Nov 2010 21:55:37 +0100
Message-ID: <1289940937-31593-9-git-send-email-b-cousson@ti.com>
References: <1289940937-31593-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42961 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756979Ab0KPU4H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 15:56:07 -0500
In-Reply-To: <1289940937-31593-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Dan Murphy <dmurphy@ti.com>

Removed mux: and added the __func__ macro to make debugging
easier.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c     |   30 +++++++++++++++---------------
 arch/arm/mach-omap2/mux2420.c |    3 ++-
 arch/arm/mach-omap2/mux2430.c |    3 ++-
 arch/arm/mach-omap2/mux34xx.c |    2 +-
 arch/arm/mach-omap2/mux44xx.c |    6 +++---
 5 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 9221570..3d71d93 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -114,12 +114,12 @@ static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
 	}
 
 	if (found == 0) {
-		pr_err("mux: Could not set gpio%i\n", gpio);
+		pr_err("%s: Could not set gpio%i\n", __func__, gpio);
 		return -ENODEV;
 	}
 
 	if (found > 1) {
-		pr_info("mux: Multiple gpio paths (%d) for gpio%i\n",
+		pr_info("%s: Multiple gpio paths (%d) for gpio%i\n", __func__,
 			found, gpio);
 		return -EINVAL;
 	}
@@ -130,7 +130,7 @@ static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
 		mux_mode |= OMAP_MUX_MODE3;
 	else
 		mux_mode |= OMAP_MUX_MODE4;
-	pr_debug("mux: Setting signal %s.gpio%i 0x%04x -> 0x%04x\n",
+	pr_debug("%s: Setting signal %s.gpio%i 0x%04x -> 0x%04x\n", __func__,
 		 gpio_mux->muxnames[0], gpio, old_mode, mux_mode);
 	omap_mux_write(partition, mux_mode, gpio_mux->reg_offset);
 
@@ -190,8 +190,8 @@ static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
 				old_mode = omap_mux_read(partition,
 							 m->reg_offset);
 				mux_mode = val | i;
-				pr_debug("mux: Setting signal "
-					 "%s.%s 0x%04x -> 0x%04x\n",
+				pr_debug("%s: Setting signal "
+					 "%s.%s 0x%04x -> 0x%04x\n", __func__,
 					 m0_entry, muxname, old_mode, mux_mode);
 				omap_mux_write(partition, mux_mode,
 					       m->reg_offset);
@@ -204,12 +204,12 @@ static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
 		return 0;
 
 	if (found > 1) {
-		pr_err("mux: Multiple signal paths (%i) for %s\n",
+		pr_err("%s: Multiple signal paths (%i) for %s\n", __func__,
 		       found, muxname);
 		return -EINVAL;
 	}
 
-	pr_err("mux: Could not set signal %s\n", muxname);
+	pr_err("%s: Could not set signal %s\n", __func__, muxname);
 
 	return -ENODEV;
 }
@@ -561,7 +561,7 @@ static void __init omap_mux_package_fixup(struct omap_mux *p,
 			s++;
 		}
 		if (!found)
-			pr_err("mux: Unknown entry offset 0x%x\n",
+			pr_err("%s: Unknown entry offset 0x%x\n", __func__,
 			       p->reg_offset);
 		p++;
 	}
@@ -586,7 +586,7 @@ static void __init omap_mux_package_init_balls(struct omap_ball *b,
 			s++;
 		}
 		if (!found)
-			pr_err("mux: Unknown ball offset 0x%x\n",
+			pr_err("%s: Unknown ball offset 0x%x\n", __func__,
 			       b->reg_offset);
 		b++;
 	}
@@ -722,7 +722,7 @@ u16 omap_mux_get_gpio(int gpio)
 	}
 
 	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR)
-		pr_err("mux: Could not get gpio%i\n", gpio);
+		pr_err("%s: Could not get gpio%i\n", __func__, gpio);
 
 	return OMAP_MUX_TERMINATOR;
 }
@@ -742,7 +742,7 @@ void omap_mux_set_gpio(u16 val, int gpio)
 	}
 
 	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR)
-		pr_err("mux: Could not set gpio%i\n", gpio);
+		pr_err("%s: Could not set gpio%i\n", __func__, gpio);
 }
 
 static struct omap_mux * __init omap_mux_list_add(
@@ -800,7 +800,7 @@ static void __init omap_mux_init_list(struct omap_mux_partition *partition,
 
 		entry = omap_mux_list_add(partition, superset);
 		if (!entry) {
-			pr_err("mux: Could not add entry\n");
+			pr_err("%s: Could not add entry\n", __func__);
 			return;
 		}
 		superset++;
@@ -862,8 +862,8 @@ int __init omap_mux_init(const char *name, u32 flags,
 	partition->phys = mux_pbase;
 	partition->base = ioremap(mux_pbase, mux_size);
 	if (!partition->base) {
-		pr_err("mux: Could not ioremap mux partition at 0x%08x\n",
-			partition->phys);
+		pr_err("%s: Could not ioremap mux partition at 0x%08x\n",
+			__func__, partition->phys);
 		return -ENODEV;
 	}
 
@@ -871,7 +871,7 @@ int __init omap_mux_init(const char *name, u32 flags,
 
 	list_add_tail(&partition->node, &mux_partitions);
 	mux_partitions_cnt++;
-	pr_info("MUX: Add partition: #%d: %s, flags: %x\n",
+	pr_info("%s: Add partition: #%d: %s, flags: %x\n", __func__,
 		mux_partitions_cnt, partition->name, partition->flags);
 
 	omap_mux_init_package(superset, package_subset, package_balls);
diff --git a/arch/arm/mach-omap2/mux2420.c b/arch/arm/mach-omap2/mux2420.c
index 8231f0a..cf6de09 100644
--- a/arch/arm/mach-omap2/mux2420.c
+++ b/arch/arm/mach-omap2/mux2420.c
@@ -678,7 +678,8 @@ int __init omap2420_mux_init(struct omap_board_mux *board_subset, int flags)
 	case OMAP_PACKAGE_ZAF:
 		/* REVISIT: Please add data */
 	default:
-		pr_warning("mux: No ball data available for omap2420 package\n");
+		pr_warning("%s: No ball data available for omap2420 package\n",
+				__func__);
 	}
 
 	return omap_mux_init("core", OMAP_MUX_REG_8BIT | OMAP_MUX_GPIO_IN_MODE3,
diff --git a/arch/arm/mach-omap2/mux2430.c b/arch/arm/mach-omap2/mux2430.c
index cb6b404..4185f92 100644
--- a/arch/arm/mach-omap2/mux2430.c
+++ b/arch/arm/mach-omap2/mux2430.c
@@ -781,7 +781,8 @@ int __init omap2430_mux_init(struct omap_board_mux *board_subset, int flags)
 		package_balls = omap2430_pop_ball;
 		break;
 	default:
-		pr_warning("mux: No ball data available for omap2420 package\n");
+		pr_warning("%s: No ball data available for omap2420 package\n",
+				__func__);
 	}
 
 	return omap_mux_init("core", OMAP_MUX_REG_8BIT | OMAP_MUX_GPIO_IN_MODE3,
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 4113c93..440c98e 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -2049,7 +2049,7 @@ int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 		package_balls = omap36xx_cbp_ball;
 		break;
 	default:
-		printk(KERN_ERR "mux: Unknown omap package, mux disabled\n");
+		pr_err("%s Unknown omap package, mux disabled\n", __func__);
 		return -EINVAL;
 	}
 
diff --git a/arch/arm/mach-omap2/mux44xx.c b/arch/arm/mach-omap2/mux44xx.c
index 80335f3..980f11d 100644
--- a/arch/arm/mach-omap2/mux44xx.c
+++ b/arch/arm/mach-omap2/mux44xx.c
@@ -1590,17 +1590,17 @@ int __init omap4_mux_init(struct omap_board_mux *board_subset, int flags)
 
 	switch (flags & OMAP_PACKAGE_MASK) {
 	case OMAP_PACKAGE_CBL:
-		pr_debug("mux: OMAP4430 ES1.0 -> OMAP_PACKAGE_CBL\n");
+		pr_debug("%s: OMAP4430 ES1.0 -> OMAP_PACKAGE_CBL\n", __func__);
 		package_balls_core = omap4_core_cbl_ball;
 		core_muxmodes = omap4_core_muxmodes;
 		break;
 	case OMAP_PACKAGE_CBS:
-		pr_debug("mux: OMAP4430 ES2.X -> OMAP_PACKAGE_CBS\n");
+		pr_debug("%s: OMAP4430 ES2.X -> OMAP_PACKAGE_CBS\n", __func__);
 		package_balls_core = omap4_core_cbs_ball;
 		core_muxmodes = omap4_es2_core_muxmodes;
 		break;
 	default:
-		pr_err("mux: Unknown omap package, mux disabled\n");
+		pr_err("%s: Unknown omap package, mux disabled\n", __func__);
 		return -EINVAL;
 	}
 
-- 
1.7.0.4

