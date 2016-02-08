From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain
 data
Date: Mon, 8 Feb 2016 11:57:04 -0800
Message-ID: <20160208195704.GW19432@atomide.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454922990-7501-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [160208 01:19]:
> OMAP5 has 3 thermal zones cpu, core and multimedia.
> On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> and iva. Currently cpu, core and multimedia are being added via dt
> and the other 2 are getting added via kernel. Add the missing thermal
> domains in dt so as give the correct trip numbers, type and temperatures.
> 
> Tested on DRA7-EVM.

Are these critical fixes to have for v4.5-rc cycle or can they
wait for v4.6 merge window?

Regards,

Tony

> Keerthy (3):
>   arm: dts: DRA7: Add DSPEVE thermal data
>   arm: dts: DRA7: Add IVA thermal data
>   arm: dts: DRA7: Add missing IVA and DSPEVE thermal domain data
> 
>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi                |  2 ++
>  3 files changed, 56 insertions(+)
>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>  create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
> 
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
