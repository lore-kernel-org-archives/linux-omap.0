From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 6/8] OMAP: PM CONSTRAINTS: implement the devices wake-up latency constraints
Date: Thu, 15 Sep 2011 16:47:13 -0700
Message-ID: <878vpptlku.fsf@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
	<1314969204-21704-7-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36885 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935304Ab1IOXrT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 19:47:19 -0400
Received: by yxt33 with SMTP id 33so2516819yxt.3
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 16:47:18 -0700 (PDT)
In-Reply-To: <1314969204-21704-7-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Fri, 2 Sep 2011 15:13:22 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Implement the devices wake-up latency constraints using the global
> device PM QoS notification handler which applies the constraints to the
> underlying layer by calling the corresponding function at hwmod level.
>
> Note: the bus throughput function is implemented but currently is
> a no-op. A new PM QoS class for the bus throughput needs to be
> added.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

This patch does 2 things.

1) removes the MPU lat stuff from the OMAP PM layer (since it's now
   available in a generic form
2) implements device wake-up latency constraints

This should be broken up into two parts.

Also, this patch seems to remove a bunch of stuff that was just added in
patch 2/8.  Probably best to create the new OMAP PM layer after remving
the unused stuff.

It think the code using the new per-device PM QoS API should also live
outside the OMAP PM layer, since it's not related, and we want to get
rid of the OMAP PM layer eventually.

Speaking of which..., the more I think about it, the more I think we
should take this opportunity to clean and/or remove the OMAP PM layer
completely.

With your work, other than the no-op bus throughput API, it's basically
unused.  I think that rather than creating a new OMAP PM layer just to
have a a no-op bus throughput function here, I think it's time
to remove OMAP PM completely.   This might also give some incentive
for a PM QoS bus throughput constraint as well.

Of course, Paul can make the final decision there whether to remove it
now, but I think it's time.

Just to prove it's usefulness (or lack thereof), Here's a hack that
combined with your patch 1/8 shows that it is pretty easy to remove.

Kevin


diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index a5b7a23..e819d59 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -74,6 +74,13 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
+static int omap_display_get_context_loss_count(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return omap_device_get_context_loss_count(pdev);
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
@@ -98,7 +105,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 
 	pdata.board_data = board_data;
 	pdata.board_data->get_context_loss_count =
-		omap_pm_get_dev_context_loss_count;
+		omap_display_get_context_loss_count;
 
 	for (i = 0; i < oh_count; i++) {
 		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a9b45c7..fc001f7 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -36,7 +36,9 @@ static u16 control_mmc1;
 
 static int hsmmc_get_context_loss(struct device *dev)
 {
-	return omap_pm_get_dev_context_loss_count(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return omap_device_get_context_loss_count(pdev);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 132724c..6e8794a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -386,7 +386,7 @@ void __init omap2_init_common_infrastructure(void)
 				     _set_hwmod_postsetup_state,
 				     &postsetup_state);
 
-	omap_pm_if_early_init();
+	/* omap_pm_if_early_init(); */
 
 	if (cpu_is_omap2420())
 		omap2420_clk_init();
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 4411163..ca978c0 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -243,10 +243,10 @@ static int option_set(void *data, u64 val)
 	*option = val;
 
 	if (option == &enable_off_mode) {
-		if (val)
-			omap_pm_enable_off_mode();
-		else
-			omap_pm_disable_off_mode();
+		/* if (val) */
+		/* 	omap_pm_enable_off_mode(); */
+		/* else */
+		/* 	omap_pm_disable_off_mode(); */
 		if (cpu_is_omap34xx())
 			omap3_pm_off_mode_enable(val);
 	}
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 472bf22..59e7533 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -243,7 +243,7 @@ static void __init omap4_init_voltages(void)
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
-	omap_pm_if_init();
+	/* omap_pm_if_init(); */
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index f0233e6..3a2268c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -31,4 +31,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
-obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
+#obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
