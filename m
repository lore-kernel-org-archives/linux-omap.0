From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap non-urgent fixes for v3.20
Date: Fri, 16 Jan 2015 15:21:20 -0800
Message-ID: <10877.9648355723$1421450773@news.gmane.org>
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

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/fixes-not-urgent-pt1

for you to fetch changes up to 13efcb188984f69e1f97b4d9e7d3663fb782946f:

  ARM: OMAP2+: Disable omap3 PM init for ti81xx (2015-01-14 17:37:16 -0800)

----------------------------------------------------------------
Non-urgent fixes for omap variant dm816x that has been in a sorry
broken half merged state for a few years now. This gets us to the
point where we can boot it properly once the related SoC data is
added. Note that we've already made dm816x device tree only by
removing the known broken board file.

----------------------------------------------------------------
Tony Lindgren (6):
      ARM: OMAP2+: Fix error handling for omap2_clk_enable_init_clocks
      ARM: OMAP2+: Fix ti81xx devtype
      ARM: OMAP2+: Fix ti81xx class type
      ARM: OMAP2+: Fix dm814 and dm816 for clocks and timer init
      ARM: OMAP2+: Fix reboot for 81xx
      ARM: OMAP2+: Disable omap3 PM init for ti81xx

 arch/arm/mach-omap2/Makefile                |  1 +
 arch/arm/mach-omap2/clock.c                 |  3 +++
 arch/arm/mach-omap2/common.h                | 11 +++++++++-
 arch/arm/mach-omap2/control.h               |  4 ++++
 arch/arm/mach-omap2/id.c                    |  2 ++
 arch/arm/mach-omap2/io.c                    | 26 +++++++++++++++++-----
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  2 +-
 arch/arm/mach-omap2/prm_common.c            |  4 ++++
 arch/arm/mach-omap2/soc.h                   |  4 ++--
 arch/arm/mach-omap2/ti81xx-restart.c        | 34 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/timer.c                 |  2 ++
 11 files changed, 84 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-omap2/ti81xx-restart.c
