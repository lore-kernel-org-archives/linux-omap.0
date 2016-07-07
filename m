From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RFC] [PATCH v3 0/4] spi: omap2-mcspi: Use the SPI framework to
 handle DMA mapping
Date: Thu,  7 Jul 2016 12:17:47 -0500
Message-ID: <1467911871-4508-1-git-send-email-fcooper@ti.com>
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
To: tony@atomide.com, robh+dt@kernel.org, broonie@kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, andy.shevchenko@gmail.com, robert.jarzmik@free.fr, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

This patchset switches omap2-mcspi from handling DMA mapping internally to
using the mechanism built into the SPI framework.

However, this is slightly complex since some OMAP SoCs have a quirk that
needs to be handled. In the driver on certain OMAP SOCs if certain
conditions are met the DMA should transfer one or two less elements
when reading from the SPI. The remaining bytes are read in CPU mode.
Sg_split is used to implement this quirk without altering the original
sgl.

Note: The first patch looks to already have been accepted.

V2 changes:
Save page_link value if page_link doesn't point to chained sg_list

v3 changes:
Switch from using custom sg_table clone function to sg_split that already
exist within the kernel.

Franklin S Cooper Jr (4):
  spi: omap2-mcspi: Add comments for RX only DMA buffer workaround
  spi: spi-omap2-mcspi: Select SPI_SPLIT
  spi: omap2-mcspi: Use the SPI framework to handle DMA mapping
  ARM: dts: am335x-icev2: Add SPI based NOR

 arch/arm/boot/dts/am335x-icev2.dts |  39 ++++++++++
 drivers/spi/Kconfig                |   1 +
 drivers/spi/spi-omap2-mcspi.c      | 145 ++++++++++++++++++-------------------
 3 files changed, 109 insertions(+), 76 deletions(-)

-- 
2.7.0
