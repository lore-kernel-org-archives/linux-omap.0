From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] omap defconfig changes for v4.6 merge window
Date: Tue,  1 Mar 2016 15:01:20 -0800
Message-ID: <48796.213445212$1456873342@news.gmane.org>
References: <pull-1456872971-400983>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1456872971-400983>
In-Reply-To: <pull-1456872971-400983>
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

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/defconfig-signed

for you to fetch changes up to 4e550018df068f6b14d36c72c723a507240f6456:

  ARM: multi_v7_defconfig: Enable LP872x regulator support (2016-02-29 14:58:01 -0800)

----------------------------------------------------------------
Defconfig changes for omap2plus_defconfig and multi_v7_defconfig
for v4.6 merge window:

- Enable IOMMU and omap3isp so we can enable TVP5150/1 video
  decoder

- Enable at24 eeprom for revision detection on beagle-x15

- Enable LP872x regulator for both omap2plus_defconfig and
  multi_v7_defconfig as it's needed at least by LG Optimus
  Black

----------------------------------------------------------------
Javier Martinez Canillas (3):
      ARM: omap2plus_defconfig: Enable OMAP IOMMU support
      ARM: omap2plus_defconfig: Enable ISP support and dependencies
      ARM: omap2plus_defconfig: Enable TI TVP5150 video decoder support

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable AT24 eeprom

Paul Kocialkowski (2):
      ARM: omap2plus_defconfig: Enable LP872x regulator support
      ARM: multi_v7_defconfig: Enable LP872x regulator support

 arch/arm/configs/multi_v7_defconfig  |  1 +
 arch/arm/configs/omap2plus_defconfig | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)
