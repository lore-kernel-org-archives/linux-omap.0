From: "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Subject: [PATCH] omap: mailbox: unregister correct mbox device for omap2420
Date: Mon, 22 Feb 2010 17:54:52 -0600
Message-ID: <23D0CDE7C386D144A4F26EB0F427F8C0986C7517@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32994 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450Ab0BVXy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 18:54:57 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

label err_iva1 is defined to unregister the mbox device
for omap2420 which is contained in mbox_iva_info struct

mbox_dsp_info is not being used by the omap2420

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Index: omap/arch/arm/mach-omap2/mailbox.c
===================================================================
--- omap.orig/arch/arm/mach-omap2/mailbox.c	2010-02-22 17:41:24.000000000 -0600
+++ omap/arch/arm/mach-omap2/mailbox.c	2010-02-22 17:51:31.000000000 -0600
@@ -420,7 +420,7 @@
 	return 0;
 
 err_iva1:
-	omap_mbox_unregister(&mbox_dsp_info);
+	omap_mbox_unregister(&mbox_iva_info);
 
 err_dsp:
 	iounmap(mbox_base);
