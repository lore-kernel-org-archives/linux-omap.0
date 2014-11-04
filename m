From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: gpmc: Error out if timings fail in
 gpmc_probe_generic_child()
Date: Mon, 3 Nov 2014 16:45:31 -0800
Message-ID: <20141104004530.GM31454@atomide.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
 <1413895309-9152-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19927 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaKDAqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2014 19:46:36 -0500
Content-Disposition: inline
In-Reply-To: <1413895309-9152-3-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

* Roger Quadros <rogerq@ti.com> [141021 05:43]:
> gpmc_cs_set_timings() returns non-zero if there was
> an error while setting the GPMC timings. e.g. Timing was too
> large to be accomodated with current GPMC clock frequency and available
> timing range. Fail in this case, else we risk operating a NOR device
> with non compliant timings.

With the error checks now enabled properly, I noticed our
LAN9220 timings are overflowing. So we need the following
patch to switch over to use the known working u-boot timings.
Otherwise NFSroot will fail on quite a few boards.

Regards,

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 3 Nov 2014 16:33:14 -0800
Subject: [PATCH] ARM: dts: Use better omap GPMC timings for LAN9220

With the GPMC warnings now enabled, I noticed the LAN9220 timings
can overflow the GPMC registers with 200MHz L3 speed. Earlier we
were just skipping the bad timings and would continue with the
bootloader timings. Now we no longer allow to continue with bad
timings as we have the timings in the .dts files.

We could start using the GPMC clock divider, but let's instead
use the u-boot timings that are known to be working and a bit
faster. These are basically the u-boot NET_GPMC_CONFIG[1-6]
defines deciphered.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -23,24 +23,30 @@
 	ethernet@gpmc {
 		compatible = "smsc,lan9221", "smsc,lan9115";
 		bank-width = <2>;
-		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <1>;
-		gpmc,cs-rd-off-ns = <180>;
-		gpmc,cs-wr-off-ns = <180>;
-		gpmc,adv-rd-off-ns = <18>;
-		gpmc,adv-wr-off-ns = <48>;
-		gpmc,oe-on-ns = <54>;
-		gpmc,oe-off-ns = <168>;
-		gpmc,we-on-ns = <54>;
-		gpmc,we-off-ns = <168>;
-		gpmc,rd-cycle-ns = <186>;
-		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <144>;
-		gpmc,page-burst-access-ns = <24>;
-		gpmc,bus-turnaround-ns = <90>;
-		gpmc,cycle2cycle-delay-ns = <90>;
-		gpmc,cycle2cycle-samecsen;
-		gpmc,cycle2cycle-diffcsen;
+		gpmc,device-width = <1>;
+		gpmc,burst-length = <4>;
+		gpmc,cycle2cycle-samecsen = <1>;
+		gpmc,cycle2cycle-diffcsen = <1>;
+		gpmc,cs-on-ns = <5>;
+		gpmc,cs-rd-off-ns = <150>;
+		gpmc,cs-wr-off-ns = <150>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <15>;
+		gpmc,adv-wr-off-ns = <40>;
+		gpmc,oe-on-ns = <45>;
+		gpmc,oe-off-ns = <140>;
+		gpmc,we-on-ns = <45>;
+		gpmc,we-off-ns = <140>;
+		gpmc,rd-cycle-ns = <155>;
+		gpmc,wr-cycle-ns = <155>;
+		gpmc,access-ns = <120>;
+		gpmc,page-burst-access-ns = <20>;
+		gpmc,bus-turnaround-ns = <75>;
+		gpmc,cycle2cycle-delay-ns = <75>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		gpmc,wr-access-ns = <0>;
 		vddvario-supply = <&vddvario>;
 		vdd33a-supply = <&vdd33a>;
 		reg-io-width = <4>;
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index d59e3de..fbbb455 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -22,24 +22,30 @@
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <4 0 0xff>;
 		bank-width = <2>;
-		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <1>;
-		gpmc,cs-rd-off-ns = <180>;
-		gpmc,cs-wr-off-ns = <180>;
-		gpmc,adv-rd-off-ns = <18>;
-		gpmc,adv-wr-off-ns = <48>;
-		gpmc,oe-on-ns = <54>;
-		gpmc,oe-off-ns = <168>;
-		gpmc,we-on-ns = <54>;
-		gpmc,we-off-ns = <168>;
-		gpmc,rd-cycle-ns = <186>;
-		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <144>;
-		gpmc,page-burst-access-ns = <24>;
-		gpmc,bus-turnaround-ns = <90>;
-		gpmc,cycle2cycle-delay-ns = <90>;
-		gpmc,cycle2cycle-samecsen;
-		gpmc,cycle2cycle-diffcsen;
+		gpmc,device-width = <1>;
+		gpmc,burst-length = <4>;
+		gpmc,cycle2cycle-samecsen = <1>;
+		gpmc,cycle2cycle-diffcsen = <1>;
+		gpmc,cs-on-ns = <5>;
+		gpmc,cs-rd-off-ns = <150>;
+		gpmc,cs-wr-off-ns = <150>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <15>;
+		gpmc,adv-wr-off-ns = <40>;
+		gpmc,oe-on-ns = <45>;
+		gpmc,oe-off-ns = <140>;
+		gpmc,we-on-ns = <45>;
+		gpmc,we-off-ns = <140>;
+		gpmc,rd-cycle-ns = <155>;
+		gpmc,wr-cycle-ns = <155>;
+		gpmc,access-ns = <120>;
+		gpmc,page-burst-access-ns = <20>;
+		gpmc,bus-turnaround-ns = <75>;
+		gpmc,cycle2cycle-delay-ns = <75>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		gpmc,wr-access-ns = <0>;
 		vddvario-supply = <&vddvario>;
 		vdd33a-supply = <&vdd33a>;
 		reg-io-width = <4>;
