From: MING ZHOU <a17711@motorola.com>
Subject: [PATCH] Correct definition of register of OMAP4_RM_RSTST and OMAP4_RM_RSTTIME
Date: Tue, 7 Dec 2010 15:34:17 +0800
Message-ID: <AANLkTi=OdG2j2o+uZ+L_EpGKPTE8=fRBN8U60sJkqAhK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:37308 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab0LGI1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 03:27:01 -0500
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id oB77WrM3010523
	for <linux-omap@vger.kernel.org>; Tue, 7 Dec 2010 00:32:53 -0700 (MST)
Received: from mail-ew0-f53.google.com (mail-ew0-f53.google.com [209.85.215.53])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id oB77Wqvd010510
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 7 Dec 2010 00:32:53 -0700 (MST)
Received: by ewy6 with SMTP id 6so8428125ewy.12
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 23:34:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Since we need to reconfigure Reset time for OMAP4, we found the OMAP4
register definition for reset time is wrong according to spec of
OMAP4. And we verified this by reading default value of register. We
found the offset definition of Reset time and Reset Test register
should be switched. After correcting this bug, we verified by changing
the value of reset time register, the pulse generated for reset is
also changed as expected on scope.

>From 9a9c98c2f4008e5d8f2f5da1101e3bfe222a48ed Mon Sep 17 00:00:00 2001
From: Zhou Ming <a17711@motorola.com>
Date: Tue, 7 Dec 2010 10:00:59 -0500
Subject: [PATCH] Correct definition of register of OMAP4_RM_RSTST and
OMAP4_RM_RSTTIME

According to test result, we found the offset definition of OMAP4_RM_RSTST
and OMAP4_RM_RSTIME should be switched.
---
 arch/arm/mach-omap2/prm.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 7be040b..23b4be2 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -222,8 +222,8 @@

 /* Omap4 specific registers */
 #define OMAP4_RM_RSTCTRL                               0x0000
-#define OMAP4_RM_RSTTIME                               0x0004
-#define OMAP4_RM_RSTST                                 0x0008
+#define OMAP4_RM_RSTTIME                               0x0008
+#define OMAP4_RM_RSTST                                 0x0004
 #define OMAP4_PM_PWSTCTRL                              0x0000
 #define OMAP4_PM_PWSTST                                        0x0004
