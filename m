From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 1/3] cpufreq: ti-cpufreq: add support for omap34xx and
 omap36xx
Date: Thu, 5 Sep 2019 07:32:26 -0700
Message-ID: <20190905143226.GW52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]:
> This adds code and tables to read the silicon revision and
> eFuse (speed binned / 720 MHz grade) bits for selecting
> opp-v2 table entries.
> 
> Since these bits are not always part of the syscon register
> range (like for am33xx, am43, dra7), we add code to directly
> read the register values using ioremap() if syscon access fails.

This is nice :) Seems to work for me based on a quick test
on at least omap36xx.

Looks like n900 produces the following though:

core: _opp_supported_by_regulators: OPP minuV: 1270000 maxuV: 1270000, not supported by regulator
cpu cpu0: _opp_add: OPP not supported by regulators (550000000)

But presumably that can be further patched. So for this
patch:

Acked-by: Tony Lindgren <tony@atomide.com>
