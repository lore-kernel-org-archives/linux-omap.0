From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 5/5] ARM: dts: omap3-beagle: make explicitly compatible to
 ti,omap34xx
Date: Tue, 3 Sep 2019 06:40:00 -0700
Message-ID: <20190903134000.GM52127@atomide.com>
References: <cover.1567421750.git.hns@goldelico.com>
 <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190902 10:56]:
> Matching the ti-cpufreq driver needs to specify explicitly if
> a board uses an omap34xx or omap36xx chip.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-beagle.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index e3df3c166902..d47213c7a4d0 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "TI OMAP3 BeagleBoard";
> -	compatible = "ti,omap3-beagle", "ti,omap3";
> +	compatible = "ti,omap3-beagle", "ti,omap34xx", "ti,omap3";
>  
>  	cpus {
>  		cpu@0 {

For a clean-up patch, we should just use the following compatibles
in general for omap3:

ti,omap3	omap3
ti,omap34	omap34xx and omap35xx
ti,omap36	omap36xx and dm37xx
ti,am35		am35xx

So we should just leave out the "xx" part. But we still need parse
also the legacy binding with "xx" in drivers.

Regards,

Tony
