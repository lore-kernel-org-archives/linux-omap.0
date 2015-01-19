From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: omap2plus_defconfig: Enable support for davinci_emac
Date: Mon, 19 Jan 2015 10:15:56 -0800
Message-ID: <1421691358-14661-2-git-send-email-tony@atomide.com>
References: <1421691358-14661-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33974 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751677AbbASSTc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 13:19:32 -0500
In-Reply-To: <1421691358-14661-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

We have this on at least 3517-evm and dm8168-evm. Let's
enable davinci_emac so those can be booted with NFSroot.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b5ccb36..d6f84f2 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -145,6 +145,7 @@ CONFIG_KS8851_MLL=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
+CONFIG_TI_DAVINCI_EMAC=y
 CONFIG_TI_CPSW=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-- 
2.1.4

