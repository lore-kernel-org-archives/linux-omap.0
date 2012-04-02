From: Roger Quadros <rogerq@ti.com>
Subject: L2 cache stability workaround for 4460  ES1.0
Date: Mon, 2 Apr 2012 09:55:25 +0300
Message-ID: <4F794D5D.3090509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070008020601020603010905"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55212 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab2DBGz2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 02:55:28 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q326tSUs009207
	for <linux-omap@vger.kernel.org>; Mon, 2 Apr 2012 01:55:28 -0500
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q326tSmI024005
	for <linux-omap@vger.kernel.org>; Mon, 2 Apr 2012 01:55:28 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Dechesne, Nicolas" <n-dechesne@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--------------070008020601020603010905
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Santosh,

I came across the attached patch from you. I also came across this post
stating that it was decided not to send this patch upstream.

http://www.digipedia.pl/usenet/thread/18885/8437/#post8496

The problem is that we have to keep porting this patch each time we
update the kernel.

Do you know if the root cause has been found? If not can we have this
patch upstream till the root cause is found?

It seems the patch at least makes the kernel usable on ES1.0.

regards,
-roger

--------------070008020601020603010905
Content-Type: text/x-patch;
	name="0001-OMAP4460-L2X0-work-around-for-stability.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-OMAP4460-L2X0-work-around-for-stability.patch"

>From 68ab20c60335eef5aceb9c5f978b8d6ef4b11d9b Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 27 Mar 2012 11:20:09 -0400
Subject: [PATCH 1/3] OMAP4460: L2X0: work-around for stability.

OMAP4460 ES1.0 seems to suffer from stability with L2 cache enabled.
The root-cause analysis is ongoing but in meantime this chabe is
to enable a software WA with L2 cache enabled build. The WA consist
of locking certain cache ways based on their positions on the
physical memory layout.

Downside of this WA is that effective L2 cache size will be 512 KB
instead of 1 MB.

clalancette: Changed so that the workaround is only activated
for ES1.0, and not ES1.1.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Chris Lalancette <clalancette@gmail.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    5 +++++
 arch/arm/mach-omap2/omap4-common.c         |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 7df239b..8e3f8f2 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -56,6 +56,11 @@
 #define L2X0_LOCKDOWN_STRIDE		0x08
 #define L2X0_ADDR_FILTER_START		0xC00
 #define L2X0_ADDR_FILTER_END		0xC04
+#define L2X0_LOCKDOWN_WAY_D0           0x900
+#define L2X0_LOCKDOWN_WAY_D1           0x908
+#define L2X0_LOCKDOWN_WAY_I0           0x904
+#define L2X0_LOCKDOWN_WAY_I1           0x90C
+
 #define L2X0_TEST_OPERATION		0xF00
 #define L2X0_LINE_DATA			0xF10
 #define L2X0_LINE_TAG			0xF30
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 70de277..4e190c8 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -129,6 +129,7 @@ static void omap4_l2x0_set_debug(unsigned long val)
 static int __init omap_l2_cache_init(void)
 {
 	u32 aux_ctrl = 0;
+	u32 lockdown = 0;
 
 	/*
 	 * To avoid code running on other OMAPs in
@@ -164,6 +165,23 @@ static int __init omap_l2_cache_init(void)
 	if (omap_rev() != OMAP4430_REV_ES1_0)
 		omap_smc1(0x109, aux_ctrl);
 
+	/*
+	 * WA for OMAP4460 ES1.0 L2 cache corruption issue.
+	 * Lock-down specific L2 cache ways which  makes effective
+	 * L2 size as 512 KB instead of 1 MB
+	 *
+	 * The L2 cache in the ES1.1 doesn't have this issue, so only enable
+	 *  the workaround for ES1.0.
+	 */
+	if (omap_rev() == OMAP4460_REV_ES1_0) {
+		printk(KERN_INFO "OMAP4460 ES1.0 detected, enabling L2 cache stability workaround\n");
+		lockdown = 0xa5a5;
+		writel_relaxed(lockdown, l2cache_base + L2X0_LOCKDOWN_WAY_D0);
+		writel_relaxed(lockdown, l2cache_base + L2X0_LOCKDOWN_WAY_D1);
+		writel_relaxed(lockdown, l2cache_base + L2X0_LOCKDOWN_WAY_I0);
+		writel_relaxed(lockdown, l2cache_base + L2X0_LOCKDOWN_WAY_I1);
+	}
+
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);
 
-- 
1.7.9.1


--------------070008020601020603010905--
