From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable generic SoC internal OMAP regulators
Date: Thu, 9 Apr 2015 16:15:21 -0500
Message-ID: <1428614121-3374-4-git-send-email-nm@ti.com>
References: <1428614121-3374-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57230 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756182AbbDIVQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 17:16:09 -0400
In-Reply-To: <1428614121-3374-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Nishanth Menon <nm@ti.com>

ABB and PBIAS are internal LDO control regulators that are needed for
maintaining proper functionality of OMAP architecture SoCs. Enable the
same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f48dfa7787dc..b86ff6e957a0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -363,8 +363,10 @@ CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
+CONFIG_REGULATOR_TI_ABB=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS65090=y
-- 
1.7.9.5

