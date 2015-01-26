From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap non-urgent fixes for v3.20, part 2
Date: Mon, 26 Jan 2015 13:08:18 -0800
Message-ID: <11103.9744959728$1422306791@news.gmane.org>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 13efcb188984f69e1f97b4d9e7d3663fb782946f:

  ARM: OMAP2+: Disable omap3 PM init for ti81xx (2015-01-14 17:37:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/fixes-not-urgent-pt2

for you to fetch changes up to 20d9448a59770420ead8078fb76948de32765fe6:

  Merge tag 'for-v3.20/omap-hwmod-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.20/fixes-not-urgent (2015-01-21 16:52:17 -0800)

----------------------------------------------------------------
Non-critical fixes for omap hwmod code via Paul Walmsley <paul@pwsan.com>:

First set of OMAP2+ hwmod patches for Linux v3.20.  These are mostly
fixes for warnings, although there's one DRA7xx patch that fixes
CONFIG_DEBUG_LL for AM572x/DRA7xx SoCs that use UART3 for console,
such as the BeagleBoard-X15.

These patches entered Linux-next starting with the next-20150121 tag.

Basic build, boot, and PM test results can be found here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v3.20/20150121142621/

----------------------------------------------------------------
Keerthy (1):
      ARM: OMAP: DRA7: hwmod: Make gpmc software supervised as the smart idle is broken

Lokesh Vutla (2):
      ARM: OMAP2+: hwmod: print error if wait_target_ready() failed
      ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL enabled on UART3

Paul Walmsley (1):
      MAINTAINERS: add maintainer for OMAP hwmod data

Tomi Valkeinen (1):
      ARM: AM43xx: hwmod: set DSS submodule parent hwmods

Tony Lindgren (1):
      Merge tag 'for-v3.20/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.20/fixes-not-urgent

 MAINTAINERS                                | 6 ++++++
 arch/arm/mach-omap2/omap_hwmod.c           | 4 ++--
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 5 +++--
 4 files changed, 13 insertions(+), 4 deletions(-)
