From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 3/5] mtd: devices: m25p80: set flag to request memory mapped read
Date: Tue, 28 Jul 2015 14:11:14 +0530
Message-ID: <1438072876-16338-4-git-send-email-vigneshr@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Huang Shijie <b32955@freescale.com>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Set use_mmap_read flag to true, to indicate to spi-master that the
spi-message is from mtd layer. This helps spi-master to do memory
mapped reads over SPI flash memories, when hardware support is
available.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/devices/m25p80.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index d313f948b96c..aac2121c5454 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -148,6 +148,9 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
+	m.spi = spi;
+	m.use_mmap_mode = true;
+
 	spi_sync(spi, &m);
 
 	*retlen = m.actual_length - m25p_cmdsz(nor) - dummy;
-- 
2.4.6
