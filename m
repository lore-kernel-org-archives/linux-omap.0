From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.15 -rc cycle
Date: Mon, 19 May 2014 17:34:20 -0700
Message-ID: <20140520003419.GA15793@atomide.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/fixes-v3-signed

for you to fetch changes up to 4b353a706a86598ba47307c47301c3c428b79e09:

  ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled (2014-05-19 11:20:38 -0700)

----------------------------------------------------------------
Regression fixes for omaps for NAND, DMA, cpu_idle and audio.
Also a minor one line fix for audio clock on 54xx.

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5 on all OMAP3 platforms

Peter Ujfalusi (1):
      ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM

Roger Quadros (1):
      ARM: OMAP2+: nand: Fix NAND on OMAP2 and OMAP3 boards

Santosh Shilimkar (1):
      ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled

Tony Lindgren (2):
      Merge tag 'for-v3.15-rc/omap-fixes-b' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.15/fixes-v3
      ARM: OMAP2+: Fix DMA hang after off-idle

 arch/arm/mach-omap2/board-flash.c          |  2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c      |  3 ++-
 arch/arm/mach-omap2/cpuidle44xx.c          | 25 +++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  2 +-
 arch/arm/plat-omap/dma.c                   | 10 ++++++++++
 5 files changed, 35 insertions(+), 7 deletions(-)
