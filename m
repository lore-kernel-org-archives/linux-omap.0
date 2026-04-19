Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E815B0EC;
	Sun, 19 Apr 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615670; cv=pass; b=nWeJIiYfWZjrMxhguVsm3wUGJ36gZViSQhiB2dRcDzu6OjxjJRa5NvXIHwyVjwMSI/mniIMAWc4rSn2NjXziHqArOAOpTTRZtPXqrpfVH4Jky65uVMb4fUWwTUM48LI4fVbp2vKi24M5T51XCjEEW7T9AodWTc0AsbzvFhJj0Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615670; c=relaxed/simple;
	bh=ypLXZP0uoQMatmZPXY9s7cHRuiHe/rLoVEu+5IH1yGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy/ZRO3nlYjvDUTX0lgMJM8GyHg1SNKT6hNZznAQyHKZcT18odx8bvJEJZORbQaXdxZykwawc8cy6HMOk3xHLPBYZMn5cxXSTvrfmRNKlAyt4k05jfZQU+mxIXPAzOITN+49ZS/tQed0noF+8JqruLLRVRLoERHTsBuQwDBJRBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=j13Z8/sr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="j13Z8/sr"
Received: from darkstar.. (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzDPt06dMz49QF8;
	Sun, 19 Apr 2026 19:21:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776615666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7XO7FWqgom7KsF2M6YEpOhwdlIoM/d76jegJD5iWQk=;
	b=j13Z8/sr2T+KrAXPl3KsZemAHnbHEEPQGZsUe9tC/oTyUM/omBgGhyiDPEOX4WRd+/ePsx
	cIB0g1KgvhC66GlBQdAvBMOPCdYapT9siR5lP0KUtsBkHo3YUBujpJ4FTFLRvMg1d9r7T/
	A4xBfxzLw3tBlJzBas2YnBmdkcO3sv0lxCwuKnlWrscv7FgsioIXH5wj3rjfZ6eCeauVxm
	R0ct8ir+uUgX4qTTgLU+mtcaGT+NoFs/JTq3KNHL1z0gppAM7GATxIUsT5XNvmpENP6I38
	GeKZx9ViVYbdAO8Qk6VE9MFSMlaFrkeCOPADJR6LL5/HvjaYgC+LQbHSvhCdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776615666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7XO7FWqgom7KsF2M6YEpOhwdlIoM/d76jegJD5iWQk=;
	b=BbutvFAxZ7nU+bt6MNF/xhLWciDL14mdVYlTeERUOghlPkqbSmpxOwo5K4pX2SK6k0lFAN
	V829y5ubbqU33gLGyiMpvTJgBf72sywv7MOOiuFKcmw6Ftq6zV5hT0iravDaR4mnY2g6P1
	8u3L7h17aw+rca5qd3WujfbjBo9w/Z9+3cVPga6Kuq/9jEykLGJBDV/pmhvOWIaeLtWB63
	w2I6+vOyS0kpQ2N8cccKSRYEZynwq+BWoQUA0VTtiJm3rC7bl5qk2Ke8yqH8CYvPGiMREW
	kKbfpUpobVv5SaQhobjCGm2nlFV1XH/Bba9Ej+IQFrLtEfxFMM2O42YtVFfzTA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776615666;
	b=biYK33woq0DJ9deRqyGRjs2IaI395llmvH0j+3dtYwxMTdl1j+IHisC4vWIlcykLiXA3VF
	QpmDle62LE+9VfRzhemc6G1HYKjkh8em/OjT8sTWjO7ZzLf32cGIC3Tl0XM/GELWl7K7TI
	B3er4YkLvtSy1RFkD0W/o0gvNMvpdHVesE3uwpOob8MDReJ+al/smfpw4LcdiKaQ6ohQ2V
	RKKtLf+d34JowPNmzzSo/P6VBDCarO2T5zSPmjuAr9wmTdHwmIGbJYQWaucfiSX8rzucjE
	A913USUCpwC+Z2cETRkaw/GijTY9zuCZvDHHKPuD+QenzrXNmw1KkQDzjm94tw==
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 1/2] Input: ads7846 - restore half-duplex support
Date: Sun, 19 Apr 2026 19:18:47 +0300
Message-ID: <20260419161848.825831-2-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419161848.825831-1-aaro.koskinen@iki.fi>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some boards, the SPI controller is limited to half-duplex and the driver
fails spamming "ads7846 spi2.1: spi_sync --> -22". Restore half-duplex
support with multiple SPI transfers.

