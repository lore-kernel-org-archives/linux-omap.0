From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 4/4] ARM: dts: am437x-gp-evm: Enable RTC
Date: Thu, 5 Mar 2015 07:13:31 -0600
Message-ID: <1425561211-31003-5-git-send-email-d-gerlach@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39745 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932579AbbCENOT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 08:14:19 -0500
In-Reply-To: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>

From: Keerthy <j-keerthy@ti.com>

Enable RTC on am437x-gp-evm.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index f84d971..b2a16c2 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -651,3 +651,7 @@
 		};
 	};
 };
+
+&rtc {
+	status = "okay";
+};
-- 
2.3.0

