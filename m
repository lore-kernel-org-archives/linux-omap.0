From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC v1 0/1] introduce regulator chain locking scheme
Date: Mon, 15 Apr 2013 16:03:34 +0300
Message-ID: <1366031015-17073-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, open list <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark, Liam, All

Our target is to reuse common DVFS framework proposed by Mike Turquette
in http://lwn.net/Articles/540422/ and cpufreq-cpu0.c for all TI SoC and
minimize creation of any TI specific APIs or modules.
The common DVFS framework solution is based on assumption that Regulator,
connected to DVFS FW or CPU0 CPUFreq, is able to change requested voltage for
the corresponding Voltage domain (like CPU/MPU) by itself.
But most of TI SoCs, which support DVFS, have more complex voltage supply
schema as shown below:

  |------------|  |------------|
--| RegulatorY |--| CPU DVFS   |
  |------------|  |------------|
   \           \
    \           \_____________________________
     \                                        \
     |-------------------|  |---------------|  |---------|
   --| RegulatorX (PMIC) |--| Regulator AVS |--| ABB LDO |--
     |-------------------|  |---------------|  |---------|
		/|\				        |					
         |______________________|
         Voltage adjustment

and they need to configure, at least, internal ABB LDO befor/after
reconfiguring external voltage supplier in PMIC.
(as maximum - Regulator AVS (Adaptive voltage scaling) is needed to be
reconfigured after ABB LDO, and Regulator AVS may, finally, reconfigure external
voltage supplier with voltage value which is different from initially requested by DVFS).

for example (Vcur<Vreq):
- DVFS requests voltage change
- AVS converts Vreq to Vreq1 (say calibrated)
- AVS reconfigure RegulatorX (PMIC) to voltage Vreq1
- ABB LDO change type to FBB

This Regulator chaining scema can fit to Regulator framework very well
(from our point of view):
- DVFS: abb->set_voltage(Vreq)
- ABB: if (Vcur<Vreq)
			AVS->set_voltage(Vreq)
- AVS: PMIC->set_voltage(Vreq1)
- ABB: if (Vcur<Vreq)
			change type to FBB

But there are some limitations:
 - the whole Regulator chain need to be locked in case if any part of
   it has been accessed from outside;
 - child regulator should have access to set/get voltage methods of its 
   parent (supplier).

The proposed patches allow to remove these restrictions and they are inspired by
http://lwn.net/Articles/540422/.

Related dicussions:
 - regulator: query on regulator re-entrance 
   http://marc.info/?l=linux-omap&m=136513861315970&w=2
 - clk: notifier handler for dynamic voltage scaling
   https://lkml.org/lkml/2013/2/27/414

Tested on K3.8 OMAP4 SDP/T2 (ABB+vcvp regulator) and
OMAP5 sevm (ABB+smps123(i2c) regulator):
- cpu freq & voltages was scaled.

Could you please review and advise? Does anyone else interested in or have similar problems?

Grygorii Strashko (1):
  regulator: core: introduce regulator chain locking scheme

 drivers/regulator/core.c         |  134 ++++++++++++++++++++++++--------------
 include/linux/regulator/driver.h |    2 +
 2 files changed, 88 insertions(+), 48 deletions(-)

Regards
Grygorii Strashko

Cc: linux-kernel@vger.kernel.org (open list)
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>
-- 
1.7.9.5
