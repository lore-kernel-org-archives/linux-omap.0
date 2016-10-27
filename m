From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 0/3] cpufreq: Introduce TI CPUFreq/OPP Driver
Date: Thu, 27 Oct 2016 16:41:28 -0500
Message-ID: <20161027214131.1725-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This series is v3 of the series to introduce the ti-cpufreq driver
which parses SoC data and provides opp-supported-hw data to the
OPP core in order to enable the proper OPPs for the silicon in use.
v2 of this series can be found here [1].

Several changes to the dt-binding and ti-cpufreq driver are
present in v3, which are described in detail under scissors line
in patches but mostly focused on moving properties that were added
in cpu node previously to the operating-points node and updating
driver to reflect these changes, along with using a common compatible
for all ti platforms. Also, a new patch was added to expose an internal
OPP core API to allow a common way to get a reference to the OPP table
from a platform driver.

I have just sent the driver and binding here but have held off on the
updated DT nodes, I will send these out once we can agree on the binding
and driver changes but have pushed them if anyone is curious here [2].

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg131601.html
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.9/ti-cpufreq-driver-v3

Dave Gerlach (3):
  PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
  Documentation: dt: add bindings for ti-cpufreq
  cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 132 ++++++++++
 drivers/base/power/opp/of.c                        |   8 +-
 drivers/base/power/opp/opp.h                       |   1 -
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/ti-cpufreq.c                       | 288 +++++++++++++++++++++
 include/linux/pm_opp.h                             |   6 +
 7 files changed, 442 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

-- 
2.9.3

