From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 00/11] Continuing the work on coupled regulators
Date: Fri,  5 Oct 2018 18:36:27 +0300
Message-ID: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

Maciej moved on to work on something else and kindly allowed me to
take over the coupled regulators patches [0] which I'll try to finalize.

I recently started to work on adding DVFS support to the CPUFreq driver
of NVIDIA Tegra20/30 which require the coupled regulators functionality.
Both Tegra20 and Tegra30 have the voltage "max-spread" constraint.
Tegra30 has an additional constraint, the "max-step" voltage.

What is done in this series:

1. Re-worked the original "Add voltage balancing mechanism" patch from
   Maciej by:
        1) Fixing infinite loop within regulator_balance_voltage().
        2) Handling suspend_state_t properly.
        3) Fixing broken compilation of the patch.

2. Added pair of patches to clean up regulator-couple resolving.

3. Changed device tree binding of the regulator-coupled-max-spread property
   to make it more flexible.

4. Added new device tree property, the regulator-max-step-microvolt.

5. Implemented wait/wound mutex which was suggested by Lucas Stach in the
   review comment to [0]. I've tested w/w locking extensively (including
   CONFIG_DEBUG_WW_MUTEX_SLOWPATH) and quite confident that everything is
   okay.

6. Patches were tested with KASAN on Tegra20 / Tegra30, I tried to cover
   various cases and verified that voltage constraints not violated under
   different circumstances.

Please review, thanks.

[0] https://lkml.org/lkml/2018/4/23/619

Dmitry Osipenko (9):
  regulator: core: Mutually resolve regulators coupling
  regulator: core: Don't allow to get regulator until all couples
    resolved
  dt-bindings: regulator: Change regulator-coupled-max-spread property
  regulator: core: Limit regulators coupling to a single couple
  dt-bindings: regulator: Document new regulator-max-step-microvolt
    property
  regulator: core: Add new max_uV_step constraint
  regulator: core: Decouple regulators on regulator_unregister()
  regulator: core: Use ww_mutex for regulators locking
  regulator: core: Properly handle case where supply is the couple

Maciej Purski (2):
  regulator: core: Add voltage balancing mechanism
  regulator: core: Change voltage setting path

 .../bindings/regulator/regulator.txt          |   7 +-
 drivers/regulator/core.c                      | 821 +++++++++++++++---
 drivers/regulator/of_regulator.c              |   4 +
 include/linux/regulator/driver.h              |   5 +-
 include/linux/regulator/machine.h             |   3 +
 5 files changed, 713 insertions(+), 127 deletions(-)

-- 
2.19.0
