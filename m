From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 1/1] ARM: OMAP2+: omap2plus_defconfig: enable devtmpfs and automount
Date: Fri, 14 Dec 2012 19:02:48 +0100
Message-ID: <1355508168-32565-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:59155 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab2LNSDH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:03:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Since udev-176 [1], udev no longer creates device nodes under
/dev and this has to be managed by the kernel devtmpfs filesystem.

This makes devtmpfs filesystem a requirement on newer systems and
a kernel built with the current OMAP2+ config will not boot on them.

Also, it is good to have devtmpfs at /dev automount enabled by default.

[1]: http://permalink.gmane.org/gmane.linux.hotplug.devel/17230

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1:
    - Point to correct udev version that first this a requirement
      as suggested by Sekhar Nori

 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a1dc5c0..ad41190 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -65,6 +65,8 @@ CONFIG_MAC80211_RC_PID=y
 CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
-- 
1.7.7.6

