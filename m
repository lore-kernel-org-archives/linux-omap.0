From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 0/4] cpufreq: Introduce TI CPUFreq/OPP Driver
Date: Fri, 3 Feb 2017 11:29:25 -0600
Message-ID: <20170203172929.23940-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This is v5 of the series to introduce the ti-cpufreq driver
which parses SoC data and provides opp-supported-hw data to the
OPP core in order to enable the proper OPPs for the silicon in use.

History:
v4: http://www.spinics.net/lists/linux-omap/msg134629.html
v3: http://www.spinics.net/lists/linux-omap/msg132733.html
v2: http://www.spinics.net/lists/linux-omap/msg131601.html
v1: http://www.spinics.net/lists/linux-omap/msg129089.html

Very minor changes from v4:
	* In patch 2 change "opp_table0" to "opp_table" in example
	* Add acks on all patches (he approved change in patch 2) from Viresh

DT patches to enable this driver will follow after the DT binding is merged.
Branch for testing, with updated DT nodes, pushed here [1].

Regards,
Dave

[1] https://github.com/dgerlach/linux-pm/commits/upstream/ti-cpufreq-driver-new-v5

Dave Gerlach (4):
  PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
  Documentation: dt: add bindings for ti-cpufreq
  cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
  cpufreq: dt: Don't use generic platdev driver for ti-cpufreq platforms

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 128 ++++++++++
 drivers/base/power/opp/of.c                        |   9 +-
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 -
 drivers/cpufreq/ti-cpufreq.c                       | 272 +++++++++++++++++++++
 include/linux/pm_opp.h                             |   6 +
 7 files changed, 423 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
