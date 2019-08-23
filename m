From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] ti-sysc driver changes for v5.3
Date: Fri, 23 Aug 2019 15:24:41 -0700
Message-ID: <pull-1566599057-142651@atomide.com>
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

The following changes since commit 5b63fb90adb95a178ad403e1703f59bf1ff2c16b:

  ARM: dts: Fix incomplete dts data for am3 and am4 mmc (2019-08-13 04:03:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/ti-sysc-signed

for you to fetch changes up to c8a738f4cfaeccce40b171aca6da5fc45433ce60:

  bus: ti-sysc: remove set but not used variable 'quirks' (2019-08-13 04:40:11 -0700)

----------------------------------------------------------------
Driver changes for ti-sysc for v5.4

Few changes to prepare for using a reset driver for PRM rstctrl mostly
to deal with the clocks for reset. Then few minor clean-up patches and
SPDX license identifier changes, and add a MAINTAINERs file entry.

----------------------------------------------------------------
Suman Anna (4):
      MAINTAINERS: Add ti-sysc files under the OMAP2+ entry
      dt-bindings: ti-sysc: Add SPDX license identifier
      bus: ti-sysc: Switch to SPDX license identifier
      bus: ti-sysc: Add missing kerneldoc comments

Tero Kristo (3):
      bus: ti-sysc: re-order the clkdm control around reset handling
      bus: ti-sysc: rework the reset handling
      bus: ti-sysc: allow reset sharing across devices

YueHaibing (1):
      bus: ti-sysc: remove set but not used variable 'quirks'

 MAINTAINERS                           |  2 ++
 drivers/bus/ti-sysc.c                 | 56 ++++++++++++++---------------------
 include/dt-bindings/bus/ti-sysc.h     |  1 +
 include/linux/platform_data/ti-sysc.h |  7 +++--
 4 files changed, 31 insertions(+), 35 deletions(-)
