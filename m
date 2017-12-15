From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 0/4] PM / OPP: Introduce ti-opp-supply driver
Date: Thu, 14 Dec 2017 22:25:24 -0600
Message-ID: <20171215042528.28715-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,
This is v2 of the series to introduce the ti-opp-supply driver which makes
use of the OPP core to enable multiple regulator DVFS and AVS Class0 for
TI DRA7 and AM57 platforms. Version 1 of this series can be found here [1].

Very few changes since v1, just added Viresh's acks to patches 1 and 2 and
added SPDX license to the ti-opp-supply driver in patch 4.

Pushed updated branch here just in case [2].

Regards,
Dave

[1] https://www.spinics.net/lists/devicetree/msg205957.html
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.15/ti-multireg-support-v2

Dave Gerlach (4):
  cpufreq: ti-cpufreq: Convert to module_platform_driver
  cpufreq: ti-cpufreq: Add support for multiple regulators
  dt-bindings: opp: Introduce ti-opp-supply bindings
  PM / OPP: Add ti-opp-supply driver

 .../bindings/opp/ti-omap5-opp-supply.txt           |  63 +++
 drivers/cpufreq/ti-cpufreq.c                       |  51 ++-
 drivers/opp/Makefile                               |   1 +
 drivers/opp/ti-opp-supply.c                        | 425 +++++++++++++++++++++
 4 files changed, 534 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
 create mode 100644 drivers/opp/ti-opp-supply.c

-- 
2.15.1
