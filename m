From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 0/7] AM335x Phytec boards update
Date: Fri, 24 May 2019 15:19:56 +0200
Message-ID: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
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
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Schultz <d.schultz@phytec.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hello,

this series adds basic support for phyCORE-AM335x EMMC and
adds device tree for phyBOARD-REGOR AM335x. Also fixes issues
like removing outdated eth phy delay settings and mmc cd active level.

Teresa

Daniel Schultz (1):
  ARM: dts: am335x-phycore-som: Add emmc node

Teresa Remmet (6):
  ARM: dts: am335x phytec boards: Fix cd-gpios active level
  ARM: dts: am335x phytec boards: Remove regulator node
  ARM: dts: am335x-phycore-som: Enable gpmc node in dts files
  ARM: dts: am335x-pcm-953: Update user led names
  ARM: dts: am335x-pcm-953: Remove eth phy delay
  ARM: dts: Add support for phyBOARD-REGOR-AM335x

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-pcm-953.dtsi              |  24 +--
 arch/arm/boot/dts/am335x-phycore-rdk.dts           |   4 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |  47 +++--
 arch/arm/boot/dts/am335x-regor-rdk.dts             |  24 +++
 arch/arm/boot/dts/am335x-regor.dtsi                | 223 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-wega-rdk.dts              |   4 +
 arch/arm/boot/dts/am335x-wega.dtsi                 |  18 +-
 9 files changed, 304 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-regor-rdk.dts
 create mode 100644 arch/arm/boot/dts/am335x-regor.dtsi

-- 
2.7.4
