From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: dts: Fix GPMC timings for LAN9220
Date: Wed, 23 Apr 2014 12:03:23 -0700
Message-ID: <1398279803-5655-4-git-send-email-tony@atomide.com>
References: <1398279803-5655-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20707 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756729AbaDWTD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 15:03:29 -0400
In-Reply-To: <1398279803-5655-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Javier Martinez Canillas <javier@dowhile0.org>

I've noticed occasional random oopsing on my gateway
machine since I upgraded it to use device tree based
booting. As this machine has worked reliably before
that for a few years, pretty much the only difference
was narrowed down to the GPMC timings. Turns out that
for legacy based booting we are using bootloader timings
for GPMC for smsc911x. With device tree we are passing
the timings in the .dts file, and the device tree
timings are not quite suitable for LAN9920.

Enabling DEBUG in gpmc.c I noticed that the device tree
configured timings are different from the the known
working bootloader timings. So let's fix the timings to
match the bootloader timings when looked at the gpmc
dmesg output with DEBUG enabled.

The changes were done by multiplying the bootloader
tick values by six to get the nanosecond value for
device tree. This is not generic from the device point
of view as the calculations should be based on the device
timings. Anyways, further improvments can be done based
on the timings documentation for LAN9220. But let's first
get things to a known good working state.

Note that we still need to change the timings also for
sb-t35 also as it has two LAN9220 instances on GPMC and
we can currently include the generic timings only once.

Also note that any boards that have LAN9221 instead of
LAN9220 should be updated to use omap-gpmc-smsc9221.dtsi
instead of omap-gpmc-smsc911x.dtsi. The LAN9221 timings
are different from LAN9220 timings.

Cc: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi | 19 ++++++++-----------
 arch/arm/boot/dts/omap3-sb-t35.dtsi       | 19 ++++++++-----------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
index f577b7d..521c587 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -24,11 +24,10 @@
 		compatible = "smsc,lan9221", "smsc,lan9115";
 		bank-width = <2>;
 		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <186>;
-		gpmc,cs-wr-off-ns = <186>;
-		gpmc,adv-on-ns = <12>;
-		gpmc,adv-rd-off-ns = <48>;
+		gpmc,cs-on-ns = <1>;
+		gpmc,cs-rd-off-ns = <180>;
+		gpmc,cs-wr-off-ns = <180>;
+		gpmc,adv-rd-off-ns = <18>;
 		gpmc,adv-wr-off-ns = <48>;
 		gpmc,oe-on-ns = <54>;
 		gpmc,oe-off-ns = <168>;
@@ -36,12 +35,10 @@
 		gpmc,we-off-ns = <168>;
 		gpmc,rd-cycle-ns = <186>;
 		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <114>;
-		gpmc,page-burst-access-ns = <6>;
-		gpmc,bus-turnaround-ns = <12>;
-		gpmc,cycle2cycle-delay-ns = <18>;
-		gpmc,wr-data-mux-bus-ns = <90>;
-		gpmc,wr-access-ns = <186>;
+		gpmc,access-ns = <144>;
+		gpmc,page-burst-access-ns = <24>;
+		gpmc,bus-turnaround-ns = <90>;
+		gpmc,cycle2cycle-delay-ns = <90>;
 		gpmc,cycle2cycle-samecsen;
 		gpmc,cycle2cycle-diffcsen;
 		vddvario-supply = <&vddvario>;
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index b3b6e43..d59e3de 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -23,11 +23,10 @@
 		reg = <4 0 0xff>;
 		bank-width = <2>;
 		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <186>;
-		gpmc,cs-wr-off-ns = <186>;
-		gpmc,adv-on-ns = <12>;
-		gpmc,adv-rd-off-ns = <48>;
+		gpmc,cs-on-ns = <1>;
+		gpmc,cs-rd-off-ns = <180>;
+		gpmc,cs-wr-off-ns = <180>;
+		gpmc,adv-rd-off-ns = <18>;
 		gpmc,adv-wr-off-ns = <48>;
 		gpmc,oe-on-ns = <54>;
 		gpmc,oe-off-ns = <168>;
@@ -35,12 +34,10 @@
 		gpmc,we-off-ns = <168>;
 		gpmc,rd-cycle-ns = <186>;
 		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <114>;
-		gpmc,page-burst-access-ns = <6>;
-		gpmc,bus-turnaround-ns = <12>;
-		gpmc,cycle2cycle-delay-ns = <18>;
-		gpmc,wr-data-mux-bus-ns = <90>;
-		gpmc,wr-access-ns = <186>;
+		gpmc,access-ns = <144>;
+		gpmc,page-burst-access-ns = <24>;
+		gpmc,bus-turnaround-ns = <90>;
+		gpmc,cycle2cycle-delay-ns = <90>;
 		gpmc,cycle2cycle-samecsen;
 		gpmc,cycle2cycle-diffcsen;
 		vddvario-supply = <&vddvario>;
-- 
1.8.1.1

