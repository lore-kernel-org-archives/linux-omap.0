From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 06/12] ARM: dts: cm-t3x30: add twl4030 gpio pullups
Date: Sun, 12 Jan 2014 15:22:49 +0200
Message-ID: <1389532975-28281-7-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:58782 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbaALNXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:04 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add pullup for twl4030 GPIO_0 used as MMC1 card detect signal.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index 4bcc639..a56d082 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -90,4 +90,6 @@
 
 &twl_gpio {
 	ti,use-leds;
+	/* pullups: BIT(0) */
+	ti,pullups = <0x000001>;
 };
-- 
1.7.5.4

