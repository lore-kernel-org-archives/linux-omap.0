From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/8] omap3: 3430sdp: Enable Linux Regulator framework
Date: Tue, 10 Nov 2009 19:01:34 -0800
Message-ID: <20091111030134.31793.97177.stgit@localhost>
References: <20091111025907.31793.84134.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49427 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbZKKDBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 22:01:30 -0500
In-Reply-To: <20091111025907.31793.84134.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org

From: Sergio Aguirre <saaguirre@ti.com>

Some drivers have dependencies on this, and therefore should be
enabled.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8a4a7e2..5a305f0 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1703,7 +1703,14 @@ CONFIG_RTC_DRV_TWL4030=y
 # on-CPU RTC drivers
 #
 # CONFIG_DMADEVICES is not set
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
+# CONFIG_REGULATOR_DEBUG is not set
+# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
+# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
+# CONFIG_REGULATOR_BQ24022 is not set
+# CONFIG_REGULATOR_MAX1586 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
 

