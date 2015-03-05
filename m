From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/4] ARM: dts: am43x-epos-evm: Add rtc node with ti,no-init property
Date: Thu, 5 Mar 2015 07:13:30 -0600
Message-ID: <1425561211-31003-4-git-send-email-d-gerlach@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39744 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572AbbCENOT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 08:14:19 -0500
In-Reply-To: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>

Add rtc node with ti,no-init property so that rtc hwmod does not get
initialized as the RTC IP is disabled in hardware by the board layout
on am43x-epos-evm so the SoC cannot access the IP at all. Without this,
hwmod writes to the RTC SYSCONFIG register and causes a kernel panic
during boot.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 257c099..ba7dbc0 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -687,3 +687,7 @@
 		};
 	};
 };
+
+&rtc {
+	ti,no-init;
+};
-- 
2.3.0

