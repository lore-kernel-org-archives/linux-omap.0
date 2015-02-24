From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] ARM: dts: am335x-bone*: usb0 is hardwired for peripheral
Date: Tue, 24 Feb 2015 10:10:43 -0600
Message-ID: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35089 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbBXQKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2015 11:10:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>

Fixes: http://bugs.elinux.org/issues/127

the bb.org community was seeing random reboots before this change.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 6cc25ed..2c6248d 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -195,6 +195,7 @@
 
 &usb0 {
 	status = "okay";
+	dr_mode = "peripheral";
 };
 
 &usb1 {
-- 
2.1.4

