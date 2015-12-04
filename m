From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] Add mmc support for dm814x and dra62x
Date: Thu,  3 Dec 2015 17:25:28 -0800
Message-ID: <1449192335-10137-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

These patches add mmc support for dm814x and dra62x. These patches
depend on what's listed at:

http://marc.info/?l=linux-omap&m=144918431819264&w=2

Regards,

Tony


Tony Lindgren (7):
  ARM: dts: Add pinctrl macros for dm814x
  ARM: dts: Update edma bindings on dm814x to use edma_xbar
  ARM: OMAP2+: Add mmc hwmod entries for dm814x
  ARM: dts: Add mmc device entries for dm814x
  ARM: dts: Add mmc support for dm8148-evm
  ARM: dts: Add mmc support for dra62x j5-eco evm
  ARM: dts: Enable emmc on hp t410

 arch/arm/boot/dts/dm8148-evm.dts           |  31 +++++++++
 arch/arm/boot/dts/dm8148-t410.dts          |  35 ++++++++++
 arch/arm/boot/dts/dm814x.dtsi              | 101 +++++++++++++++++++++++++----
 arch/arm/boot/dts/dra62x-j5eco-evm.dts     |  31 +++++++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  93 +++++++++++++++++++++++---
 include/dt-bindings/pinctrl/dm814x.h       |  48 ++++++++++++++
 include/dt-bindings/pinctrl/omap.h         |   1 +
 7 files changed, 319 insertions(+), 21 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/dm814x.h

-- 
2.6.2
