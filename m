From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2] ARM: OMAP1: usb: fix sparse warnings
Date: Fri, 26 Oct 2012 21:28:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210262128050.11258@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com> <20121026212059.GV11908@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41158 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945941Ab2JZV27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 17:28:59 -0400
In-Reply-To: <20121026212059.GV11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com


Resolve the following sparse warnings:

arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was not declared. Should it be static?
arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was not declared. Should it be static?
arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was not declared. Should it be static?

by declaring those functions as static.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>
---

Applies on linux-omap/omap-for-v3.8/cleanup-headers.

 arch/arm/mach-omap1/usb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 84267ed..104fed3 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -301,7 +301,7 @@ static inline void otg_device_init(struct omap_usb_config *pdata)
 
 #endif
 
-u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
+static u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
 {
 	u32	syscon1 = 0;
 
@@ -409,7 +409,7 @@ u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
 	return syscon1 << 16;
 }
 
-u32 __init omap1_usb1_init(unsigned nwires)
+static u32 __init omap1_usb1_init(unsigned nwires)
 {
 	u32	syscon1 = 0;
 
@@ -475,7 +475,7 @@ bad:
 	return syscon1 << 20;
 }
 
-u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
+static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
 {
 	u32	syscon1 = 0;
 
-- 
1.7.10.4

