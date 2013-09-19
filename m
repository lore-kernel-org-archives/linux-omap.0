From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/3] PM / OPP: rename to dev_pm_opp * equivalents
Date: Thu, 19 Sep 2013 16:14:09 -0500
Message-ID: <20130919211409.GA17419@kahuna>
References: <1379624632-17356-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1379624632-17356-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-omap@vger.kernel.org

On 16:03-20130919, Nishanth Menon wrote:
> Hi,
> 
> Based on [1], Randy rightly pointed out that OPP functions and data
> structures could be a bit specific to Power management.
> 
> So, the following series is based on v3.12-rc1 tag.
> 
> If folks like it broken in a different way, I am open to suggestions.
> 
> Nishanth Menon (3):
>   PM / OPP: rename functions to dev_pm_opp*
>   PM / OPP: rename data structures to dev_pm equivalents
>   PM / OPP: rename header to linux/pm_opp.h
> 
>  Documentation/power/opp.txt             |  108 ++++++++++++------------
>  arch/arm/mach-imx/mach-imx6q.c          |    4 +-
>  arch/arm/mach-omap2/board-omap3beagle.c |   10 +--
>  arch/arm/mach-omap2/omap-pm.h           |    2 +-
>  arch/arm/mach-omap2/opp.c               |    6 +-
>  arch/arm/mach-omap2/pm.c                |    8 +-
>  drivers/base/power/opp.c                |  115 ++++++++++++-------------
>  drivers/cpufreq/arm_big_little.c        |    8 +-
>  drivers/cpufreq/arm_big_little_dt.c     |    2 +-
>  drivers/cpufreq/cpufreq-cpu0.c          |   24 +++---
>  drivers/cpufreq/exynos5440-cpufreq.c    |   17 ++--
>  drivers/cpufreq/imx6q-cpufreq.c         |   26 +++---
>  drivers/cpufreq/omap-cpufreq.c          |   12 +--
>  drivers/devfreq/devfreq.c               |   25 +++---
>  drivers/devfreq/exynos/exynos4_bus.c    |   29 +++----
>  drivers/devfreq/exynos/exynos5_bus.c    |   28 +++----
>  include/linux/devfreq.h                 |    6 +-
>  include/linux/opp.h                     |  134 -----------------------------
>  include/linux/pm_opp.h                  |  139 +++++++++++++++++++++++++++++++
>  19 files changed, 357 insertions(+), 346 deletions(-)
>  delete mode 100644 include/linux/opp.h
>  create mode 100644 include/linux/pm_opp.h
> 
> -- 
> 1.7.9.5
> 
Oops.. seems I deleted the link of the discussion - my bad...
[1] http://marc.info/?t=137579467400007&r=1&w=2
-- 
Regards,
Nishanth Menon
