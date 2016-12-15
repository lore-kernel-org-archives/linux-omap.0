From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: [PATCH] Update Nanobone dts file to add external FRAM chip
Date: Thu, 15 Dec 2016 10:52:13 +0000
Message-ID: <3e63c74c-1808-46bd-4c63-5ea049cca4e2@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>From v4.2+ the GPMC code has been changed to reset all the bootloader
GPMC settings when the kernel starts.

As such, this DTS file now needs the external FRAM defined.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 483d585..807494b 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -249,7 +249,8 @@
 
 	#address-cells = <2>;
 	#size-cells = <1>;
-	ranges = <0 0 0x08000000 0x08000000>;	/* CS0: NOR 128M */
+	ranges = <0 0 0x08000000 0x08000000>,	/* CS0: NOR 128M */
+		 <1 0 0x1c000000 0x01000000>;	/* CS1: FRAM 16M */
 
 	nor@0,0 {
 		reg = <0 0x00000000 0x08000000>;
@@ -342,6 +343,34 @@
 			reg = <0x04000000 0x04000000>; /* 64MB */
 		};
 	};
+
+	fram@1,0 {
+		reg = <1 0x00000000 0x01000000>;
+		bank-width = <2>;
+
+		gpmc,mux-add-data = <2>;
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <160>;
+		gpmc,cs-wr-off-ns = <160>;
+		gpmc,adv-on-ns = <10>;
+		gpmc,adv-rd-off-ns = <20>;
+		gpmc,adv-wr-off-ns = <20>;
+		gpmc,oe-on-ns = <30>;
+		gpmc,oe-off-ns = <150>;
+		gpmc,we-on-ns = <30>;
+		gpmc,we-off-ns = <150>;
+		gpmc,rd-cycle-ns = <160>;
+		gpmc,wr-cycle-ns = <160>;
+		gpmc,access-ns = <130>;
+		gpmc,page-burst-access-ns = <10>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+		gpmc,cycle2cycle-delay-ns = <10>;
+		gpmc,wr-data-mux-bus-ns = <30>;
+		gpmc,wr-access-ns = <0>;
+	};
 };
 
 &mac {
-- 
2.7.4
