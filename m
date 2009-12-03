From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/10] OMAP: omap_device: use UINT_MAX for default wakeup
	latency limit
Date: Thu, 03 Dec 2009 06:49:52 -0700
Message-ID: <20091203134951.17146.23073.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49058 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbZLCNyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:54:37 -0500
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

The _dev_wakeup_lat_limit field of struct omap_device is u32, so use
UINT_MAX instead of INT_MAX for the default maximum.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index bb16e62..54fe0a2 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -459,7 +459,7 @@ int omap_device_enable(struct platform_device *pdev)
 	ret = _omap_device_activate(od, IGNORE_WAKEUP_LAT);
 
 	od->dev_wakeup_lat = 0;
-	od->_dev_wakeup_lat_limit = INT_MAX;
+	od->_dev_wakeup_lat_limit = UINT_MAX;
 	od->_state = OMAP_DEVICE_STATE_ENABLED;
 
 	return ret;


