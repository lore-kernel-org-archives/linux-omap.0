From: venkat <venkat.raju@embinux.com>
Subject: Updating the gitignore to ignore include/asm-arm/mach-types.h
Date: Tue, 14 Jul 2009 11:46:20 +0530
Message-ID: <4A5C22B4.5000806@embinux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060400030103070903060101"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 59.160.172.216.static.vsnl.net.in ([59.160.172.216]:52174 "EHLO
	collab.embinux.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbZGNGXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 02:23:08 -0400
Received: from ws124.idc.embinux.org (localhost [127.0.0.1])
	by collab.embinux.com (Postfix) with ESMTP id ABE61A988A3
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2009 11:43:23 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060400030103070903060101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi  All,

 Found that "include/asm-arm/mach-types.h" was generating after 
compilation which needs to be ignored by git.  Attached patch simply add 
this file to gitignore.


Regards,
Venkat.

--------------060400030103070903060101
Content-Type: text/x-patch;
 name="Updating-the-gitignore-to-ignore-include-asm-arm-mac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Updating-the-gitignore-to-ignore-include-asm-arm-mac.patch"

>From c1ac3148d1352716216dc020a584a0085bd3667b Mon Sep 17 00:00:00 2001
From: Venkat Raju <venkat.raju@embinux.com>
Date: Tue, 14 Jul 2009 10:10:30 +0530
Subject: [PATCH] Updating the gitignore to ignore include/asm-arm/mach-types.h

This file was genarating after compilation and was showing as
untracked file.

Signed-off-by: Venkat Raju <venkat.raju@embinux.com>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 51bd99d..d4928fc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -43,6 +43,7 @@ Module.symvers
 #
 include/asm
 include/asm-*/asm-offsets.h
+include/asm-arm/mach-types.h
 include/config
 include/linux/autoconf.h
 include/linux/compile.h
-- 
1.5.3.3


--------------060400030103070903060101--
