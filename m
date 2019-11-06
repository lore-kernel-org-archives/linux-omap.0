From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 0/5] ARM: dts: dra7: add vpe nodes
Date: Wed, 6 Nov 2019 14:26:17 -0600
Message-ID: <20191106202622.2648-1-bparrot@ti.com>
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
To: Hans Verkuil <hverkuil@xs4all.nl>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch series adds the needed clkctrl and ty-sysc nodes for VPE module.
We also document the VPE DT bindings.

Changes since v2:
- Fix binding spdx license
- Added Rob's ack 

Changes since v1:
- Added a patch to update the compatible in the driver
- Removed unnededed #cell #size properties
- Updated the compatible in dtsi to match binding
- Split off the clk code into its own patch
- Added device specific prefix
- Converted binding to dt schema

Benoit Parrot (5):
  dt-bindings: media: ti-vpe: Document VPE driver
  clk: ti: dra7: add vpe clkctrl data
  ARM: dts: dra7: add vpe clkctrl node
  ARM: dts: dra7: Add ti-sysc node for VPE
  media: ti-vpe: vpe: fix compatible to match bindings

 .../devicetree/bindings/media/ti,vpe.yaml     | 64 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/dra7-l4.dtsi                | 28 +++++++-
 arch/arm/boot/dts/dra7xx-clocks.dtsi          | 18 +++++-
 drivers/clk/ti/clk-7xx.c                      |  6 ++
 drivers/media/platform/ti-vpe/vpe.c           |  2 +-
 include/dt-bindings/clock/dra7.h              | 10 +++
 7 files changed, 123 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,vpe.yaml

-- 
2.17.1
