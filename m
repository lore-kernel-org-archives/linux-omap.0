From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
Date: Mon, 1 Jun 2015 10:23:30 -0700
Message-ID: <20150601172330.GX30984@atomide.com>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
 <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
 <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
 <CAALWOA9wyCsUQqER2Cqwru_2REpX6AeryWeoSuwZWDsdPPL+Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55098 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbbFARXd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 13:23:33 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA9wyCsUQqER2Cqwru_2REpX6AeryWeoSuwZWDsdPPL+Ow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150531 22:16]:
> Here's a version that attempts to address Tony's earlier request to
> include some comments in the patch itself. Since I saw no way to
> concisely summarize the issues, I included links to relevant messages
> (and enough info to locate the thread again in case of link rot).

Ah finally you got around doing a proper patch :)
 
> Since the patch itself contains more explanation, I made the commit
> message more concise.
> 
> Apologies for the attachment (inline text would get fucked up by gmail)

Hmm no ideas about that, I guess people are using gmail to send email
with smtps though?

> From 4278ecc32e886d2e83bc486e6409d8f6df82a0d1 Mon Sep 17 00:00:00 2001
> From: Matthijs van Duin <matthijsvanduin@gmail.com>
> Date: Mon, 1 Jun 2015 06:56:24 +0200
> Subject: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
> 
> Fixes: http://bugs.elinux.org/issues/143
> 
> Avoid entering "RTC-only mode" at poweroff. It is unsupported by most
> versions of BeagleBone, and risks hardware damage.
> 
> Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> Tested-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Johan Hovold <johan@kernel.org>
> [Matthijs van Duin: added explanatory comments]
> Signed-off-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index c3255e0..90fbbb1 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -223,6 +223,24 @@
>  /include/ "tps65217.dtsi"
>  
>  &tps {
> +	// Configure pmic to enter OFF-state instead of SLEEP-state ("RTC-only
> +	// mode") at poweroff.  Most BeagleBone versions do not support RTC-only
> +	// mode and risk hardware damage if this mode is entered.
> +	//
> +	// For details, see linux-omap mailing list May 2015 thread
> +	//	[PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
> +	// In particular, messages:
> +	//	http://www.spinics.net/lists/linux-omap/msg118585.html
> +	//	http://www.spinics.net/lists/linux-omap/msg118615.html
> +	//
> +	ti,pmic-shutdown-controller;
> +	//
> +	// You can override this later with
> +	//	&tps {  /delete-property/ ti,pmic-shutdown-controller;  }
> +	// if you want to use RTC-only mode and made sure you are not affected
> +	// by the hardware problems. (Tip: double-check by performing a current
> +	// measurement after shutdown: it should be less than 1 mA.)
> +
>  	regulators {
>  		dcdc1_reg: regulator@0 {
>  			regulator-name = "vdds_dpr";

Linux usually does not use the // style comments.. Can you please change
that? And how about have just one section of comments then the entry
for ti,pmic-shutdown-controller? Or maybe something like this:

	/*
	 * Configure pmic to enter OFF-state instead of SLEEP-state ("RTC-only
	 * mode") at poweroff.  Most BeagleBone versions do not support RTC-only
	 * ....
	 */
	&tps {
		ti,pmic-shutdown-controller;

		regulators {
			...
		};
		...
	};

Also, if this is needed as a fix for the mainline kernel to avoid hardware
damage, please let me know too ASAP.

Regards,

Tony
