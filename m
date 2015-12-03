From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: Use MMC pwrseq instead regulators for IGEP
 WiFi init
Date: Thu, 3 Dec 2015 10:16:24 -0800
Message-ID: <20151203181624.GW23396@atomide.com>
References: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449165729-993-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org> [151203 10:03]:
> Hello,
> 
> This series converts the IGEPv2 (IGEP0020) and IGEP COM Module (IGEP0030)
> Device Tree to use the MMC power sequence provider to initialize the SDIO
> WiFi chip instead of using fake fixed regulators to just toggle the Reset
> and Power pins in the chip.
> 
> The patches were tested on an DM3730 IGEPv2 board but the IGEP COM Module
> is the same with regard to the SDIO WiFi so it should be safe to land too.
> 
> The IGEPv2 Rev.F and the IGEP COM Module Rev.G DTS were not converted due
> using a different WiFi chip (wlcore instead of libertas) than the one in
> the board I've access to test so I preferred to leave those untouched.

Do you have some solution for the start-up latency issue?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
