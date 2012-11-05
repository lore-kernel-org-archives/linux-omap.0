From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/4] pm: Add power off control
Date: Mon, 5 Nov 2012 15:12:25 +0530
Message-ID: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com
Cc: rtc-linux@googlegroups.com, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add PM power_off control to rtc driver, along with this PMIC status
is set to STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC
module.

System power off sequence:-
* Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
* Enable PMIC_POWER_EN in rtc module
* Set rtc ALARM2 time
* Enable ALARM2 interrupt

These patches were tested on AM335x-Bone.

AnilKumar Ch (2):
  ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
  ARM: dts: AM33XX: Enable system power off control in am335x-bone

Colin Foe-Parker (2):
  mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
  rtc: OMAP: Add system pm_power_off to rtc driver

 .../devicetree/bindings/regulator/tps65217.txt     |    4 +
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
 arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
 drivers/mfd/tps65217.c                             |   12 +++
 drivers/rtc/rtc-omap.c                             |   79 +++++++++++++++++++-
 5 files changed, 105 insertions(+), 1 deletion(-)

-- 
1.7.9.5
