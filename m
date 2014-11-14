From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap soc changes for v3.19
Date: Fri, 14 Nov 2014 13:06:45 -0800
Message-ID: <47860.994100529$1415999314@news.gmane.org>
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

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/clocks-and-pm

for you to fetch changes up to 9889278181bcdbae882664d8cee5bb0e064397e4:

  Merge tag 'for-v3.19/omap-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.19/soc (2014-11-14 10:25:12 -0800)

----------------------------------------------------------------
SoC related changes for omaps. Mostly to make PM easier to use for
omap4 and later, and to fix clock DPLL fixes by adding determine_rate
and set_rate_and_parent.

----------------------------------------------------------------
Felipe Balbi (1):
      ARM: OMAP2+: hwmod: drop unnecessary list initialization

Nishanth Menon (3):
      ARM: OMAP4: PM: Only do static dependency configuration in omap4_init_static_deps
      ARM: OMAP4+: PM: Centralize static dependency mapping table
      ARM: OMAP4+: PM: Program CPU logic power state

Tero Kristo (5):
      ARM: OMAP3: clock: use clk_features flags for omap3 DPLL4 checks
      ARM: OMAP3: clock: add new rate changing logic support for noncore DPLLs
      ARM: OMAP4: clock: add support for determine_rate for omap4 regm4xen DPLL
      ARM: OMAP3: clock: add support for dpll4_set_rate_and_parent
      ARM: OMAP3+: DPLL: use determine_rate() and set_rate_and_parent()

Tony Lindgren (1):
      Merge tag 'for-v3.19/omap-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.19/soc

 arch/arm/mach-omap2/cclock3xxx_data.c     |   6 +
 arch/arm/mach-omap2/clock.c               |   4 +
 arch/arm/mach-omap2/clock.h               |   1 +
 arch/arm/mach-omap2/clock3xxx.c           |  38 ++++++-
 arch/arm/mach-omap2/dpll3xxx.c            | 179 ++++++++++++++++++++----------
 arch/arm/mach-omap2/dpll44xx.c            |  41 +++++++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   4 +-
 arch/arm/mach-omap2/omap_hwmod.c          |   2 -
 arch/arm/mach-omap2/pm44xx.c              | 146 +++++++++++-------------
 drivers/clk/ti/dpll.c                     |  15 +++
 include/linux/clk/ti.h                    |  15 +++
 11 files changed, 307 insertions(+), 144 deletions(-)
