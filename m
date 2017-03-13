From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/4] ARM: dm8168-evm: add SATA support
Date: Mon, 13 Mar 2017 17:43:15 +0100
Message-ID: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
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
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series implements support for the on-board SATA controller
on the dm8168-evm board.

The first patch adds the clock domain and hwmod entries for the
SATA module.

The second patch models the external reference clock used by SATA.

The third adds the SATA node to the SoC's device tree.

The fourth enables the SATA driver by default in omap2plus_defconfig.

Bartosz Golaszewski (3):
  ARM: dts: dm8168-evm: add the external reference clock for SATA
  ARM: dts: dm8168-evm: add SATA node
  ARM: omap2plus_defconfig: enable ahci-dm816 module

Kevin Hilman (1):
  ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA

 arch/arm/boot/dts/dm8168-evm.dts            | 10 +++++++++
 arch/arm/boot/dts/dm816x.dtsi               |  7 ++++++
 arch/arm/configs/omap2plus_defconfig        |  1 +
 arch/arm/mach-omap2/clockdomains81xx_data.c | 10 +++++++++
 arch/arm/mach-omap2/cm81xx.h                |  2 ++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 34 +++++++++++++++++++++++++++++
 6 files changed, 64 insertions(+)

-- 
2.9.3
