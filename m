From: Roger Quadros <rogerq@ti.com>
Subject: [GIT PULL] omap-gpmc changes for v4.9 merge window
Date: Mon, 29 Aug 2016 11:30:34 +0300
Message-ID: <16b618d9-735f-f20c-7966-6e3d23b6b44e@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Olof/Arnd,

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.9

for you to fetch changes up to 3950fffdf0c088dd4d9e85c9a5a6be4c6e8b5a07:

  memory: omap-gpmc: make gpmc_clk_ticks_to_ns() static (2016-08-29 11:00:24 +0300)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.9

* Fix potential build failure if CONFIG_OMAP_GPMC is disabled while
  OMAP_NAND driver is enabled
* Trivial fixes which fix build warnings and code check tool warnings
  (Coccinelle)
* Use devm_gpiochip_add_data()

----------------------------------------------------------------
Baoyou Xie (1):
      memory: omap-gpmc: make gpmc_clk_ticks_to_ns() static

Linus Walleij (1):
      memory: omap-gpmc: use devm_gpiochip_add_data()

Markus Elfring (1):
      memory: omap-gpmc: Delete an unnecessary check before the function call "gpiochip_free_own_desc"

Roger Quadros (1):
      memory: omap-gpmc: Fix build with CONFIG_OMAP_GPMC disabled

 drivers/memory/omap-gpmc.c | 20 +++++---------------
 include/linux/omap-gpmc.h  |  4 ++--
 2 files changed, 7 insertions(+), 17 deletions(-)

--
cheers,
-roger
