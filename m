From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 3/4] cpufreq: ti: Add cpufreq driver to determine
 available OPPs at runtime
Date: Wed, 18 Jan 2017 08:47:25 +0530
Message-ID: <20170118031725.GC11478@vireshk-i7>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-4-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117131808.29798-4-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 17-01-17, 07:18, Dave Gerlach wrote:
> Some TI SoCs, like those in the AM335x, AM437x, DRA7x, and AM57x families,
> have different OPPs available for the MPU depending on which specific
> variant of the SoC is in use. This can be determined through use of the
> revision and an eFuse register present in the silicon. Introduce a
> ti-cpufreq driver that can read the aformentioned values and provide
> them as version matching data to the opp framework. Through this the
> opp-supported-hw dt binding that is part of the operating-points-v2
> table can be used to indicate availability of OPPs for each device.
> 
> This driver also creates the "cpufreq-dt" platform_device after passing
> the version matching data to the OPP framework so that the cpufreq-dt
> handles the actual cpufreq implementation. Even without the necessary
> data to pass the version matching data the driver will still create this
> device to maintain backwards compatibility with operating-points v1
> tables.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
> 	Update to use simplified binding, only use "syscon" now to pass control
> 	module register space and add offsets to relevant data for each SoC.
> 
>  drivers/cpufreq/Kconfig.arm  |  11 ++
>  drivers/cpufreq/Makefile     |   1 +
>  drivers/cpufreq/ti-cpufreq.c | 272 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 284 insertions(+)
>  create mode 100644 drivers/cpufreq/ti-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
