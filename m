From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 17/28] omap: rx51_defconfig: Remove duplicate phonet
Date: Fri, 23 Apr 2010 16:11:44 -0700
Message-ID: <20100423231144.31953.82729.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61855 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab0DWXLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:44 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

Phonet is enabled by the commit bce54fed941e03695ab557100a4bd1e457abca42
and this duplicate gives a warning when doing make rx51_defconfig.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/rx51_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 45135ff..cc6a32a 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -480,7 +480,6 @@ CONFIG_BT_HIDP=m
 # CONFIG_BT_HCIBFUSB is not set
 # CONFIG_BT_HCIVHCI is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 CONFIG_WIRELESS=y
 CONFIG_CFG80211=y
 # CONFIG_CFG80211_REG_DEBUG is not set

