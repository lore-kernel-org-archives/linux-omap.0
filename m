From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
Date: Mon, 1 Jun 2015 21:33:28 +0200
Message-ID: <20150601193328.GA27640@squirrel.local>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
 <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
 <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
 <CAALWOA9wyCsUQqER2Cqwru_2REpX6AeryWeoSuwZWDsdPPL+Ow@mail.gmail.com>
 <20150601172330.GX30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35040 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbFATdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 15:33:32 -0400
Content-Disposition: inline
In-Reply-To: <20150601172330.GX30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>

On 1 June 2015 at 19:23, Tony Lindgren <tony@atomide.com> wrote:
> Ah finally you got around doing a proper patch :)

My First Linux Patch(tm) ;-)

> Also, if this is needed as a fix for the mainline kernel to avoid hardware
> damage, please let me know too ASAP.

The damaging configuration is having &rtc { system-power-controller; }
without &tps { ti,pmic-shutdown-controller; }

So 3d76be5b9 also avoids damage, but with the unfortunate side-effect
that the system doesn't power off at all anymore (it just halts). I do
recommend applying this patch (restyled as needed) before reverting
3d76be5b9.

> Hmm no ideas about that, I guess people are using gmail to send email
> with smtps though?

Hmm, setting up mutt turned out less hassle than I remembered...

(Let's hope all goes well)

> Linux usually does not use the // style comments.. Can you please change
> that? And how about have just one section of comments then the entry
> for ti,pmic-shutdown-controller?

Fresh try...

--- 8< -----------------------------------------------------
Fixes: http://bugs.elinux.org/issues/143

Avoid entering "RTC-only mode" at poweroff. It is unsupported by most
versions of BeagleBone, and risks hardware damage.

Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Tested-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Johan Hovold <johan@kernel.org>
[Matthijs van Duin: added explanatory comments]
Signed-off-by: Matthijs van Duin <matthijsvanduin@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index c3255e0..c0b0c02 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -223,6 +223,24 @@
 /include/ "tps65217.dtsi"
 
 &tps {
+	/* Configure pmic to enter OFF-state instead of SLEEP-state ("RTC-only
+	 * mode") at poweroff.  Most BeagleBone versions do not support RTC-only
+	 * mode and risk hardware damage if this mode is entered.
+	 *
+	 * For details, see linux-omap mailing list May 2015 thread
+	 *	[PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
+	 * In particular, messages:
+	 *	http://www.spinics.net/lists/linux-omap/msg118585.html
+	 *	http://www.spinics.net/lists/linux-omap/msg118615.html
+	 *
+	 * You can override this later with
+	 *	&tps {  /delete-property/ ti,pmic-shutdown-controller;  }
+	 * if you want to use RTC-only mode and made sure you are not affected
+	 * by the hardware problems. (Tip: double-check by performing a current
+	 * measurement after shutdown: it should be less than 1 mA.)
+	 */
+	ti,pmic-shutdown-controller;
+
 	regulators {
 		dcdc1_reg: regulator@0 {
 			regulator-name = "vdds_dpr";
-- 
2.1.4

