From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 0/4] clk: clk: Add functions to save/restore clock context en-masse
Date: Thu, 21 Jun 2018 13:45:03 +0530
Message-ID: <1529568907-19930-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, sboyd@kernel.org, tony@atomide.com
Cc: linux-clk@vger.kernel.org, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Deep enough power saving mode can result into losing context of the clock
registers also, and they need to be restored once coming back from the power
saving mode. Hence add functions to save/restore clock context.

Tested for DS0 on am437x-gp-evm

Based on top of linux-next

Changes in v2:

        * Renamed clk_dflt_restore to clk_gate_restore_context

Changes in v3: Corrected the e-mail address of linux-omap list

Keerthy (2):
  clk: clk: Add clk_gate_restore_context function
  soc: ti: pm33xx: Save/restore clk context based on enable_off_mode
    setting

Russ Dill (2):
  clk: clk: Add functions to save/restore clock context en-masse
  clk: ti: Add functions to save/restore clk context

 arch/arm/mach-omap2/pm33xx-core.c    |  15 +++++
 drivers/clk/clk.c                    |  93 ++++++++++++++++++++++++++
 drivers/clk/ti/clock.h               |   2 +
 drivers/clk/ti/divider.c             |  36 ++++++++++
 drivers/clk/ti/dpll.c                |   6 ++
 drivers/clk/ti/dpll3xxx.c            | 124 +++++++++++++++++++++++++++++++++++
 drivers/clk/ti/gate.c                |   3 +
 drivers/clk/ti/mux.c                 |  29 ++++++++
 drivers/soc/ti/pm33xx.c              |  13 ++++
 include/linux/clk-provider.h         |   9 +++
 include/linux/clk.h                  |  25 +++++++
 include/linux/clk/ti.h               |   6 ++
 include/linux/platform_data/pm33xx.h |   1 +
 13 files changed, 362 insertions(+)

-- 
1.9.1
