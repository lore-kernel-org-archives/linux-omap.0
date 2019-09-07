From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: dts: replace opp-v1 tables by opp-v2 for
 omap34xx and omap36xx
Date: Sat, 7 Sep 2019 10:08:50 -0700
Message-ID: <20190907170850.GI52127@atomide.com>
References: <cover.1567839375.git.hns@goldelico.com>
 <326e1bfe9e7c04346b4fcc0386303d7f93d0ba77.1567839375.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <326e1bfe9e7c04346b4fcc0386303d7f93d0ba77.1567839375.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190907 06:57]:
> In addition, move omap3 from whitelist to blacklist in cpufreq-dt-platdev
> in the same patch, because doing either first breaks operation and
> may make trouble in bisect.
> 
> We also can remove opp-v1 table for omap3-n950-n9 since it is now
> automatically detected.
> 
> We also fix a wrong OPP4 voltage for omap3430 which must be
> 0.6V + 54*12.5mV = 1275mV. Otherwise the twl4030 driver will reject
> this OPP.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Acked-by: Tony Lindgren <tony@atomide.com>
