From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 8/8] ARM: dts: Add OPP-V2 table for AM3517
Date: Mon, 16 Sep 2019 09:26:54 -0700
Message-ID: <20190916162654.GE52127@atomide.com>
References: <cover.1568224032.git.hns@goldelico.com>
 <6089486dcf1f327aa53348f5434cd57cc964c30f.1568224033.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6089486dcf1f327aa53348f5434cd57cc964c30f.1568224033.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
> From: Adam Ford <aford173@gmail.com>
> 
> The AM3517 only lists 600MHz @ 1.2V, but the register values for
> 0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
> of the omap36 which OPPs would be OPP50 (300 MHz) and OPP100
> (600 MHz).
> 
> This patch sets up the OPP50 and OPP100 tables at 300MHz and 600MHz
> for the AM3517 with each having an operating voltage at 1.2V.

Acked-by: Tony Lindgren <tony@atomide.com>
