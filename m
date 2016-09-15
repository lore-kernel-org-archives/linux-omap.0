From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/7] mfd: Fix all W=1 warnings
Date: Thu, 15 Sep 2016 11:45:14 +0100
Message-ID: <20160915104521.14286-1-lee.jones@linaro.org>
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
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

It really is as simple as it sounds!

Lee Jones (7):
  mfd: max8997-irq: 'inline' should be at the beginning of the
    declaration
  mfd: ab8500-debugfs: Prevent initialised field from being over-written
  mfd: db8500-prcmu: Remove unused *prcmu_set_ddr_opp() calls
  mfd: ab8500-debugfs: Remove ab8500_dump_all_banks_to_mem()
  mfd: ab8500-debugfs: Remove 'weak' function
    suspend_test_wake_cause_interrupt_is_mine()
  mfd: omap-usb-host: Return value is not 'const int'
  mfd: cros_ec_spi: Remove unused variable 'request'

 drivers/mfd/ab8500-debugfs.c      | 114 ++++++++------------------------------
 drivers/mfd/cros_ec_spi.c         |   2 -
 drivers/mfd/db8500-prcmu.c        |  19 -------
 drivers/mfd/max8997-irq.c         |   2 +-
 drivers/mfd/omap-usb-host.c       |   2 +-
 include/linux/mfd/abx500/ab8500.h |   2 +
 include/linux/mfd/db8500-prcmu.h  |   6 --
 include/linux/mfd/dbx500-prcmu.h  |   9 ---
 8 files changed, 26 insertions(+), 130 deletions(-)

-- 
2.9.3
