From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 13/13] ARM: Kconfig update to support additional GPIOs in OMAP5
Date: Thu, 3 May 2012 12:56:22 +0530
Message-ID: <1336029982-31898-14-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46881 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710Ab2ECH0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:26:42 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

From: Tarun Kanti DebBarma <tarun.kanti@ti.com>

OMAP5 has 8 GPIO banks so that there are 32x8 = 256 GPIOs.
In order for the gpiolib to detect and initialize these
additional GPIOs and other TWL GPIOs, ARCH_NR_GPIO is set
to 512 instead of present 256.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Reported-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf006d4..d649c16 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1602,6 +1602,7 @@ config ARCH_NR_GPIO
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
 	default 355 if ARCH_U8500
 	default 264 if MACH_H4700
+	default 512 if ARCH_OMAP5
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
-- 
1.7.1

