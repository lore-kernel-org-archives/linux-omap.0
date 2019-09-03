From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
Date: Tue, 3 Sep 2019 08:06:35 +0530
Message-ID: <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
> 1GHz capability is automatically detected.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> index 5441e9ffdbb4..e98b0c615f19 100644
> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -11,13 +11,6 @@
>  	cpus {
>  		cpu@0 {
>  			cpu0-supply = <&vcc>;
> -			operating-points = <
> -				/* kHz    uV */
> -				300000  1012500
> -				600000  1200000
> -				800000  1325000
> -				1000000	1375000
> -			>;
>  		};
>  	};

This should be merged with 2/5 ?

-- 
viresh
