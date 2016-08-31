From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 20/23] ARM: dts: dm8148: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:34 +0200
Message-ID: <1472639737-17586-21-git-send-email-javier@osg.samsung.com>
References: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/dm8148-evm.dts  | 2 +-
 arch/arm/boot/dts/dm8148-t410.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 376b85381e8c..d6657b3bae84 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -12,7 +12,7 @@
 	model = "DM8148 EVM";
 	compatible = "ti,dm8148-evm", "ti,dm8148";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;	/* 1 GB */
 	};
diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148-t410.dts
index b1ce1398b3ed..63883b3479f9 100644
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -11,7 +11,7 @@
 	model = "HP t410 Smart Zero Client";
 	compatible = "hp,t410", "ti,dm8148";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;	/* 1 GB */
 	};
-- 
2.7.4
