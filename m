From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM: OMAP1/OMAP2+: Add dma_slave_map to board files
Date: Tue, 2 Feb 2016 16:27:05 +0200
Message-ID: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
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
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi,

The following series adds the dma_slave map to the sDMA (omap-dma) driver. The
dma_slave_map is needed later when we convert drivers to use the new dmaengine
API for requesting slave channels.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP1: DMA: Provide dma_slave_map to omap-dma
  ARM: OMAP2+: DMA: Provide dma_slave_map to omap-dma for legacy boot

 arch/arm/mach-omap1/dma.c |  45 ++++++++++++++++++
 arch/arm/mach-omap2/dma.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)

-- 
2.7.0
