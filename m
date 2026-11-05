Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876617;
	b=3d+ukuwvElMRM7+pQHwMPE0hGHRKnHtXEY4weIIPspnZtvkg8pESV3+Q7uCAg3x4x9Qr
	 2688FCVicuy8cEN7Nl4zBk/T0V+enupiyjpPuXTZA1mwMDvZhxX761422Mpdp1FFd1L1P
	 ZtZfD/RVKLBANCXw5S9xUEF4bw8NXj0r8vaSxacPAgBF57QGWAq3toKpeQ9ccWUpiQNdE
	 JkToIb3kvPnA+QIbE8AcnWjuCFwkhGzxE14JI2eT3N+kDCiO4zBLZLDFnnfhdpqhdT5Sg
	 rt7deCK8DSxYk9vVeK/olZk4G58ZHFrTtY2UCIKm87SPLSuDfnwGSPqkG0eghsC7uVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876617;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JNvALpT1uFvsDbmqg8UiSN7+IohS87cUGwq/ZbxvL34=;
	b=2T/yEihC0gpcE2oVyvLUmzxNIu5WycWS8pmOwXA2Bu2FqLAKIBTETf4+oJGEtKf04CTg
	 DksGz2/UPFPdds2vrDs6atLtk9wbHkRnD6VeDuLHBeU5TgWoQMfNTiWxY4p3e++/qRbZk
	 5L+gL8OEMnbrivtUEHWnK5BNIzPI5+up8coJeimsA7hMrNCtvByVpl9mE8DajS7meaIzY
	 QioxZgpXOa7f+zdkk0UiqfsyqT56JyjQmHf7NPMI298NHxtO6xN8jf4bzooD3biHsz9Sx
	 Yikq3hByWewB+1Ebzvyq58RkiymgIUBAEpbW79ThFLtWXDDt/4wjZnUWeX/GUPIlzWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUC1KbMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF18606A328;
	Thu,  5 Nov 2026 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUC1KbMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A73D1F000C1;
	Thu,  5 Nov 2026 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876617;
	bh=JNvALpT1uFvsDbmqg8UiSN7+IohS87cUGwq/ZbxvL34=;
	h=From:To:Subject:Date;
	b=RUC1KbMdyytAt3+IB3RWXLI1jEttxjzGOfwM/zJLoThdoZhKDawLWQjrIOjE48ST/
	 iL9dWchK/QOKsCWnI9MySXRYRA3eeo97NWL0h4i0nB/SAr9dPGAbZuo05NhmP5rX4V
	 KvlP3BkY2AJZcDzqf0t/E1OuO/ZdgbTM25lm6ADauhw0IHGpJQKE3sT+LGL3p1e7EV
	 yfbS/TMdUJzKmv78wtAWYPMoM3EZ9aY8tPzfKZfpbnxLgTCcoUvdXToIyoaZuPG7Wb
	 306Hl8ZK66s0DdY306/NIxk0Mev58oyOnTVv8quOGA/P/pVH5hbW0q6xAupwXiWVCo
	 80jnkLXHW8TZA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Myeonghun Pak <mhun512@gmail.com>,
	Kai Svahn <kai.svahn@nokia.com>,
	syed khasim <x0khasim@ti.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: twl-core: Reset twl_priv using devm_add_action_or_reset()
Date: Thu,  5 Nov 2026 11:03:23 +0000
Message-ID: <20261105110332.1874728-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register a devres cleanup action immediately after allocating twl_priv
with devm_kzalloc() so that twl_priv is automatically reset to NULL just
before its underlying memory is released on probe failure or driver
unbind.  This removes the need to manually clear twl_priv in both
twl_remove() and the probe error unwind path.

Suggested-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/twl-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 21fc0acb827b..6077a87282f5 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -711,7 +711,6 @@ static void twl_remove(struct i2c_client *client)
 		twl->client = NULL;
 	}
 	twl_priv->ready = false;
-	twl_priv = NULL;
 }
 
 
@@ -728,6 +727,11 @@ static const struct mfd_cell twl6032_cells[] = {
 	{ .name = "twl6032-clk" },
 };
 
+static void twl_reset_priv(void *data)
+{
+	twl_priv = NULL;
+}
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client)
@@ -776,6 +780,10 @@ twl_probe(struct i2c_client *client)
 		goto free;
 	}
 
+	status = devm_add_action_or_reset(&client->dev, twl_reset_priv, NULL);
+	if (status)
+		goto free;
+
 	if ((id->driver_data) & TWL6030_CLASS) {
 		twl_priv->twl_id = TWL6030_CLASS_ID;
 		twl_priv->twl_map = &twl6030_map[0];
@@ -906,10 +914,8 @@ twl_probe(struct i2c_client *client)
 	if (status < 0)
 		twl_remove(client);
 free:
-	if (status < 0) {
+	if (status < 0)
 		platform_device_unregister(pdev);
-		twl_priv = NULL;
-	}
 
 	return status;
 }
-- 
2.56.0.398.g882cbad275-goog

