From: <jgq516@gmail.com>
Subject: [PATCH 1/3] arm/dts: add wdt node for omap3 and omap4
Date: Fri, 25 May 2012 18:42:30 +0800
Message-ID: <1337942552-28218-2-git-send-email-jgq516@gmail.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, b-cousson@ti.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rnayak@ti.com, tony@atomide.com, wim@iguana.be
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Xiao Jiang <jgq516@gmail.com>

Add wdt node to support dt.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
---
 arch/arm/boot/dts/omap3.dtsi |    5 +++++
 arch/arm/boot/dts/omap4.dtsi |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 99474fa..039df5c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -215,5 +215,10 @@
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
 		};
+
+		wdt: wdt@48314000{
+			compatible = "ti,omap3-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..d01403d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,10 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		wdt: wdt@4a314000{
+			compatible = "ti,omap4-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
-- 
1.7.3
