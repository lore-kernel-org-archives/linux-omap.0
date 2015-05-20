From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
Date: Wed, 20 May 2015 09:47:26 -0700
Message-ID: <20150520164725.GU10274@atomide.com>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52433 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207AbbETQr3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 12:47:29 -0400
Content-Disposition: inline
In-Reply-To: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Johan Hovold <johan@kernel.org>

* Robert Nelson <robertcnelson@gmail.com> [150520 08:53]:
> Fixes: http://bugs.elinux.org/issues/143
> 
> Entering RTC-only sleep is only properly supported on early prototypes series
> (pre-A6) of the BeagleBone Black.  Since rev (A6A), which include all production
> versions, it is not support at due to.
> 
> (rev A6) enable of the 3v3b regulator moved from LDO2 to LDO4 (3v3a)
> side-effect: 3v3b rail remains on in sleep-mode (also in off-mode when battery-powered)
> 
> (rev A6A) am335x vdds supply moved from LDO3 to LDO1
> side-effect: vdds remains supplied in sleep-mode
> 
> Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> Tested-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Johan Hovold <johan@kernel.org>
> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 5c42d25..901739f 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -80,7 +80,3 @@
>  		status = "okay";
>  	};
>  };
> -
> -&rtc {
> -	system-power-controller;
> -};

Applying into omap-for-v4.1/fixes thanks.

Regards,

Tony
