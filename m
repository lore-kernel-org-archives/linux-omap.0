From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] omap non-critical fixes for v3.9 merge window
Date: Mon, 4 Feb 2013 11:55:46 -0800
Message-ID: <17809.3022005216$1360007795@news.gmane.org>
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
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/fixes-non-critical-signed-v2

for you to fetch changes up to c8d4bafe503ca767bbc8f3c54e4acd344ef26346:

  ARM: OMAP2+: using strlcpy instead of strncpy (2013-02-04 10:17:37 -0800)

----------------------------------------------------------------
Few fixes for v3.9 merge window that are not urgent for
the -rc series.

----------------------------------------------------------------
Chen Gang (2):
      ARM: OMAP: Fix the use of uninitialized dma_lch_count
      ARM: OMAP2+: using strlcpy instead of strncpy

Jon Hunter (1):
      ARM: OMAP2+: Fix selection of clockevent timer when using device-tree

Thomas Gleixner (1):
      ARM: OMAP: make wakeupgen_lock raw

 arch/arm/mach-omap2/omap-wakeupgen.c | 14 +++++++-------
 arch/arm/mach-omap2/timer.c          |  2 +-
 arch/arm/mach-omap2/twl-common.c     |  3 ++-
 arch/arm/plat-omap/dma.c             |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)