Fixes: 9c9509717b53 ("Input: ads7846 - convert to full duplex")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/input/touchscreen/ads7846.c | 168 +++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 0963b1a78a0c..4f8cc450e779 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -134,6 +134,9 @@ struct ads7846 {
 	bool			disabled;	/* P: lock */
 	bool			suspended;	/* P: lock */
 
+	int			(*setup_spi_msg)(struct ads7846 *ts,
+					const struct ads7846_platform_data *pdata);
+	void			(*read_state)(struct ads7846 *ts);
 	int			(*filter)(void *data, int data_idx, int *val);
 	void			*filter_data;
 	int			(*get_pendown_state)(void);
@@ -797,6 +800,22 @@ static int ads7846_filter(struct ads7846 *ts)
 	return 0;
 }
 
+static int ads7846_filter_one(struct ads7846 *ts, unsigned int cmd_idx)
+{
+	struct ads7846_packet *packet = ts->packet;
+	struct ads7846_buf_layout *l = &packet->l[cmd_idx];
+	int action, val;
+
+	val = ads7846_get_value(&packet->rx[l->offset + l->count - 1]);
+	action = ts->filter(ts->filter_data, cmd_idx, &val);
+	if (action == ADS7846_FILTER_REPEAT)
+		return -EAGAIN;
+	else if (action != ADS7846_FILTER_OK)
+		return -EIO;
+	ads7846_set_cmd_val(ts, cmd_idx, val);
+	return 0;
+}
+
 static void ads7846_wait_for_hsync(struct ads7846 *ts)
 {
 	if (ts->wait_for_sync) {
@@ -819,6 +838,45 @@ static void ads7846_wait_for_hsync(struct ads7846 *ts)
 		cpu_relax();
 }
 
+static void ads7846_halfd_read_state(struct ads7846 *ts)
+{
+	struct ads7846_packet *packet = ts->packet;
+	int msg_idx = 0;
+
+	packet->ignore = false;
+
+	while (msg_idx < ts->msg_count) {
+		int error;
+
+		ads7846_wait_for_hsync(ts);
+
+		error = spi_sync(ts->spi, &ts->msg[msg_idx]);
+		if (error) {
+			dev_err_ratelimited(&ts->spi->dev, "spi_sync --> %d\n",
+					    error);
+			packet->ignore = true;
+			return;
+		}
+
+		/*
+		 * Last message is power down request, no need to convert
+		 * or filter the value.
+		 */
+		if (msg_idx == ts->msg_count - 1)
+			break;
+
+		error = ads7846_filter_one(ts, msg_idx);
+		if (error == -EAGAIN) {
+			continue;
+		} else if (error) {
+			packet->ignore = true;
+			msg_idx = ts->msg_count - 1;
+		} else {
+			msg_idx++;
+		}
+	}
+}
+
 static void ads7846_read_state(struct ads7846 *ts)
 {
 	struct ads7846_packet *packet = ts->packet;
@@ -947,7 +1005,7 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
 	while (!ts->stopped && get_pendown_state(ts)) {
 
 		/* pen is down, continue with the measurement */
-		ads7846_read_state(ts);
+		ts->read_state(ts);
 
 		if (!ts->stopped)
 			ads7846_report_state(ts);
@@ -1034,6 +1092,102 @@ static int ads7846_setup_pendown(struct spi_device *spi,
 	return 0;
 }
 
+/*
+ * Set up the transfers to read touchscreen state; this assumes we
+ * use formula #2 for pressure, not #3.
+ */
+static int ads7846_halfd_spi_msg(struct ads7846 *ts,
+				 const struct ads7846_platform_data *pdata)
+{
+	struct spi_message *m = ts->msg;
+	struct spi_transfer *x = ts->xfer;
+	struct ads7846_packet *packet = ts->packet;
+	int vref = pdata->keep_vref_on;
+	unsigned int offset = 0;
+	unsigned int cmd_idx, b;
+	size_t size = 0;
+
+	if (pdata->settle_delay_usecs)
+		packet->count = 2;
+	else
+		packet->count = 1;
+
+	if (ts->model == 7846)
+		packet->cmds = 5; /* x, y, z1, z2, pwdown */
+	else
+		packet->cmds = 3; /* x, y, pwdown */
+
+	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
+		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
+		unsigned int max_count;
+
+		if (cmd_idx == packet->cmds - 1) {
+			cmd_idx = ADS7846_PWDOWN;
+			max_count = 1;
+		} else {
+			max_count = packet->count;
+		}
+
+		l->offset = offset;
+		offset += max_count;
+		l->count = max_count;
+		l->skip = 0;
+		size += sizeof(*packet->rx) * max_count;
+	}
+
+	/* We use two transfers per command. */
+	if (ARRAY_SIZE(ts->xfer) < offset * 2)
+		return -ENOMEM;
+
+	packet->rx = devm_kzalloc(&ts->spi->dev, size, GFP_KERNEL);
+	if (!packet->rx)
+		return -ENOMEM;
+
+	if (ts->model == 7873) {
+		/*
+		 * The AD7873 is almost identical to the ADS7846
+		 * keep VREF off during differential/ratiometric
+		 * conversion modes.
+		 */
+		ts->model = 7846;
+		vref = 0;
+	}
+
+	ts->msg_count = 0;
+
+	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
+		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
+		u8 cmd;
+
+		ts->msg_count++;
+		spi_message_init(m);
+		m->context = ts;
+
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
+		cmd = ads7846_get_cmd(cmd_idx, vref);
+
+		for (b = 0; b < l->count; b++) {
+			packet->rx[l->offset + b].cmd = cmd;
+			x->tx_buf = &packet->rx[l->offset + b].cmd;
+			x->len = 1;
+			spi_message_add_tail(x, m);
+			x++;
+			x->rx_buf = &packet->rx[l->offset + b].data;
+			x->len = 2;
+			if (b < l->count - 1 && l->count > 1) {
+				x->delay.value = pdata->settle_delay_usecs;
+				x->delay.unit = SPI_DELAY_UNIT_USECS;
+			}
+			spi_message_add_tail(x, m);
+			x++;
+		}
+		m++;
+	}
+	return 0;
+}
+
 /*
  * Set up the transfers to read touchscreen state; this assumes we
  * use formula #2 for pressure, not #3.
@@ -1248,6 +1402,14 @@ static int ads7846_probe(struct spi_device *spi)
 	if (!ts)
 		return -ENOMEM;
 
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+		ts->setup_spi_msg = ads7846_halfd_spi_msg;
+		ts->read_state    = ads7846_halfd_read_state;
+	} else {
+		ts->setup_spi_msg = ads7846_setup_spi_msg;
+		ts->read_state    = ads7846_read_state;
+	}
+
 	packet = devm_kzalloc(dev, sizeof(struct ads7846_packet), GFP_KERNEL);
 	if (!packet)
 		return -ENOMEM;
@@ -1342,7 +1504,9 @@ static int ads7846_probe(struct spi_device *spi)
 		ts->core_prop.swap_x_y = true;
 	}
 
-	ads7846_setup_spi_msg(ts, pdata);
+	err = ts->setup_spi_msg(ts, pdata);
+	if (err)
+		return err;
 
 	ts->reg = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(ts->reg)) {
-- 
2.39.2

