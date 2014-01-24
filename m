From: Tony Lindgren <tony@atomide.com>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Fri, 24 Jan 2014 10:11:56 -0800
Message-ID: <20140124181155.GC25488@atomide.com>
References: <52e06652.c103450a.79d7.6517@mx.google.com>
 <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com>
 <52E0B569.8000809@ti.com>
 <52E0CF58.5040109@epfl.ch>
 <52E0DA13.9090302@ti.com>
 <52E0DD9F.8000100@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61413 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaAXSMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jan 2014 13:12:06 -0500
Content-Disposition: inline
In-Reply-To: <52E0DD9F.8000100@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ash Charles <ash@gumstix.com>

* Florian Vaussard <florian.vaussard@epfl.ch> [140123 01:17]:
> 
> I just tested next-20140123 with an OMAP3630 ES1.2 Overo/Tobi. Changing
> the include to omap36xx.dtsi do not fix the issue. I still get the
> external abort on non-linefetch (full log here [1]).

I think the issue here is that you need to have "ti,omap36xx" in
the compatible string in addition to including omap36xx.dtsi.
Otherwise "ti,omap3" will initialize things for 34xx.

For the initial minimal fix, I suggest we do something like the
following. This should fix things for 36xx based tobi, then
34xx based tobi support can be added later on. Untested as I
don't have one.

Regards,

Tony


--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -9,9 +9,6 @@
 /*
  * The Gumstix Overo must be combined with an expansion board.
  */
-/dts-v1/;
-
-#include "omap34xx.dtsi"
 
 / {
 	pwmleds {
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -10,11 +10,14 @@
  * Tobi expansion board is manufactured by Gumstix Inc.
  */
 
+/dts-v1/;
+
+#include "omap36xx.dtsi"
 #include "omap3-overo.dtsi"
 
 / {
 	model = "TI OMAP3 Gumstix Overo on Tobi";
-	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3";
+	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap36xx", "ti,omap3";
 
 	leds {
 		compatible = "gpio-leds";
