From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be
 explicitly ti,omap3430 or ti,omap36xx
Date: Thu, 5 Sep 2019 07:27:34 -0700
Message-ID: <20190905142734.GV52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]:
> According to omap.txt bindings documentation, matching the ti-cpufreq driver needs
> to specify explicitly if a board uses an omap3430 or omap36xx chip.
> 
> This needs to add ti,omap3430 to most omap34xx boards and replace ti,omap3630
> by ti,omap36xx for some omap36xx boards (most others already have done it right).
> 
> We also clean up some instances of missing ti,am3517 so that we can rely on
> seeing either one of:
> 
> ti,am3517
> ti,omap34xx
> ti,omap36xx
> 
> in addition to ti,omap3.

Please set up things to use ti,omap3630 in addition to ti,omap36xx
for compatible to avoid churning the same files later.

> diff --git a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
> --- a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
> +++ b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
> @@ -9,5 +9,5 @@
>  
>  / {
>  	model = "LogicPD Zoom DM3730 SOM-LV Development Kit";
> -	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap3";
> +	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap36xx", "ti,omap3";
>  };

So just make this:

compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap36xx", "ti,omap3";

And so on. It's fine to use ti,omap3630 for 37xx too as they're the same.

> diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
> index 9a5fde2d9bce..9947574bd0f8 100644
> --- a/arch/arm/boot/dts/omap3-ldp.dts
> +++ b/arch/arm/boot/dts/omap3-ldp.dts
> @@ -10,7 +10,7 @@
>  
>  / {
>  	model = "TI OMAP3430 LDP (Zoom1 Labrador)";
> -	compatible = "ti,omap3-ldp", "ti,omap3";
> +	compatible = "ti,omap3-ldp", "ti,omap34xx, "ti,omap3";

This fails to compile, it's missing a '"' for ti,omap34xx. And here too,
please update to use:

compatible = "ti,omap3-ldp", "ti,omap3430", "ti,omap34xx", "ti,omap3";

And again it's fine to add "ti,omap3430" for 3530 variants.

Regards,

Tony
