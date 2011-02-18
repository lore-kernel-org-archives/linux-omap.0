From: Thomas Weber <weber@corscience.de>
Subject: [RFC/PATCH] OMAP: Fix section mismatch
Date: Fri, 18 Feb 2011 14:15:53 +0100
Message-ID: <1298034953-21016-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50492 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1BRNRa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 08:17:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>

When compiling linux-omap with 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
the following output occurs:

WARNING: arch/arm/plat-omap/built-in.o(.data+0x6e8): Section mismatch in
reference from the variable omap_driver to the function
.init.text:omap_cpu_init()
The variable omap_driver references
the function __init omap_cpu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

This patch fixes this by adding __refdata to the omap_driver variable.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/plat-omap/cpu-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 11c54ec..17fdd5f 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -144,7 +144,7 @@ static struct freq_attr *omap_cpufreq_attr[] = {
 	NULL,
 };
 
-static struct cpufreq_driver omap_driver = {
+static struct cpufreq_driver omap_driver __refdata = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= omap_verify_speed,
 	.target		= omap_target,
-- 
1.7.4.1

