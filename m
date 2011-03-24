From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 07/19] OMAP3: voltage: add scalable flag to voltagedomain
Date: Wed, 23 Mar 2011 17:00:21 -0700
Message-ID: <1300924833-26745-8-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40176 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933110Ab1CXAA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:26 -0400
Received: by mail-iy0-f169.google.com with SMTP id 13so9806101iyf.28
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:24 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Add a 'bool scalable' flag to the struct powerdomain and set it for
the MPU_IVA and CORE voltage domains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.c                 |    3 +++
 arch/arm/mach-omap2/voltage.h                 |    2 ++
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index f995003..bc944ff 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -1054,6 +1054,9 @@ int __init omap_voltage_late_init(void)
 		pr_err("%s: Unable to create voltage debugfs main dir\n",
 			__func__);
 	list_for_each_entry(voltdm, &voltdm_list, node) {
+		if (!voltdm->scalable)
+			continue;
+
 		if (voltdm->vdd) {
 			if (omap_vdd_data_configure(voltdm))
 				continue;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 5440298..25cfb5c 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -53,11 +53,13 @@ struct omap_vfsm_instance_data {
 /**
  * struct voltagedomain - omap voltage domain global structure.
  * @name: Name of the voltage domain which can be used as a unique identifier.
+ * @scalable: Whether or not this voltage domain is scalable
  * @node: list_head linking all voltage domains
  * @vdd: to be removed
  */
 struct voltagedomain {
 	char *name;
+	bool scalable;
 	struct list_head node;
 	struct omap_vdd_info *vdd;
 };
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index b476ee6..e9664843 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -61,11 +61,13 @@ static struct omap_vdd_info omap3_vdd2_info = {
 
 static struct voltagedomain omap3_voltdm_mpu = {
 	.name = "mpu_iva",
+	.scalable = true,
 	.vdd = &omap3_vdd1_info,
 };
 
 static struct voltagedomain omap3_voltdm_core = {
 	.name = "core",
+	.scalable = true,
 	.vdd = &omap3_vdd2_info,
 };
 
-- 
1.7.4

