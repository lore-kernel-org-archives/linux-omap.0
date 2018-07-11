From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] ti-sysc driver changes for omaps for v4.19
Date: Wed, 11 Jul 2018 06:19:06 -0700
Message-ID: <pull-1531314878-371161@atomide.com-3>
References: <pull-1531314878-371161@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1531314878-371161@atomide.com>
In-Reply-To: <pull-1531314878-371161@atomide.com>
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

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/ti-sysc-v2-signed

for you to fetch changes up to 596e7955692b5d8b042fca500b7a83c25dfcf936:

  bus: ti-sysc: Add support for software reset (2018-07-09 22:31:38 -0700)

----------------------------------------------------------------
ti-sysc driver changes for v4.19 merge window

These changes add support for mcan controller found
on dra7 to probe it with only dts changes with no
need for legacy hwmod platform data. As it depends
on the related clock change, the clock change is
included here and acked by Stephen Boyd.

----------------------------------------------------------------
Faiz Abbas (3):
      clk: ti: dra7: Add clkctrl clock data for the mcan clocks
      bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
      bus: ti-sysc: Add support for software reset

Kees Cook (1):
      bus: ti-sysc: Use 2-factor allocator arguments

 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 drivers/bus/ti-sysc.c                             | 72 +++++++++++++++++++++--
 drivers/clk/ti/clk-7xx.c                          |  1 +
 include/dt-bindings/bus/ti-sysc.h                 |  2 +
 include/dt-bindings/clock/dra7.h                  |  1 +
 include/linux/platform_data/ti-sysc.h             |  1 +
 6 files changed, 74 insertions(+), 4 deletions(-)
