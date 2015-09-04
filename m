From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/5] mtd: devices: m25p80: add support for mmap read request
Date: Fri, 4 Sep 2015 14:00:00 +0530
Message-ID: <1441355402-6837-4-git-send-email-vigneshr@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>, hramrach@gmail.com
Cc: devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Certain spi controllers may support memory mapped interface to read from
m25p80 type flash devices. This interface provides better read
performance than regular SPI interface.
Call spi_mtd_mmap_read() function, if available, to make use of
memory-mapped interface.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/devices/m25p80.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index d313f948b96c..b8b391aab331 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -133,6 +133,14 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	/* convert the dummy cycles to the number of bytes */
 	dummy /= 8;
 
+	if (spi->master->spi_mtd_mmap_read) {
+		return  spi->master->spi_mtd_mmap_read(spi, from, len,
+						       retlen, buf,
+						       nor->read_opcode,
+						       nor->addr_width,
+						       dummy);
+	}
+
 	spi_message_init(&m);
 	memset(t, 0, (sizeof t));
 
-- 
2.5.1
