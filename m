From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap1 gpio clean-up for v4.20
Date: Wed, 26 Sep 2018 10:40:44 -0700
Message-ID: <pull-1537983432-167273@atomide.com-2>
References: <pull-1537983432-167273@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1537983432-167273@atomide.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/omap1-signed

for you to fetch changes up to 1137ceee76ba8b8c698e11b7150e35524f071bda:

  ARM: OMAP1: ams-delta: Don't request unused GPIOs (2018-09-20 14:24:42 -0700)

----------------------------------------------------------------
A series of omap1 gpio changes for ams-delta

Janusz Krzysztofik has cleaned up ams-delta gpio usage along with
generic gpio framework improvments. This series contains the omap1
specific clean-up for ams-delta modem and unused gpios.

Note that this conflicts with the gpio-omap changes queued into
an immutable gpio branch ib-omap for the gpio-omap.h header file.
The merge resolution is to drop the IS_BUILTIN(CONFIG_GPIO_OMAP)
section and keep the #endif tagged for __ASSEMBLER__.

----------------------------------------------------------------
Janusz Krzysztofik (5):
      ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
      ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
      ARM: OMAP1: ams-delta: register MODEM device earlier
      ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-omap.h>
      ARM: OMAP1: ams-delta: Don't request unused GPIOs

 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |  12 +-
 arch/arm/mach-omap1/board-ams-delta.c              | 161 ++++++++++++---------
 arch/arm/mach-omap1/include/mach/board-ams-delta.h |   7 -
 include/linux/platform_data/gpio-omap.h            |   4 +
 4 files changed, 96 insertions(+), 88 deletions(-)
