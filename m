From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] omap: rx51_defconfig: Remove CONFIG_SYSFS_DEPRECATED*=y options
Date: Mon, 19 Apr 2010 16:52:10 +0300
Message-ID: <1271685130-19118-2-git-send-email-jhnikula@gmail.com>
References: <1271685130-19118-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:62745 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0DSNvy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 09:51:54 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so1449912ewy.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 06:51:53 -0700 (PDT)
In-Reply-To: <1271685130-19118-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

Modern udev will not work with the CONFIG_SYSFS_DEPRECATED*=y options and
it seems also that the Maemo release works without when testing with the
Maemo 2.6.28 kernel.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/configs/rx51_defconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index cc6a32a..473f9e1 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -59,8 +59,6 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
-- 
1.7.0

