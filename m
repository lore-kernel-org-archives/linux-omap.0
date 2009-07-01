From: Kucheria Amit <amit.kucheria@verdurent.com>
Subject: Re: OMAP3: RX51: build warning at rx51_t2scripts
Date: Wed, 1 Jul 2009 14:38:53 +0300
Message-ID: <20090701113853.GJ9645@everest>
References: <4A4B1821.20604@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39034 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZGALi4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 07:38:56 -0400
Received: by fxm18 with SMTP id 18so732681fxm.37
        for <linux-omap@vger.kernel.org>; Wed, 01 Jul 2009 04:38:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A4B1821.20604@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 09 Jul 01, Roger Quadros wrote:
> Hi Amit,
> 
> I get the following warning while building Kevin's PM branch for RX-51.
> The kernel boots to shell though.
> I'm not sure whether it's harmless or not.
> 
> 
> MODPOST vmlinux.o
> WARNING: vmlinux.o(.data+0xb328): Section mismatch in reference from
> the variable rx51_t2scripts_data to the (unknown reference)
> .init.data:(unknown)
> The variable rx51_t2scripts_data references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,


Attached patch should fix this problem. Compile-tested only. 

I've already applied this to the code that I am pushing upstream. So
this should be dropped eventually.

-- 
------------------------------------------------------------
Amit Kucheria, Finland
------------------------------------------------------------

--eHhjakXzOLJAF9wJ
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0195-TWL4030-RX51-Mark-board-data-as-__initdata.patch"

>From 49c93de6ccfd48eed0064cdec17ad77d9842d624 Mon Sep 17 00:00:00 2001
From: Amit Kucheria <amit.kucheria@canonical.com>
Date: Wed, 1 Jul 2009 14:32:28 +0300
Subject: [PATCH 195/195] TWL4030: RX51: Mark board data as __initdata

Mark rx51 board data as __initdata so that compiling with
CONFIG_DEBUG_SECTION_MISMATCH=y will not throw warnings.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 43d081b..f7ebec8 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -367,7 +367,7 @@ static struct twl4030_script *twl4030_scripts[] __initdata = {
 	&wrst_script,
 };
 
-static struct twl4030_resconfig twl4030_rconfig[] = {
+static struct twl4030_resconfig twl4030_rconfig[] __initdata = {
 	{ .resource = RES_VINTANA1, .devgroup = -1, .type = -1, .type2 = 1 },
 	{ .resource = RES_VINTANA2, .devgroup = -1, .type = -1, .type2 = 1 },
 	{ .resource = RES_VINTDIG, .devgroup = -1, .type = -1, .type2 = 1 },
@@ -387,7 +387,7 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
-static struct twl4030_power_data rx51_t2scripts_data = {
+static struct twl4030_power_data rx51_t2scripts_data __initdata = {
 	.scripts        = twl4030_scripts,
 	.size   = ARRAY_SIZE(twl4030_scripts),
 	.resource_config = twl4030_rconfig,
@@ -395,7 +395,7 @@ static struct twl4030_power_data rx51_t2scripts_data = {
 
 
 
-static struct twl4030_platform_data rx51_twldata = {
+static struct twl4030_platform_data rx51_twldata __initdata = {
 	.irq_base		= TWL4030_IRQ_BASE,
 	.irq_end		= TWL4030_IRQ_END,
 
-- 
1.6.3.3


--eHhjakXzOLJAF9wJ--
