From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 13/13] ARM: dts: am335x-boneblack: enable the PRUSSv2 device
Date: Sun, 29 Jun 2014 18:21:47 +0200
Message-ID: <1404058907-21112-14-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:52493 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbaF2QWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:22:13 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 305975d..eeb5c2e 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -75,3 +75,7 @@
 		status = "okay";
 	};
 };
+
+&pruss {
+	status = "okay";
+};
-- 
2.0.0

