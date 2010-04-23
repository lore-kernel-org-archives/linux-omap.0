From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 18/28] omap: rx51_defconfig: Remove CONFIG_SYSFS_DEPRECATED*=y
	options
Date: Fri, 23 Apr 2010 16:11:46 -0700
Message-ID: <20100423231146.31953.72504.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57021 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab0DWXLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:46 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

Modern udev will not work with the CONFIG_SYSFS_DEPRECATED*=y options and
it seems also that the Maemo release works without when testing with the
Maemo 2.6.28 kernel.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

