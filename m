From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 0/4] cpufreq: Introduce TI CPUFreq/OPP Driver
Date: Tue, 17 Jan 2017 07:18:04 -0600
Message-ID: <20170117131808.29798-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This is v4 of the series to introduce the ti-cpufreq driver
which parses SoC data and provides opp-supported-hw data to the
OPP core in order to enable the proper OPPs for the silicon in use.
Based on v4.10-rc4.

History:
v3: http://www.spinics.net/lists/linux-omap/msg132733.html
v2: http://www.spinics.net/lists/linux-omap/msg131601.html
v1: http://www.spinics.net/lists/linux-omap/msg129089.html

This series has two changes from v3:
	* Export dev_pm_opp_of_get_opp_desc_node for modules
	* Simplify the dt binding by just providing a "syscon" phandle and
	  letting the driver handle offsets.
	* Add a patch to remove the automatic platdev creation for am335x
	  and dra7 platforms as this driver will now do it. Note that this 
	  will *not* break existing cpufreq implementations on these platforms
	  as the ti-cpufreq can fall back to opp v1 tables for backwards
	  compatibility.

DT patches to enable this driver will follow after the DT binding is merged.
Finally, branch for testing, with updated DT nodes, pushed here [1].

Regards,
Dave

[1] https://github.com/dgerlach/linux-pm/commits/upstream/ti-cpufreq-driver-new-v4

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

