From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 02/11] OMAP3+: PM: voltage: add required debugfs interfaces
Date: Wed, 18 May 2011 00:17:25 -0500
Message-ID: <1305695854-9638-3-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44873 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab1ERFRj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:39 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hcqv025729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:38 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hc71002793
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:38 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Kevin's patch:
OMAP3+: voltage: remove unneeded debugfs interface

removed ability to check the voltages in the domains.
This puts a crunch on validation we can do, hence we
re-introduce them back in

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   66 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h |    1 +
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 890ce39..ab5cbbd 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -282,6 +282,65 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 	}
 }
 
+/* Voltage debugfs support */
+static int vp_volt_debug_get(void *data, u64 *val)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+
+	if (!voltdm) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+	*val = omap_vp_get_curr_volt(voltdm);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NULL, "%llu\n");
+
+static int nom_volt_debug_get(void *data, u64 *val)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *) data;
+
+	if (!voltdm) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	*val = omap_voltage_get_nom_volt(voltdm);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NULL,
+								"%llu\n");
+
+static void __init voltdm_debugfs_init(struct dentry *voltage_dir,
+					struct voltagedomain *voltdm)
+{
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "vdd_%s", voltdm->name);
+	if (!name) {
+		pr_warning("%s:vdd_%s: no mem for debugfs\n", __func__,
+				voltdm->name);
+		return;
+	}
+
+	voltdm->debug_dir = debugfs_create_dir(name, voltage_dir);
+	kfree(name);
+	if (IS_ERR_OR_NULL(voltdm->debug_dir)) {
+		pr_warning("%s: Unable to create debugfs directory for"
+			" vdd_%s\n", __func__, voltdm->name);
+		voltdm->debug_dir = NULL;
+		return;
+	}
+
+	(void) debugfs_create_file("curr_vp_volt", S_IRUGO, voltdm->debug_dir,
+				(void *) voltdm, &vp_volt_debug_fops);
+	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO,
+				voltdm->debug_dir, (void *) voltdm,
+				&nom_volt_debug_fops);
+}
+
 /**
  * omap_voltage_late_init() - Init the various voltage parameters
  *
@@ -292,6 +351,7 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 int __init omap_voltage_late_init(void)
 {
 	struct voltagedomain *voltdm;
+	struct dentry *voltage_dir;
 
 	if (list_empty(&voltdm_list)) {
 		pr_err("%s: Voltage driver support not added\n",
@@ -299,6 +359,8 @@ int __init omap_voltage_late_init(void)
 		return -EINVAL;
 	}
 
+	voltage_dir = debugfs_create_dir("voltage", NULL);
+
 	list_for_each_entry(voltdm, &voltdm_list, node) {
 		if (!voltdm->scalable)
 			continue;
@@ -311,6 +373,10 @@ int __init omap_voltage_late_init(void)
 
 		if (voltdm->vc)
 			omap_vc_init_channel(voltdm);
+
+		if (voltage_dir)
+			voltdm_debugfs_init(voltage_dir, voltdm);
+
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index f079167..2f7b268 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -88,6 +88,7 @@ struct voltagedomain {
 	u32 curr_volt;
 
 	struct omap_vdd_info *vdd;
+	struct dentry *debug_dir;
 };
 
 /**
-- 
1.7.0.4

