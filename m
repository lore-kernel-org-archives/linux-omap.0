From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/7] thermal: ti-soc-thermal: Migrate slope/offset data to
 device tree
Date: Wed, 1 Mar 2017 15:59:43 +0530
Message-ID: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
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
To: tony@atomide.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently the slope and offset values for calculating the
hot spot temperature of a particular thermal zone is part
of driver data. Pass them here instead and obtain the values
while of node parsing.

Tested for the slope and constant values on DRA7-EVM.

Keerthy (7):
  ARM: DRA7: Thermal: Add slope and offset values
  ARM: OMAP5: Thermal: Add slope and offset values
  ARM: OMAP443x: Thermal: Add slope and offset values
  ARM: OMAP4460: Thermal: Add slope and offset values
  thermal: ti-soc-thermal: Fetch slope and offset from DT
  thermal: ti-soc-thermal: Remove redundant constants
  thermal: ti-soc-thermal: Remove redundant code

 arch/arm/boot/dts/dra7.dtsi                        |  17 +++
 arch/arm/boot/dts/omap443x.dtsi                    |   4 +
 arch/arm/boot/dts/omap4460.dtsi                    |   4 +
 arch/arm/boot/dts/omap5.dtsi                       |   9 ++
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  10 --
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |   4 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   4 -
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 164 ++-------------------
 8 files changed, 45 insertions(+), 171 deletions(-)

-- 
1.9.1
