From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 10/10] omap dss clean up for v3.5 merge window
Date: Thu, 10 May 2012 11:39:19 -0700
Message-ID: <E1SSYJI-0006gd-Fa@merlin.infradead.org>
References: <pull-1336675159-747052>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336675159-747052>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-dss-for-v3.5

for you to fetch changes up to 21f787b356279798a002c68d53628755c84168de:

  Merge branch 'for-l-o-3.5' of git://gitorious.org/linux-omap-dss2/linux into cleanup-dss (2012-05-09 08:39:20 -0700)

----------------------------------------------------------------

Clean up for omap DSS board init in preparation for adding DT support.

----------------------------------------------------------------
Tomi Valkeinen (6):
      OMAPDSS: panel-dvi: add PD gpio handling
      OMAP: board-files: remove custom PD GPIO handling for DVI output
      OMAPDSS: TFP410: rename dvi -> tfp410
      OMAPDSS: TFP410: rename dvi files to tfp410
      OMAPDSS: Taal: move reset gpio handling to taal driver
      OMAPDSS: DSI: implement generic DSI pin config

Tony Lindgren (1):
      Merge branch 'for-l-o-3.5' of git://gitorious.org/linux-omap-dss2/linux into cleanup-dss

 arch/arm/mach-omap2/board-3430sdp.c                |   38 +-----
 arch/arm/mach-omap2/board-4430sdp.c                |   37 ++----
 arch/arm/mach-omap2/board-am3517evm.c              |   25 +---
 arch/arm/mach-omap2/board-cm-t35.c                 |   30 +----
 arch/arm/mach-omap2/board-devkit8000.c             |   30 +----
 arch/arm/mach-omap2/board-igep0020.c               |   32 +----
 arch/arm/mach-omap2/board-omap3beagle.c            |   37 +-----
 arch/arm/mach-omap2/board-omap3evm.c               |   29 +----
 arch/arm/mach-omap2/board-omap3stalker.c           |   29 +----
 arch/arm/mach-omap2/board-omap4panda.c             |   39 +-----
 arch/arm/mach-omap2/board-overo.c                  |   25 +---
 drivers/video/omap2/displays/Kconfig               |    8 +-
 drivers/video/omap2/displays/Makefile              |    2 +-
 drivers/video/omap2/displays/panel-taal.c          |   22 ++++
 .../omap2/displays/{panel-dvi.c => panel-tfp410.c} |  134 +++++++++++---------
 drivers/video/omap2/dss/dsi.c                      |  133 +++++++++----------
 include/video/omap-panel-nokia-dsi.h               |    3 +
 .../{omap-panel-dvi.h => omap-panel-tfp410.h}      |   18 ++-
 include/video/omapdss.h                            |   28 ++--
 19 files changed, 251 insertions(+), 448 deletions(-)
 rename drivers/video/omap2/displays/{panel-dvi.c => panel-tfp410.c} (63%)
 rename include/video/{omap-panel-dvi.h => omap-panel-tfp410.h} (63%)
