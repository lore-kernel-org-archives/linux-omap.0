From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 07/14] mtd: rawnand: ams-delta: Don't hardcode read/write pulse widths
Date: Wed, 12 Feb 2020 01:39:22 +0100
Message-ID: <20200212003929.6682-8-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45511 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgBLAkX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so248778lfa.12
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:22 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

Instead of forcing Amstrad Delta specific read/write pulse widths, use
variables initialised from respective fields of chip SDR timings.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index c7aeb940accd..11689218d23a 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -40,12 +40,14 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_cle;
 	struct gpio_descs	*data_gpiods;
 	bool			data_in;
+	unsigned int		tRP;
+	unsigned int		tWP;
 };
 
 static void ams_delta_write_commit(struct ams_delta_nand *priv)
 {
 	gpiod_set_value(priv->gpiod_nwe, 1);
-	ndelay(40);
+	ndelay(priv->tWP);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 }
 
@@ -82,7 +84,7 @@ static u8 ams_delta_io_read(struct ams_delta_nand *priv)
 	DECLARE_BITMAP(values, BITS_PER_TYPE(res)) = { 0, };
 
 	gpiod_set_value(priv->gpiod_nre, 1);
-	ndelay(40);
+	ndelay(priv->tRP);
 
 	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
 				  data_gpiods->info, values);
@@ -187,8 +189,31 @@ static int ams_delta_exec_op(struct nand_chip *this,
 	return ret;
 }
 
+static int ams_delta_setup_data_interface(struct nand_chip *this, int csline,
+					  const struct nand_data_interface *cf)
+{
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	const struct nand_sdr_timings *sdr = nand_get_sdr_timings(cf);
+	struct device *dev = &nand_to_mtd(this)->dev;
+
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return 0;
+
+	priv->tRP = DIV_ROUND_UP(sdr->tRP_min, 1000);
+	dev_dbg(dev, "using %u ns read pulse width\n", priv->tRP);
+
+	priv->tWP = DIV_ROUND_UP(sdr->tWP_min, 1000);
+	dev_dbg(dev, "using %u ns write pulse width\n", priv->tWP);
+
+	return 0;
+}
+
 static const struct nand_controller_ops ams_delta_ops = {
 	.exec_op = ams_delta_exec_op,
+	.setup_data_interface = ams_delta_setup_data_interface,
 };
 
 /*
-- 
2.24.1
