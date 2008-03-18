From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: [PATCH] Refresh palmtt_defconfig
Date: Tue, 18 Mar 2008 10:20:04 +0200
Message-ID: <1205828404919-git-send-email-francisco.alecrim@indt.org.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43866 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYCRJVE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 05:21:04 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2I9Lk72014754
	for <linux-omap@vger.kernel.org>; Tue, 18 Mar 2008 04:22:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>

Refresh palmtt_defconfig

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
---
 arch/arm/configs/palmtt_defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/palmtt_defconfig b/arch/arm/configs/palmtt_defconfig
index 4a5fcb4..e54ced4 100644
--- a/arch/arm/configs/palmtt_defconfig
+++ b/arch/arm/configs/palmtt_defconfig
@@ -252,8 +252,8 @@ CONFIG_FPE_NWFPE=y
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
1.5.2.5

