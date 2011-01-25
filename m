From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: hwmod: Populate _mpu_rt_va later on in
 omap_hwmod_late_init
Date: Tue, 25 Jan 2011 11:27:20 -0800
Message-ID: <20110125192719.GO13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
 <20110124202629.GE13589@atomide.com>
 <20110124215213.GA27044@n2100.arm.linux.org.uk>
 <20110125022119.GG13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30534 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1AYT1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 14:27:45 -0500
Content-Disposition: inline
In-Reply-To: <20110125022119.GG13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Otherwise ioremap can fail with early_init patch unless we have
a static mapping for everything.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eacdfd3..9e89a58 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1467,12 +1467,10 @@ static int __init _register(struct omap_hwmod *oh)
 		return -EEXIST;
 
 	ms_id = _find_mpu_port_index(oh);
-	if (!IS_ERR_VALUE(ms_id)) {
+	if (!IS_ERR_VALUE(ms_id))
 		oh->_mpu_port_index = ms_id;
-		oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
-	} else {
+	else
 		oh->_int_flags |= _HWMOD_NO_MPU_PORT;
-	}
 
 	list_add_tail(&oh->node, &omap_hwmod_list);
 
@@ -1621,6 +1619,26 @@ int __init omap_hwmod_init(struct omap_hwmod **ohs)
 	return 0;
 }
 
+/*
+ * _populate_mpu_rt_base - populate the virtual address for a hwmod
+ *
+ * Must be called only from omap_hwmod_late_init so ioremap works properly.
+ * Assumes the caller takes care of locking if needed.
+ *
+ */
+static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *data)
+{
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return 0;
+
+	oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
+	if (!oh->_mpu_rt_va)
+		pr_warning("omap_hwmod: %s found no _mpu_rt_va for %s\n",
+				__func__, oh->name);
+
+	return 0;
+}
+
 /**
  * omap_hwmod_late_init - do some post-clock framework initialization
  *
@@ -1632,6 +1650,8 @@ static int __init omap_hwmod_late_init(void)
 {
 	int r;
 
+	r = omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
+
 	/* XXX check return value */
 	r = omap_hwmod_for_each(_init_clocks, NULL);
 	WARN(r, "omap_hwmod: omap_hwmod_late_init(): _init_clocks failed\n");
