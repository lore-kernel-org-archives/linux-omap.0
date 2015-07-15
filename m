From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.2-rc2
Date: Wed, 15 Jul 2015 03:50:53 -0700
Message-ID: <20150715105053.GC17550@atomide.com>
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

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc2-v2

for you to fetch changes up to 9908ac3daa3da2d236b5406b95d0865ddb8b29c4:

  ARM: dts: Correct audio input route & set mic bias for am335x-pepper (2015-07-15 03:03:01 -0700)

----------------------------------------------------------------
Fixes for omaps, all dts changes except for one:

- Fix up LCD panel name for overo boards

- Three fixes for pepper board for regulators, freqeuncy
  scaling and audio input. Note that there is still one
  issue being worked on for booting with multi_v7_defconfig

- Add missing #iommu-cells for omap4 and 5

- Add missing HAVE_ARM_SCU for am43xx

----------------------------------------------------------------
Adam YH Lee (3):
      ARM: dts: omap3: overo: Update LCD panel names
      ARM: dts: configure regulators for Gumstix Pepper
      ARM: dts: Correct audio input route & set mic bias for am335x-pepper

Arun Bharadwaj (1):
      ARM: dts: Fix frequency scaling on Gumstix Pepper

Dave Gerlach (1):
      ARM: OMAP2+: Add HAVE_ARM_SCU for AM43XX

Suman Anna (2):
      ARM: dts: OMAP4: Add #iommu-cells property to IOMMUs
      ARM: dts: OMAP5: Add #iommu-cells property to IOMMUs

 arch/arm/boot/dts/am335x-pepper.dts             | 16 +++++++++++++---
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi |  2 +-
 arch/arm/boot/dts/omap4.dtsi                    |  2 ++
 arch/arm/boot/dts/omap5.dtsi                    |  2 ++
 arch/arm/mach-omap2/Kconfig                     |  1 +
 6 files changed, 20 insertions(+), 5 deletions(-)
