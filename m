From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: omap2plus_defconfig: Enable pcf857x
Date: Mon, 19 Jan 2015 10:15:57 -0800
Message-ID: <1421691358-14661-3-git-send-email-tony@atomide.com>
References: <1421691358-14661-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34025 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751677AbbASSTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 13:19:34 -0500
In-Reply-To: <1421691358-14661-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

We have pcf857x at least several boards. Let's enable it
as a loadable module.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d6f84f2..3ac8269 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -205,6 +205,7 @@ CONFIG_SPI_TI_QSPI=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCF857X=m
 CONFIG_GPIO_TWL4030=y
 CONFIG_W1=m
 CONFIG_HDQ_MASTER_OMAP=m
-- 
2.1.4

