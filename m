From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] soc changes for omaps for v5.6
Date: Tue,  7 Jan 2020 10:14:16 -0800
Message-ID: <pull-1578420398-290837@atomide.com>
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
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.6/soc-signed

for you to fetch changes up to 4601832f40501efc3c2fd264a5a69bd1ac17d520:

  ARM: OMAP2+: use separate IOMMU pdata to fix DRA7 IPU1 boot (2019-12-17 09:57:09 -0800)

----------------------------------------------------------------
SoC changes for omaps for v5.6 merge window

SoC related changes for omaps that mostly relate to making iommus
to start probing with ti-sysc interconnect target module driver:

- Add missing lcdc clockdomain for am43xx

- Pass auxdata for reset control driver

- Remove old pdata quirks for iommus

- Add workaround for dra7 dsp mstandby errata

- Convert iommu platform code to probe with ti-sysc

- Use sperate iommu auxdata for ipu1

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: am43xx: Add lcdc clockdomain

Suman Anna (2):
      ARM: OMAP2+: Add workaround for DRA7 DSP MStandby errata i879
      ARM: OMAP2+: use separate IOMMU pdata to fix DRA7 IPU1 boot

Tero Kristo (3):
      ARM: OMAP2+: pdata-quirks: add PRM data for reset support
      ARM: OMAP4+: remove pdata quirks for omap4+ iommus
      ARM: OMAP2+: omap-iommu.c conversion to ti-sysc

 arch/arm/mach-omap2/clockdomains43xx_data.c |  10 +++
 arch/arm/mach-omap2/omap-iommu.c            | 128 ++++++++++++++++++++++++----
 arch/arm/mach-omap2/pdata-quirks.c          |  43 +++++++---
 arch/arm/mach-omap2/prcm43xx.h              |   1 +
 4 files changed, 153 insertions(+), 29 deletions(-)
