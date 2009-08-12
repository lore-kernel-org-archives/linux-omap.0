From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] OMAP3: rx51_defconfig: add twl4030 to rx51 default
	configuration
Date: Wed, 12 Aug 2009 15:17:24 +0300
Message-ID: <20090812121724.17601.4003.stgit@localhost>
References: <20090812120926.17601.85860.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49313 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZHLMRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 08:17:33 -0400
In-Reply-To: <20090812120926.17601.85860.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>, linux-omap@vger.kernel.org

From: Timo Kokkonen <timo.t.kokkonen@nokia.com>

twl4030 watchdog will be compiled as a module by default.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/rx51_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index eb2cb31..f4fb6ee 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -1006,6 +1006,7 @@ CONFIG_WATCHDOG=y
 #
 # CONFIG_SOFT_WATCHDOG is not set
 CONFIG_OMAP_WATCHDOG=m
+CONFIG_TWL4030_WATCHDOG=m
 
 #
 # USB-based Watchdog Cards

