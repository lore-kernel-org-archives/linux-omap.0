From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/4] dsp-bridge: remove unnecessary comments in util.h
Date: Sun, 22 Feb 2009 11:32:21 +0200
Message-ID: <1235295144-22097-1-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:47068 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbZBVJjX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 04:39:23 -0500
Received: by fxm11 with SMTP id 11so892892fxm.13
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2009 01:39:21 -0800 (PST)
In-Reply-To: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, h-kanigeri2@ti.com, ameya.palande@nokia.com, Felipe Contreras <felipe.contreras@gmail.com>

For starters util.h should not exist, but for now I'm cleaning it up to
remove the 'history log' which is tracked by git anyway, and wrong
information about private functions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/util.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/util.h b/arch/arm/plat-omap/include/dspbridge/util.h
index 3b3e9c0..9d8842a 100644
--- a/arch/arm/plat-omap/include/dspbridge/util.h
+++ b/arch/arm/plat-omap/include/dspbridge/util.h
@@ -27,24 +27,6 @@
  *      UTIL_GetSysInfo
  *      UTIL_Init
  *      UTIL_Wait
- *
- *  Private Functions:
- *      isspace
- *
- *  Notes:
- *
- *! Revision History
- *! ================
- *! 12-Aug-2000 ag: Added UTIL_GetSysInfo().
- *! 31-Jan-2000 rr: Comments modifed for UTIL_Wait fxn.
- *! 17-Jan-2000 rr: UTIL_Wait fxn added. Busy waits x number of micro seconds.
- *! 12-Nov-1999 kc: Modified UTIL_CmdLineToArgs for use by different tests.
- *! 02-Nov-1999 kc: Removed parameter from UTIL_CDTestDll.
- *! 29-Oct-1999 kc: Cleaned up for code review.
- *! 08-Oct-1999 kc: Renamed UTIL_TestDllExec to UTIL_CDTestDll; added
- *!                 UTIL_CmdLineToArgs(); added isspace private func.
- *! 26-Dec-1996 cr: Created from misc pieces of wcd95.c, ktest.c.
- *
  */
 
 #ifndef _UTIL_H
-- 
1.6.1.3

