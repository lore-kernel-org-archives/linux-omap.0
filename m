From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] arm: omap1: fix section mismatch on clk_init()
Date: Wed, 7 Apr 2010 12:35:27 +0300
Message-ID: <20100407093527.GX16297@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u5E4XgoOPWr4PD9E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58063 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238Ab0DGJfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 05:35:42 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o379ZcWQ026987
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 12:35:39 +0300
Received: from nokia.com (esdhcp04088.research.nokia.com [172.21.40.88])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o379ZVLR012166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 12:35:34 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Adding linux-omap to the loop.

Sorry, I had forgotten it.

-- 
balbi

--u5E4XgoOPWr4PD9E
Content-Type: message/rfc822
Content-Disposition: inline

Date: Wed, 7 Apr 2010 12:31:52 +0300
From: Felipe Balbi <felipe.balbi@nokia.com>
To: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] arm: omap1: fix section mismatch on clk_init()
Message-ID: <20100407093152.GW16297@nokia.com>
Reply-To: felipe.balbi@nokia.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Paul,

I thought you had fixed the section mismatch below, but for some reason 
it came up again. Attached is a patch to fix it:

WARNING: arch/arm/mach-omap1/built-in.o(.data+0x264): Section mismatch 
in reference from the variable omap1_clk_functions to the function 
.init.text:omap1_clk_disable_unused()
The variable omap1_clk_functions references
the function __init omap1_clk_disable_unused()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the 
variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, 
*_console, 

-- 
balbi

--fOHHtNG4YXGJ0yqR
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arm-omap1-clk-fix-section-mismatch-on-clk_init.diff"

>From a3b069cca760276d5eb2905e27939edf08b92797 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Wed, 7 Apr 2010 12:30:48 +0300
Subject: [PATCH] arm: omap1: clk: fix section mismatch on clk_init

remove the section annotation from omap1_clk_disable_unused()
to kill the section mismatch warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/clock.c |    2 +-
 arch/arm/mach-omap1/clock.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index e0aec10..6bbb1b8 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -578,7 +578,7 @@ int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 
-void __init omap1_clk_disable_unused(struct clk *clk)
+void omap1_clk_disable_unused(struct clk *clk)
 {
 	__u32 regval32;
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index a4190af..75d0d7d 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -39,7 +39,7 @@ extern long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate);
 extern unsigned long omap1_watchdog_recalc(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
-extern void __init omap1_clk_disable_unused(struct clk *clk);
+extern void omap1_clk_disable_unused(struct clk *clk);
 #else
 #define omap1_clk_disable_unused	NULL
 #endif
-- 
1.7.0.rc0.33.g7c3932


--fOHHtNG4YXGJ0yqR--

--u5E4XgoOPWr4PD9E--
