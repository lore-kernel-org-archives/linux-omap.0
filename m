From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Tue, 30 Jun 2015 11:24:04 +0200
Message-ID: <20150630092404.GA19285@amd>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150629091146.GA5103@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

> Just tried booting 4.2-rc0 on n900 (commit
> 4a10a91756ef381bced7b88cfb9232f660b92d93) and it is broken. Previous
> -rc0 version worked. This time, there's some output on console, but
> too fast for me to read.
> 
> It seems oopses happen before mounting root. If you have serial
> console, they should be easy to see.

I tried again according to pali's instructions, and it is still
broken the same way. Any other ideas? Does it work for you?

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cf..ff6f2bf 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -570,6 +570,7 @@
 			interrupts = <49>;
 			dmas = <&sdma 69>;
 			dma-names = "rx";
+			status = "disabled";
 		};
 
 		smartreflex_core: smartreflex@480cb000 {

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
