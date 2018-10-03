From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] ti-sysc driver changes for omaps for v4.20
Date: Wed,  3 Oct 2018 10:48:31 -0700
Message-ID: <pull-1538588866-709117@atomide.com>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/ti-sysc-take2-signed

for you to fetch changes up to f5e80203dadc28176f7b5ad2ec00652dd524fb9a:

  bus: ti-sysc: Just use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS (2018-10-01 09:33:28 -0700)

----------------------------------------------------------------
TI sysc driver changes for v4.20 merge window

This series gets rid of the SYSC_QUIRK_RESOURCE_PROVIDER to make device
detection happen mostly only if #define DEBUG is set. Few core devices still
need to be detected to set legacy quirks.

We also add support for booting am335x, am437x and dra7 SoCs with L4 devices
defined in device tree instead of legacy platform data.

And finally we simplify suspend with just SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
and dropping the custom functions that were attempting to work around
issues that really turned out to be child device driver related issues.

Apologies for a late pull request, debugging the suspend issues took a while
and I did not want to send these changes until that got sorted out.

----------------------------------------------------------------
Tony Lindgren (9):
      bus: ti-sysc: Defer suspend as needed
      bus: ti-sysc: Update revision masks to support am437x
      bus: ti-sysc: Detect more devices on am473x for debugging
      bus: ti-sysc: Detect devices on am335x when DEBUG is enabled
      Merge commit '4f3530f4a41d49c41015020cd9a5ed5c95b5d2db' into omap-for-v4.20/ti-sysc
      bus: ti-sysc: Detect timer and gpio on dra7
      bus: ti-sysc: Detect devices for debug on dra7
      bus: ti-sysc: Make some warnings debug only
      bus: ti-sysc: Just use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS

 arch/arm/mach-omap2/omap_hwmod.c      |  39 ++++++-
 drivers/bus/ti-sysc.c                 | 202 +++++++++++-----------------------
 include/linux/platform_data/ti-sysc.h |   1 -
 3 files changed, 100 insertions(+), 142 deletions(-)
