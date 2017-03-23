From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: OMAP2+: Add and enable operating-points-v2
Date: Thu, 23 Mar 2017 13:59:51 -0700
Message-ID: <20170323205950.GQ10760@atomide.com>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Lukasz Majewski <lukma@denx.de>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [170306 07:26]:
> Hi,
> This series adds the necessary changes to get proper operating-points-v2 tables
> for AM335x/AM437x/DRA7xx/AM57xx TI SoCs. Doing this enables the ti-cpufreq
> driver and allows the platform to detect which CPU OPPs are valid for the
> configuration in use and enable them.
> 
> This series adds complete tables for am335x and adds 1GHz support for all
> beaglebone black boards and updates the already merged but unused am437x table
> to match the finalized DT bindings. It also moves the existing dra7xx/am57xx
> OPPs to OPPv2 but does not enable 1.5GHz yet as this requires multiregulator
> support which will come at a later date.
> 
> Also, now that so many TI platforms will depend on the ti-cpufreq driver let's
> add CONFIG_ARM_TI_CPUFREQ to omap2plus_defconfig to enable it as part of the
> default configuration.

Applying all for v4.12 into dt-v2 and defconfig branches.

Thanks,

Tony
