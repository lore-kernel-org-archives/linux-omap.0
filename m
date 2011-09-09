From: Nick Bowler <nbowler-7BP4RkwGw0uXmMXjJBpWqg@public.gmane.org>
Subject: [PATCH 0/5] Convert ARM subarchitectures to generic wfi macro.
Date: Fri,  9 Sep 2011 11:26:47 -0400
Message-ID: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series cleans up all remaining ARM subarchitectures that I could
find to use the generic wfi macro.  As I don't have any of the boards in
question, I've only compile-tested these patches to the extent that I
was able.

See the previous discussion in https://lkml.org/lkml/2011/8/19/433 for
more background.

Nick Bowler (5):
  ARM: realview: Use wfi macro in platform_do_lowpower.
  ARM: exynos4: Use wfi macro in platform_do_lowpower.
  ARM: shmobile: Use wfi macro in platform_cpu_die.
  ARM: tegra: Use wfi macro in platform_do_lowpower.
  ARM: omap4: Kill private do_wfi macro.

 arch/arm/mach-exynos4/hotplug.c                 |    9 ++-------
 arch/arm/mach-omap2/include/mach/omap4-common.h |   11 -----------
 arch/arm/mach-omap2/omap-hotplug.c              |    7 +++----
 arch/arm/mach-omap2/pm44xx.c                    |    4 +++-
 arch/arm/mach-realview/hotplug.c                |    9 ++-------
 arch/arm/mach-shmobile/hotplug.c                |   10 +++-------
 arch/arm/mach-tegra/hotplug.c                   |    9 ++-------
 7 files changed, 15 insertions(+), 44 deletions(-)

-- 
1.7.3.4
