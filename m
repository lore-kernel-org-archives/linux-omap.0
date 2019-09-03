From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC 2/5] ARM: dts: add support for opp-v2 for omap34xx and
 omap36xx
Date: Tue, 3 Sep 2019 08:08:05 +0530
Message-ID: <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> +		opp1-125000000 {
> +			opp-hz = /bits/ 64 <125000000>;
> +			// we currently only select the max voltage from table Table 3-3 of the omap3530 Data sheet (SPRS507F)
> +			// <target min max> could also be single <target>
> +			opp-microvolt = <975000 975000 975000>;
> +			// first value is silicon revision, second one 720MHz Device Identification

> +			opp-supported-hw = <0xffffffff 3>;

I don't see the driver changes using this field, am I missing
something ?

-- 
viresh
