From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/11] omap2/3/4: Add new boards to omap3_defconfig
Date: Fri, 30 Apr 2010 13:34:01 -0700
Message-ID: <20100430203401.25812.94179.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61107 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933085Ab0D3UeD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:34:03 -0400
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Enable 2430 omaps and the missing boards.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index d6ad921..01e5986 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -264,7 +264,7 @@ CONFIG_MACH_OMAP_GENERIC=y
 # OMAP Core Type
 #
 CONFIG_ARCH_OMAP2420=y
-# CONFIG_ARCH_OMAP2430 is not set
+CONFIG_ARCH_OMAP2430=y
 CONFIG_ARCH_OMAP3430=y
 CONFIG_OMAP_PACKAGE_CBB=y
 CONFIG_OMAP_PACKAGE_CUS=y
@@ -276,8 +276,9 @@ CONFIG_OMAP_PACKAGE_CBP=y
 CONFIG_MACH_OMAP2_TUSB6010=y
 CONFIG_MACH_OMAP_H4=y
 CONFIG_MACH_OMAP_APOLLON=y
-# CONFIG_MACH_OMAP_2430SDP is not set
+CONFIG_MACH_OMAP_2430SDP=y
 CONFIG_MACH_OMAP3_BEAGLE=y
+CONFIG_MACH_DEVKIT8000=y
 CONFIG_MACH_OMAP_LDP=y
 CONFIG_MACH_OVERO=y
 CONFIG_MACH_OMAP3EVM=y

