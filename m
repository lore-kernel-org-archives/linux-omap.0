From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/4] PM / OPP: Introduce ti-opp-supply driver
Date: Wed, 13 Dec 2017 14:33:54 -0600
Message-ID: <20171213203358.20839-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Some SoCs, such as Texas Instruments DRA7 family, have complex requirements for
scaling voltages and supplies when doing things like DVFS. For example, for
cpufreq on dra7xx, the cpu-supply must be scaled as is normally done however
there is also an Adaptive Body Bias (ABB) regulator that should be scaled at
the same time as the main supply in sequence depending on the transition,
explained earlier by Nishanth Menon here [1]. In addition to this, each
possible operating point has a corresponding optimized voltage value stored in
a register (Adaptive Voltage Scaling Class 0) that can be used instead of the
nominal value.

The OPP framework is now able to to handle DVFS transitions through the
provided dev_pm_opp_set_rate API and cpufreq-dt is doing this. Viresh Kumar
extended this to allow platforms to register a transition helper through the
use of dev_pm_opp_register_set_opp_helper and has also extended the OPP core to
support registering multiple regulators. By providing a TI platform specific
opp_helper function and registering the proepr regulators with the OPP core we
can meet the above requirements for properly changing DVFS state of the cpu
device.

This series introduces a ti-opp-supply driver that overrides the standard
single regulator DVFS transition handler to handle scaling the ABB regulator in
sequence with the normal supply and programing AVS voltages through a custom
opp_helper that is registered. The ti-cpufreq driver is extended to allow
registering the proper regulators needed for the CPU if the platform supports
multi regulators and is also changed to a regular driver so that it can defer
probe if needed as it now may have to if the regulators are not ready.

This series only contains driver changes and binding docs, DT patches will be
sent later but I have pushed them all here for anyone curious [2].

This series is required to enable the highest 1.5GHz OPP on dra7/am57 platforms
that support it but all dra7/am57 platforms will make use of this for all OPPs.

Regards,
Dave

[1] https://marc.info/?l=linux-pm&m=145684495832764&w=2
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.15/ti-multireg-support

Dave Gerlach (4):
  cpufreq: ti-cpufreq: Convert to module_platform_driver
  cpufreq: ti-cpufreq: Add support for multiple regulators
  dt-bindings: opp: Introduce ti-opp-supply bindings
  PM / OPP: Add ti-opp-supply driver

 .../bindings/opp/ti-omap5-opp-supply.txt           |  63 +++
 drivers/cpufreq/ti-cpufreq.c                       |  51 ++-
 drivers/opp/Makefile                               |   1 +
 drivers/opp/ti-opp-supply.c                        | 428 +++++++++++++++++++++
 4 files changed, 537 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
 create mode 100644 drivers/opp/ti-opp-supply.c

-- 
2.15.1
