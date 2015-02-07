From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] thermal: ti-soc-thermal: fix compilation warnings when
 !CONFIG_PM_SLEEP
Date: Sat, 7 Feb 2015 00:17:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502062259190.3767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-178357410-1423268267=:3767"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:32915 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbbBGARs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Feb 2015 19:17:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-178357410-1423268267=:3767
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE


When CONFIG_PM_SLEEP=3Dn, the following compilation warnings appear:

drivers/thermal/ti-soc-thermal/ti-bandgap.c:1478:12: warning: =A1ti_bandgap=
_suspend=A2 defined but not used [-Wunused-function]
 static int ti_bandgap_suspend(struct device *dev)
            ^
drivers/thermal/ti-soc-thermal/ti-bandgap.c:1492:12: warning: =A1ti_bandgap=
_resume=A2 defined but not used [-Wunused-function]
 static int ti_bandgap_resume(struct device *dev)

A few years ago, suspend/resume-related code was protected by CONFIG_PM. =
=20
But that was changed and now it's protected by CONFIG_PM_SLEEP.  Fix the=20
warnings by converting the preprocessor test in the TI bandgap thermal=20
sensor driver from testing CONFIG_PM to testing CONFIG_PM_SLEEP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Non-critical.  Targeted for either v3.20-rc1 or v3.21-rc1.

Basic test reports for a series that includes this patch (and a few other=
=20
unrelated warning cleanups) is available here:

http://www.pwsan.com/omap/testlogs/fix-omap-warnings-v3.21/20150206154619/

Compare to:

http://www.pwsan.com/omap/testlogs/test_v3.19-rc7/20150204213018/

 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/=
ti-soc-thermal/ti-bandgap.c
index 634b6ce0e63a..62a5d449c388 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1402,7 +1402,7 @@ int ti_bandgap_remove(struct platform_device *pdev)
 =09return 0;
 }
=20
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ti_bandgap_save_ctxt(struct ti_bandgap *bgp)
 {
 =09int i;
--=20
2.1.4

--843723315-178357410-1423268267=:3767--
