From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Enable AM437x PMIC TPS65218
Date: Thu, 9 Apr 2015 16:15:20 -0500
Message-ID: <1428614121-3374-3-git-send-email-nm@ti.com>
References: <1428614121-3374-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57231 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbbDIVQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 17:16:09 -0400
In-Reply-To: <1428614121-3374-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Nishanth Menon <nm@ti.com>

Enable PMIC for AM437x platforms such as AM437x-sk similar to commit
a186cf10da84 ("ARM: omap2plus_defconfig: enable TPS65218 configs").
This allows multi_v7_defconfig to boot up on AM437x-sk platform.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 11c64858c623..f48dfa7787dc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -347,6 +347,7 @@ CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65090=y
 CONFIG_MFD_TPS65217=y
+CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_AB8500=y
@@ -368,6 +369,7 @@ CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS65090=y
 CONFIG_REGULATOR_TPS65217=y
+CONFIG_REGULATOR_TPS65218=y
 CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
-- 
1.7.9.5

