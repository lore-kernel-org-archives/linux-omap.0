From: Francisco Alecrim <alecrim@gmail.com>
Subject: [PATCH] n8x0_defconfig: remove CONFIG_NILFS2_FS override
Date: Wed, 17 Mar 2010 15:46:42 -0400
Message-ID: <1268855202-15003-1-git-send-email-alecrim@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:58333 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590Ab0CQTrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 15:47:20 -0400
Received: by iwn1 with SMTP id 1so1142250iwn.22
        for <linux-omap@vger.kernel.org>; Wed, 17 Mar 2010 12:47:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>

From: Francisco Alecrim <francisco.alecrim@openbossa.org>

arch/arm/configs/n8x0_defconfig:1061:warning: override: reassigning to
symbol NILFS2_FS

Signed-off-by: Francisco Alecrim <francisco.alecrim@openbossa.org>
---
 arch/arm/configs/n8x0_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index 216ad00..9405e32 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -1058,7 +1058,6 @@ CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
-- 
1.6.3.3

