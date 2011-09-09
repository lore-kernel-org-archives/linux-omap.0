From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: [PATCH 0/5] Convert ARM subarchitectures to generic wfi macro.
Date: Fri, 9 Sep 2011 11:42:54 -0400
Message-ID: <20110909154254.GA23810@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Olof Johansson <olof@lixom.net>, linux-tegra@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

And after all that, I forgot to CC Russell on these patches.  Oops.

On 2011-09-09 11:26 -0400, Nick Bowler wrote:
> This series cleans up all remaining ARM subarchitectures that I could
> find to use the generic wfi macro.  As I don't have any of the boards in
> question, I've only compile-tested these patches to the extent that I
> was able.
> 
> See the previous discussion in https://lkml.org/lkml/2011/8/19/433 for
> more background.
> 
> Nick Bowler (5):
>   ARM: realview: Use wfi macro in platform_do_lowpower.
>   ARM: exynos4: Use wfi macro in platform_do_lowpower.
>   ARM: shmobile: Use wfi macro in platform_cpu_die.
>   ARM: tegra: Use wfi macro in platform_do_lowpower.
>   ARM: omap4: Kill private do_wfi macro.
> 
>  arch/arm/mach-exynos4/hotplug.c                 |    9 ++-------
>  arch/arm/mach-omap2/include/mach/omap4-common.h |   11 -----------
>  arch/arm/mach-omap2/omap-hotplug.c              |    7 +++----
>  arch/arm/mach-omap2/pm44xx.c                    |    4 +++-
>  arch/arm/mach-realview/hotplug.c                |    9 ++-------
>  arch/arm/mach-shmobile/hotplug.c                |   10 +++-------
>  arch/arm/mach-tegra/hotplug.c                   |    9 ++-------
>  7 files changed, 15 insertions(+), 44 deletions(-)

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
