From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 0/4] cpufreq: Introduce TI CPUFreq/OPP Driver
Date: Tue, 7 Feb 2017 10:51:03 -0600
Message-ID: <20170207165107.29394-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lukasz Majewski <lukma@denx.de>
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

