From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] cpufreq: OMAP: fix build errors: depends on ARCH_OMAP2PLUS
Date: Mon, 26 Mar 2012 17:19:28 -0700
Message-ID: <1332807568-638-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:48304 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757866Ab2C0ATU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Mar 2012 20:19:20 -0400
Received: by ghrr20 with SMTP id r20so5241133ghr.13
        for <linux-omap@vger.kernel.org>; Mon, 26 Mar 2012 17:19:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

The OMAP driver needs a 'depends on ARCH_OMAP2PLUS' since it only
builds for OMAP2+ platforms.

This 'depends on' was in the original patch from Russell King, but was
erroneously removed by me when making this option user-selectable in
commit b09db45c (cpufreq: OMAP driver depends CPUfreq tables.)  This
patch remedies that.

Apologies to Russell King for breaking his originally working patch.

Also, thanks to Grazvydas Ignotas for reporting the same problem.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Dave, this applies on top of your current fixes branch, and fixes a 
problem introduced there by me.  Please merge for v3.4-rc.  Thanks.

 drivers/cpufreq/Kconfig.arm |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 82f1aa9..555a57b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -4,6 +4,7 @@
 
 config ARM_OMAP2PLUS_CPUFREQ
 	bool "TI OMAP2+"
+	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 	select CPU_FREQ_TABLE
 
-- 
1.7.9.2

