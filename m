Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117798;
	b=KdLZIvanETFzwENcHfie7pHbIhVCQktvLDi4mEt0Oyd9eoUmR64Bhavn2+02T1dhn7x4
	 6kXnAorH6sRCQg3pEDNhVlnOwTw2YpFLT9QyFjN42MtAvm1huFzIGRh44CxTrvOxNpQgd
	 FOZ+6hKfYyQOoOKkb7+yTCxsFVDrUITGqML+1Z72LX9aFdNuiE9975BlHomaGgqMHuV7P
	 V9VM5SecOit68pJBLvZp/HqLl+1IUamz70izWmHZussLdhN5uN2KCkY8dPGpKvwnFMWjr
	 bsV0mEhdONkJNzfvkRGe48Z/VAbcgthNGCgzxwU8RzNCgKumt3yFjfeozJ+Vegd9/SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117798;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rHJ0r6sMsrr/1LYcheqx+tY9JnpbxhAxYLeVM/8uhGA=;
	b=Ov7eVI+1O/Ci0nZgz64FkSwUwawxQYrKF+ucSwX7ivpZDc6cnbGsoQG1Tq25OZSaPdHx
	 mUlS06SvlxjwYyDSANgtTVXBCReoEhtFmlWnRfii7rHfmMccx5GNRg6RkSwrHyixpmRIq
	 cHrMhr8WTMgm+XUAUMjL6OlaR83+I58Dij+qf3BVtNhZ3r6VA0ehVz42d/xXhLlgLZufN
	 qOCZmLhL/uwLqVJpYXSwsBnclIihUe1fV6EIrDDUdsqJ9LFQY4T1LrVAH9kNcM1FosAW1
	 hcgnNGNJVZZXPESv3LBj5w10HNMRvT6s4bUpNGfBVrjWhCKUS8AcLQTuUC+ScSQDW4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mYppD/P6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB2606A32C;
	Thu, 19 Nov 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYppD/P6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0301F000CC;
	Thu, 19 Nov 2026 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117797;
	bh=rHJ0r6sMsrr/1LYcheqx+tY9JnpbxhAxYLeVM/8uhGA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=mYppD/P6DzybcKaLx28w1wvQy4kJf17lvH9lQZUChUL7WCnIFpwmfNPxfw6LANA4K
	 9Vhvom8KvMwxq5/T3ZM8pRryNo5YFsArK7iAvnxPKutcCfmz6goybN8ihNk7lbiz6z
	 6dD3iuYaeSFVNtGCi/5wJ29cjxt6CQ/whSXZR8nQrXREtgczkU/kAtEZ+a+tDOZ7lY
	 MxigfYeyPNQSz+fnuh9fS13P3sPjtHXUc+4e1lciWfjg8PUZAcMLq8Qj41zBaBc5n9
	 dX4B4Ekgskye84E+XvE65Fy0LVgT4pbXKDU/C8qNRwSL2TnPmKbIuWcy9C5bbrOVIl
	 NHCvGvi77ygsg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Kai Svahn <kai.svahn@nokia.com>,
	syed khasim <x0khasim@ti.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mfd: twl-core: Reset twl_priv using devm_add_action_or_reset()
Date: Thu, 19 Nov 2026 19:49:30 +0000
Message-ID: <20261119194939.2436337-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119194939.2436337-1-lee@kernel.org>
References: <20261119194939.2436337-1-lee@kernel.org>
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
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v3: Previously sent standalone - now rebased onto patch 1

 drivers/mfd/twl-core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 7784e000b995..cef729109126 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -713,7 +713,6 @@ static void twl_remove(struct i2c_client *client)
 		twl->client = NULL;
 	}
 	twl_priv->ready = false;
-	twl_priv = NULL;
 }
 
 
@@ -735,6 +734,11 @@ static void twl_unregister_device(void *data)
 	platform_device_unregister(data);
 }
 
+static void twl_reset_priv(void *data)
+{
+	twl_priv = NULL;
+}
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client)
@@ -788,6 +792,10 @@ twl_probe(struct i2c_client *client)
 		goto out;
 	}
 
+	status = devm_add_action_or_reset(&client->dev, twl_reset_priv, NULL);
+	if (status)
+		goto out;
+
 	if ((id->driver_data) & TWL6030_CLASS) {
 		twl_priv->twl_id = TWL6030_CLASS_ID;
 		twl_priv->twl_map = &twl6030_map[0];
@@ -909,9 +917,6 @@ twl_probe(struct i2c_client *client)
 	if (status < 0)
 		twl_remove(client);
 out:
-	if (status < 0)
-		twl_priv = NULL;
-
 	return status;
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

