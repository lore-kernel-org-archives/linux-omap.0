From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.0-rc3
Date: Fri, 17 Jun 2011 04:13:31 -0700
Message-ID: <20110617111330.GD23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git fixes

This set contains regression fixes for PM and pandora board.

Regards,

Tony


The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:
  Linus Torvalds (1):
        Linux 3.0-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git fixes

Grazvydas Ignotas (1):
      omap: pandora: fix NAND support

Kevin Hilman (2):
      OMAP: PM: omap_device: fix device power domain callbacks
      OMAP1: PM: register notifiers with generic clock ops even when !PM_RUNTIME

Russell King (1):
      OMAP: PM debug: fix section mismatch warnings

Tony Lindgren (2):
      Merge branch 'for_3.0/pm-fixes' of ssh://master.kernel.org/.../khilman/linux-omap-pm into fixes
      Merge branch 'fixes-v3.0-rc3' into devel-fixes

 arch/arm/mach-omap1/Makefile             |    4 ++--
 arch/arm/mach-omap1/pm_bus.c             |    8 ++++++--
 arch/arm/mach-omap2/board-omap3pandora.c |    3 ++-
 arch/arm/mach-omap2/pm-debug.c           |    4 ++--
 arch/arm/plat-omap/omap_device.c         |   19 +++++++++++++++++--
 5 files changed, 29 insertions(+), 9 deletions(-)
