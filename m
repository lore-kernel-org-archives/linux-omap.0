From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] ARM: OMAP2: mach-omap2/pm.c build fix
Date: Wed, 19 Mar 2008 09:29:26 -0400
Message-ID: <47E11536.6000803@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-fb01.nokia.com ([192.100.122.235]:49622 "EHLO
	mgw-fb01.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476AbYCSU2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 16:28:19 -0400
Received: from mgw-mx03.nokia.com (mgw-mx03.nokia.com [192.100.122.230])
	by mgw-fb01.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JE5TQQ020934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 16:05:30 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch fix the following build problem:

  CC      arch/arm/mach-omap2/pm.o
arch/arm/mach-omap2/pm.c: In function 'omap2_pm_init':
arch/arm/mach-omap2/pm.c:840: warning: passing argument 2 of 'sysfs_create_file' from incompatible pointer type

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 3a455e8..fb77e33 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -837,7 +837,7 @@ int __init omap2_pm_init(void)
 	suspend_set_ops(&omap_pm_ops);
 	pm_idle = omap2_pm_idle;
 
-	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr);
+	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 
-- 1.5.3.GIT

