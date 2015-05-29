From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] fix n900 dts file to work around 4.1 touchscreen regression
 on n900
Date: Fri, 29 May 2015 21:32:11 +0200
Message-ID: <20150529193211.GA7599@amd>
References: <201505241444.41039@pali>
 <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54133 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197AbbE2TcN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 15:32:13 -0400
Content-Disposition: inline
In-Reply-To: <20150529192505.GA28987@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, maxime.ripard@free-electrons.com, dmitry.torokhov@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, patrikbachan@gmail.com
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Fix dts to match what the Linux kernel expects. This works around
touchscreen problems in 4.1 linux on Nokia n900.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
index 4b641c7..09089a6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
@@ -32,8 +32,8 @@ Example:
 		touchscreen-fuzz-x = <4>;
 		touchscreen-fuzz-y = <7>;
 		touchscreen-fuzz-pressure = <2>;
-		touchscreen-max-x = <4096>;
-		touchscreen-max-y = <4096>;
+		touchscreen-size-x = <4096>;
+		touchscreen-size-y = <4096>;
 		touchscreen-max-pressure = <2048>;
 
 		ti,x-plate-ohms = <280>;
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5c16145..5f5e0f3 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -832,8 +832,8 @@
 		touchscreen-fuzz-x = <4>;
 		touchscreen-fuzz-y = <7>;
 		touchscreen-fuzz-pressure = <2>;
-		touchscreen-max-x = <4096>;
-		touchscreen-max-y = <4096>;
+		touchscreen-size-x = <4096>;
+		touchscreen-size-y = <4096>;
 		touchscreen-max-pressure = <2048>;
 
 		ti,x-plate-ohms = <280>;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
