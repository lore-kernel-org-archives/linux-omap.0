From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: tidspbridge git repository
Date: Sun, 26 Apr 2009 19:30:26 -0700
Message-ID: <1240799426.29761.42.camel@localhost>
References: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com>
	 <20090323194711.GI29546@atomide.com> <49CCCF4E.2010708@nokia.com>
	 <20090327165043.GB18109@atomide.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0M0EAjBHtQrt51M7lnED"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:43759 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbZD0Cak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 22:30:40 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1109613wah.21
        for <linux-omap@vger.kernel.org>; Sun, 26 Apr 2009 19:30:39 -0700 (PDT)
In-Reply-To: <20090327165043.GB18109@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Nishanth Menon <nm@ti.com>


--=-0M0EAjBHtQrt51M7lnED
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 2009-03-27 at 09:50 -0700, Tony Lindgren wrote:
> * Ameya Palande <ameya.palande@nokia.com> [090327 06:06]:
> > Hi Tony,
> > 
> > ext Tony Lindgren wrote:
> > > * ameya.palande@nokia.com <ameya.palande@nokia.com> [090323 00:42]:
> > >> Hi Tony,
> > >>
> > >> I have collected latest patches for tidspbridge at:
> > >> git://gitorious.org/tidspbridge/mainline.git 
> > >>
> > >> Branch is: tidspbridge
> > >>
> > >> It is based on your pm branch.
> > >> Can you pull it to your tidspbridge branch?
> > > 
> > > What dependencies are there to the PM branch?
> > > 
> > > To me it sounds like you should rebase your tidspbridge branch
> > > against the mainline kernel as the drivers should be arch
> > > independent.
> > > 
> > > If something is missing from the mainline kernel to rebase and
> > > compile tidspbridge against the mainline, we need to fix those
> > > issues.
> > > 
> > > Regards,
> > > 
> > > Tony
> > 
> > I have rebased tidspbridge patches on top of current pm branch.
> > Currently bridge depends on some pm features which are not yet in
> > mainline.
> 
> Can you please describe what those dependencies are? We should fix
> those so we don't have dependencies.
>  
> > But at least now it can be compiled for your latest pm branch which
> > I guess is in turn based on 2.6.29
> > 
> > Here is the git URL:
> > git://gitorious.org/tidspbridge/mainline.git
> > 
> > Branch is: tidspbridge-2.6.29-pm
> 
> The thing is that in order to do the development in parallel, we want
> to base all the branches against the mainline kernel. Otherwise we'll
> have unnecessary dependencies between the branches.
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
﻿I agree with Tony. It would be great to avoid any dependency against a
specific branch. We managed to compile tidspbridge against 2.6.29 MASTER
(not PM branch) and it seems to work with the attached patch. It has
been tested on Beagleaboard,

Grégoire



>From 0b791888bcaa083983d6a04746c3a93b4e2c30b5 Mon Sep 17 00:00:00 2001
From: Tim Yamin <plasm@roo.me.uk>
Date: Sun, 26 Apr 2009 19:10:54 -0700
Subject: [PATCH] Make a few small changes so dspbridge compiles clean
against a non-pm tree.

Signed-off-by: Tim Yamin <plasm@roo.me.uk>
---
 arch/arm/mach-omap2/dspbridge.c         |    8 +++++---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 ++
 drivers/dsp/bridge/rmgr/proc.c          |    1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c
b/arch/arm/mach-omap2/dspbridge.c
index 43283c9..221e8ff 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -12,19 +12,21 @@
  */
 
 #include <linux/platform_device.h>
-
-#include <mach/omap-pm.h>
-
 #include <dspbridge/host_os.h>
 
 static struct platform_device *dspbridge_pdev;
 
+#ifdef CONFIG_BRIDGE_DVFS
+#include <mach/omap-pm.h>
 static struct dspbridge_platform_data dspbridge_pdata __initdata = {
 	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
 	.dsp_get_opp	 = omap_pm_dsp_get_opp,
 	.cpu_set_freq	 = omap_pm_cpu_set_freq,
 	.cpu_get_freq	 = omap_pm_cpu_get_freq,
 };
+#else
+static struct dspbridge_platform_data dspbridge_pdata;
+#endif
 
 static int __init dspbridge_init(void)
 {
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
b/drivers/dsp/bridge/rmgr/drv_interface.c
index 9466409..4aa7de6 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -100,8 +100,10 @@
 #include <dspbridge/dbreg.h>
 #endif
 
+#ifdef CONFIG_BRIDGE_DVFS
 #include <mach/omap-pm.h>
 #include <mach-omap2/omap3-opp.h>
+#endif
 
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
diff --git a/drivers/dsp/bridge/rmgr/proc.c
b/drivers/dsp/bridge/rmgr/proc.c
index 59073dd..332e01a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -145,7 +145,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
 #include <dspbridge/pwr.h>
-#include <mach-omap2/omap3-opp.h>
 
 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
-- 
1.5.6.3



--=-0M0EAjBHtQrt51M7lnED
Content-Disposition: attachment; filename*0=0001-Make-a-few-small-changes-so-dspbridge-compiles-clean.pat; filename*1=ch
Content-Type: application/mbox; name=0001-Make-a-few-small-changes-so-dspbridge-compiles-clean.patch
Content-Transfer-Encoding: 7bit

>From 0b791888bcaa083983d6a04746c3a93b4e2c30b5 Mon Sep 17 00:00:00 2001
From: Tim Yamin <plasm@roo.me.uk>
Date: Sun, 26 Apr 2009 19:10:54 -0700
Subject: [PATCH] Make a few small changes so dspbridge compiles clean against a non-pm tree.

Signed-off-by: Tim Yamin <plasm@roo.me.uk>
---
 arch/arm/mach-omap2/dspbridge.c         |    8 +++++---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 ++
 drivers/dsp/bridge/rmgr/proc.c          |    1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 43283c9..221e8ff 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -12,19 +12,21 @@
  */
 
 #include <linux/platform_device.h>
-
-#include <mach/omap-pm.h>
-
 #include <dspbridge/host_os.h>
 
 static struct platform_device *dspbridge_pdev;
 
+#ifdef CONFIG_BRIDGE_DVFS
+#include <mach/omap-pm.h>
 static struct dspbridge_platform_data dspbridge_pdata __initdata = {
 	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
 	.dsp_get_opp	 = omap_pm_dsp_get_opp,
 	.cpu_set_freq	 = omap_pm_cpu_set_freq,
 	.cpu_get_freq	 = omap_pm_cpu_get_freq,
 };
+#else
+static struct dspbridge_platform_data dspbridge_pdata;
+#endif
 
 static int __init dspbridge_init(void)
 {
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 9466409..4aa7de6 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -100,8 +100,10 @@
 #include <dspbridge/dbreg.h>
 #endif
 
+#ifdef CONFIG_BRIDGE_DVFS
 #include <mach/omap-pm.h>
 #include <mach-omap2/omap3-opp.h>
+#endif
 
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 59073dd..332e01a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -145,7 +145,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
 #include <dspbridge/pwr.h>
-#include <mach-omap2/omap3-opp.h>
 
 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
-- 
1.5.6.3


--=-0M0EAjBHtQrt51M7lnED--

