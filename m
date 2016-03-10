From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v4 0/7] mtd: nand: Fix support for NAND DMA prefetch
Date: Thu, 10 Mar 2016 17:56:36 -0600
Message-ID: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

NAND DMA prefetch has been broken for awhile and seems to have only
worked for SDMA based devices

This patchset fixes DMA prefetch to work on both EDMA and SDMA devices

Test on:
am335x gp evm
am437x gp evm
am37x gp evm

This rev is pretty much the same as v2 which was blocked due to
dependencies to Roger's update GPMC/NAND rework.

This updated rev removes this dependency.

Also it fixes an issue that was introduced when the eDMA driver was
recently updated.

Links to rev 3 patchset:
https://patchwork.ozlabs.org/patch/595631/
https://patchwork.ozlabs.org/patch/595626/
https://patchwork.ozlabs.org/patch/595628/
https://patchwork.ozlabs.org/patch/595630/
https://patchwork.ozlabs.org/patch/595627/
https://patchwork.ozlabs.org/patch/595629/

Links to rev 2 patchset:
https://patchwork.kernel.org/patch/7408691/
https://patchwork.kernel.org/patch/7408681/
https://patchwork.kernel.org/patch/7408661/
https://patchwork.kernel.org/patch/7408641/
https://patchwork.kernel.org/patch/7408621/

Franklin S Cooper Jr (7):
  ARM: OMAP2+: gpmc-nand: Set omap2-nand's parent dev to GPMC dev
  ARM: dts: am33xx: Fix GPMC dma properties
  ARM: dts: am437x: Fix GPMC dma properties
  mtd: nand: omap2: Support parsing dma channel information from DT
  mtd: nand: omap2: Start dma request before enabling prefetch
  mtd: nand: omap2: Fix high memory dma prefetch transfer
  ARM: OMAP2+: Update GPMC and NAND DT binding documentation

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  7 +++++-
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |  2 +-
 arch/arm/boot/dts/am4372.dtsi                      |  2 +-
 arch/arm/mach-omap2/gpmc-nand.c                    | 16 ++++++++++++-
 drivers/mtd/nand/omap2.c                           | 27 +++++++++-------------
 6 files changed, 35 insertions(+), 21 deletions(-)

-- 
2.7.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
