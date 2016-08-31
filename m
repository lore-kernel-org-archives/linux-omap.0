From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 17/23] ARM: dts: am3517: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:31 +0200
Message-ID: <1472639737-17586-18-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am3517-craneboard.dts | 2 +-
 arch/arm/boot/dts/am3517-evm.dts        | 2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am3517-craneboard.dts b/arch/arm/boot/dts/am3517-craneboard.dts
index f9d8f3948c4a..083ff5073435 100644
--- a/arch/arm/boot/dts/am3517-craneboard.dts
+++ b/arch/arm/boot/dts/am3517-craneboard.dts
@@ -15,7 +15,7 @@
 	model = "TI AM3517 CraneBoard (TMDSEVM3517)";
 	compatible = "ti,am3517-craneboard", "ti,am3517", "ti,omap3";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>;	/* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index b4127c6493a2..0e4a125f78e3 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -13,7 +13,7 @@
 	model = "TI AM3517 EVM (AM3517/05 TMDSEVM3517)";
 	compatible = "ti,am3517-evm", "ti,am3517", "ti,omap3";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
index fdf5ce63c8e6..3395783c5b4e 100644
--- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -13,7 +13,7 @@
 	model = "TeeJet Mt.Ventoux";
 	compatible = "teejet,mt_ventoux", "ti,omap3";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
-- 
2.7.4
