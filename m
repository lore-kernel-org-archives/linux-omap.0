From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 0/6] ARM: dts: phyBOARD-WEGA-AM335x updates
Date: Thu, 5 Jan 2017 15:50:45 +0100
Message-ID: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
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
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Set of small patches to update the device tree of the
phyCORE-AM335x SOM and phyBOARD-WEGA-AM335x.

Teresa Remmet (6):
  ARM: dts: am335x-phycore-som: Update NAND partition table
  ARM: dts: am335x-phycore-som: Update compatible string for spi nor
  ARM: dts: am335x-phycore-som: Add i2c temp sensor
  ARM: dts: am335x-wega: Set USB0 mode to otg
  ARM: dts: am335x-phycore-som: Update ethernet phy node
  ARM: dts: am335x-wega: Update ethernet phy node

 arch/arm/boot/dts/am335x-phycore-som.dtsi | 30 +++++++++++++++++++-----------
 arch/arm/boot/dts/am335x-wega.dtsi        |  9 +++++++--
 2 files changed, 26 insertions(+), 13 deletions(-)

-- 
1.9.1
