From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 1/1] ARM: dts: OMAP4/AM35xx: Fix missing dtb in the dtbs target
Date: Fri, 31 May 2013 16:05:51 +0200
Message-ID: <1370009151-32362-2-git-send-email-florian.vaussard@epfl.ch>
References: <1370009151-32362-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54480 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751374Ab3EaOGI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 10:06:08 -0400
In-Reply-To: <1370009151-32362-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Florian Vaussard <florian.vaussard@epfl.ch>

When making the dtbs target on OMAP/AM35xx, some trees are not
built.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9f7121..8eadd4e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -149,10 +149,13 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap4-panda-es.dtb \
 	omap4-var-som.dtb \
 	omap4-sdp.dtb \
+	omap4-sdp-es23plus.dtb \
 	omap5-evm.dtb \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
-	am335x-bone.dtb
+	am335x-bone.dtb \
+	am3517-evm.dtb \
+	am3517_mt_ventoux.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
-- 
1.7.5.4

