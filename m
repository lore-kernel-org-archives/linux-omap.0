From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: dts: am33xx/dra7xx: Fix cpufreq regression
Date: Wed, 14 Sep 2016 16:32:32 -0700
Message-ID: <20160914233230.xhbzxpscpvb7d6vj@atomide.com>
References: <20160914205717.21975-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160914205717.21975-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [160914 13:57]:
> Hi,
> CPUFreq on am335x and dra7 platforms got broken by two things:
>  - Updated OPPv2 nodes in device tree were merged before driver to
>    handle them was accepted.
>  - OMAP platforms now use the new cpufreq-dt-platdev driver to create
>    cpufreq-dt platform device but non OMAP TI devices were not changed
>    over to this driver.
> 
> This series addresses the first issue listed above by reverting three of
> the dts patches that got merged to restore OPPv1 tables. The second issue
> is addressed by [1].
> 
> With both this series and that patch we will have the existing cpufreq
> support restored on am335x and dra7xx.

OK thanks I've applied these into am335x-cpufreq-regression branch
and merging that into omap-for-v4.9/dt-v2 branch as well. Seems
like no huge rush to get these into v4.8-rc series as nobody has
noticed since May. And we can request these for stable inclusion
after they hit mainline. If there is need to have these in v4.8-rc,
let me know and I'll send a pull request for am335x-cpufreq-regression
separately.

Regards,

Tony

> [1] http://marc.info/?l=linux-pm&m=147388573513082&w=2
> 
> Dave Gerlach (3):
>   Revert "ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu"
>   Revert "ARM: dts: am33xx: Move to operating-points-v2 table and
>     ti-cpufreq driver"
>   Revert "ARM: dts: dra7: Move to operating-points-v2 table"
> 
>  arch/arm/boot/dts/am335x-boneblack.dts | 11 -----
>  arch/arm/boot/dts/am33xx.dtsi          | 88 +++++-----------------------------
>  arch/arm/boot/dts/dra7.dtsi            | 26 ++--------
>  arch/arm/boot/dts/dra74x.dtsi          |  1 -
>  4 files changed, 18 insertions(+), 108 deletions(-)
> 
> -- 
> 2.9.3
> 
