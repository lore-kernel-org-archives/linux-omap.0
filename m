From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: AM43x: Support DDR HW leveling suspend/resume
Date: Tue, 2 Apr 2019 11:57:41 -0500
Message-ID: <20190402165743.28106-1-d-gerlach@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, Brad Griffis <bgriffis@ti.com>, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
These patches add support for resuming am437x SoCs from suspend to mem when
using hardware leveling (as configured by u-boot). This series has no effect
on boards not currently using hardware leveling (am437x-gp-evm, am437x-sk-evm)
but is required for any board that is using it (am437x-idk-evm) for resume to
work at all, so this increases support for boards without affecting those that
currently work.

This series adds a ti_emif_run_hw_leveling call that is loaded to SRAM so that
it can be run from low-level PM code during the resume path that attempts to
trigger the HW leveling sequence just as was done in u-boot after all previously
register values have been restored, which leads to a fully restored DDR
configuration.

These patches have been tested on am437x-gp-evm and am437x-sk-evm and showed
no noticeable change in behavior (including resume time) and also tested on
am437x-idk-evm which showed a working suspend to mem followed by resume, which
did not previously work.

Regards,
Dave

Dave Gerlach (2):
  memory: ti-emif-sram: Add ti_emif_run_hw_leveling for DDR3 hardware
    leveling
  ARM: OMAP2+: sleep43xx: Run EMIF HW leveling on resume path

 arch/arm/mach-omap2/sleep43xx.S  |  3 +++
 drivers/memory/emif.h            |  4 ++++
 drivers/memory/ti-emif-pm.c      |  3 +++
 drivers/memory/ti-emif-sram-pm.S | 41 ++++++++++++++++++++++++++++++++
 include/linux/ti-emif-sram.h     |  3 +++
 5 files changed, 54 insertions(+)

-- 
2.20.1
