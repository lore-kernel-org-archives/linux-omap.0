From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: [PATCH] Refresh palmz71_defconfig
Date: Sat, 29 Mar 2008 21:00:31 +0200
Message-ID: <1206817231-22364-1-git-send-email-francisco.alecrim@indt.org.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30111 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbYC2TIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Mar 2008 15:08:05 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2TJ9kqn024154
	for <linux-omap@vger.kernel.org>; Sat, 29 Mar 2008 14:10:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>

Refresh palmz71_defconfig

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
---
 arch/arm/configs/palmz71_defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/palmz71_defconfig b/arch/arm/configs/palmz71_defconfig
index 22017c8..6361922 100644
--- a/arch/arm/configs/palmz71_defconfig
+++ b/arch/arm/configs/palmz71_defconfig
@@ -282,8 +282,8 @@ CONFIG_FPE_NWFPE=y
 # Userspace binary formats
 #
 CONFIG_BINFMT_ELF=y
-CONFIG_BINFMT_AOUT=y
-CONFIG_BINFMT_MISC=y
+# CONFIG_BINFMT_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
 # CONFIG_ARTHUR is not set
 
 #
-- 
1.5.4.23.gef5b9

