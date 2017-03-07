From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 0/2] ARM: dts: am335x-icev2: Add support for W25Q64 NOR flash
Date: Tue, 7 Mar 2017 15:57:49 -0600
Message-ID: <20170307215751.29266-1-fcooper@ti.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, tony@atomide.com, robh+dt@kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch set adds support for the on board SPI NOR flash on TI's AM335x
Industrial Communication Engine rev 2.x board.

Franklin S Cooper Jr (1):
  ARM: dts: am335x-icev2: Add SPI based NOR

Sekhar Nori (1):
  doc: dt: mtd: add w25q64 to list of supported SPI flashes

 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  1 +
 arch/arm/boot/dts/am335x-icev2.dts                 | 33 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.10.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
