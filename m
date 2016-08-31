From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 23/23] ARM: dts: dra7: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:37 +0200
Message-ID: <1472639737-17586-24-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/dra7-evm.dts       | 2 +-
 arch/arm/boot/dts/dra72-evm-revc.dts | 2 +-
 arch/arm/boot/dts/dra72-evm.dts      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d47c8739bdaa..cc609517f2c2 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -16,7 +16,7 @@
 	model = "TI DRA742";
 	compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7";
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x60000000>; /* 1536 MB */
 	};
diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index f9cfd3bb4dc2..064b322a7a04 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -11,7 +11,7 @@
 / {
 	model = "TI DRA722 Rev C EVM";
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>; /* 2GB */
 	};
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index cc1d32ca4a8a..e3a9b6985693 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -9,7 +9,7 @@
 / {
 	model = "TI DRA722";
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x40000000>; /* 1024 MB */
 	};
-- 
2.7.4
