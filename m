From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] three fixes for omaps for v5.4
Date: Wed, 23 Oct 2019 09:39:57 -0700
Message-ID: <pull-1571848757-282222@atomide.com>
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
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 17a9e5bbbfe5a5a6356e47cdc1c1656e1e5e1f62:

  Merge tag 'wlcore-fix' into fixes (2019-10-11 09:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/fixes-rc4-signed

for you to fetch changes up to 6aed5a0e0f56213cc5e4bff674fb42e997f30df7:

  Merge branch 'watchdog-fix' into fixes (2019-10-18 08:47:39 -0700)

----------------------------------------------------------------
Three fixes for omaps for v5.4-rc cycle

Two regression fixes for omap3 iommu. I missed applying two omap3
related iommu pdata quirks patches earlier because the kbuild test
robot produced errors on them for missing dependencies.

Fix ti-sysc interconnect target module driver handling for watchdog
quirk. I must have tested this earlier only with watchdog service
running, but clearly it does not do what it needs to do.

----------------------------------------------------------------
Suman Anna (2):
      ARM: OMAP2+: Plug in device_enable/idle ops for IOMMUs
      ARM: OMAP2+: Add pdata for OMAP3 ISP IOMMU

Tony Lindgren (2):
      bus: ti-sysc: Fix watchdog quirk handling
      Merge branch 'watchdog-fix' into fixes

 arch/arm/mach-omap2/pdata-quirks.c | 11 +++++++++++
 drivers/bus/ti-sysc.c              | 18 ++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)
