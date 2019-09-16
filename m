From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/8] cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if
 run in multi_regulator mode
Date: Mon, 16 Sep 2019 09:24:49 -0700
Message-ID: <20190916162449.GB52127@atomide.com>
References: <cover.1568224032.git.hns@goldelico.com>
 <1c803be8060fb99b7d92e2f5cde3c0e1962fbe2b.1568224033.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c803be8060fb99b7d92e2f5cde3c0e1962fbe2b.1568224033.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
> In preparation for using the multi_regulator capability of
> this driver for handling the ABB LDO for OPP1G of the omap36xx
> we have to take care that the (legacy) vdd-supply name is
> cpu0-supply = <&vcc>;
> 
> To do this we add another field to the SoC description table which
> optionally can specify a list of regulator names.
> 
> For omap36xx we define "cpu0-supply" and "vbb-supply".
> 
> The default remains "vdd-supply" and "vbb-supply".

Acked-by: Tony Lindgren <tony@atomide.com>
