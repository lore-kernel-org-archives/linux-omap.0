From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] three fixes for omaps
Date: Wed, 12 Jun 2019 00:18:39 -0700
Message-ID: <pull-1560323885-602179@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 4ee23cd76c0ce8622976b3da0e2bc89e6d94f6d4:

  Merge branch 'omap-for-v5.2/ti-sysc' into fixes (2019-05-20 08:33:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/fixes-rc4

for you to fetch changes up to 8a0098c05a272c9a68f6885e09755755b612459c:

  ARM: dts: am335x phytec boards: Fix cd-gpios active level (2019-06-10 00:06:57 -0700)

----------------------------------------------------------------
Fixes for omap variants

Three fixes mostly for dra7 SoC variants that have some devices disabled
compared to the base SoC. These got broken by the change of making devices
probe with ti-sysc interconnect target module and went unnnoticed for a
while. And there is no clkcel bit for timer12 unlike timer1. Also included
is a GPIO direction fix for phytec SDIO card detection.

----------------------------------------------------------------
Keerthy (1):
      ARM: dts: dra72x: Disable usb4_tm target module

Teresa Remmet (1):
      ARM: dts: am335x phytec boards: Fix cd-gpios active level

Tony Lindgren (1):
      ARM: dts: Drop bogus CLKSEL for timer12 on dra7

 arch/arm/boot/dts/am335x-pcm-953.dtsi | 2 +-
 arch/arm/boot/dts/am335x-wega.dtsi    | 2 +-
 arch/arm/boot/dts/dra7-l4.dtsi        | 2 --
 arch/arm/boot/dts/dra72x.dtsi         | 4 ++++
 4 files changed, 6 insertions(+), 4 deletions(-)
