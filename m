From: green@linuxhacker.ru
Subject: Regulator cleanups in mach-omap2, take two
Date: Mon,  6 Jun 2011 02:46:00 -0400
Message-ID: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:51439 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752958Ab1FFGrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 02:47:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hello!

   This is another attempt at some regulator cleanups in mach-omap2 code:
   Convert all users to REGULATOR_SUPPLY init style and drop the old-style
   .dev assignment common ins hs_mmc init.
   
   The only difference this time is the patch was split into two parts:
   One for REGULATOR_SUPPLY init and one for the .dev assignments removal.

   I made a test compile and all hte individual board files changed compile
   (I don't have the devices themselves, but similar changes to my
    device board file are working).

