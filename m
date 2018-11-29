From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] driver changes for omaps for v4.21
Date: Thu, 29 Nov 2018 11:57:41 -0800
Message-ID: <pull-1543521343-338334@atomide.com-2>
References: <pull-1543521343-338334@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1543521343-338334@atomide.com>
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/driver-signed

for you to fetch changes up to 3be5e10daf1fc063ec5cff3cd785c4a59814af0b:

  Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver (2018-11-29 11:39:23 -0800)

----------------------------------------------------------------
Driver changes for omaps for v4.21 merge window

Few SoC related driver changes to add PRCM as the wake-up source
for wkup_m3_ipc driver, and to improve ti-sysc driver for dra7
mcasp and device detection when debug is enabled.

There is also a non-critical fix for ti-sysc to fix handling of
the optional clocks but this can wait for the merge window no problem.

----------------------------------------------------------------
Keerthy (1):
      soc: ti: wkup_m3: Add PRCM int16 as the wake up source

Tony Lindgren (4):
      bus: ti-sysc: Fix getting optional clocks in clock_roles
      bus: ti-sysc: Add mcasp optional clocks flag
      bus: ti-sysc: Detect devices for debug on omap5
      Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver

 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 drivers/bus/ti-sysc.c                             | 23 +++++++++++++++++++++--
 drivers/soc/ti/wkup_m3_ipc.c                      |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)
