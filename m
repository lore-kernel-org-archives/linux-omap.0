Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071578;
	b=DuylNjqP3IHNOxn0kvZvhU2+/t+ehqzuCFob30BtQfuHGtib/jOfqFo74pDz+hwsZo8B
	 W0V+x/FjGVHDv9cNpaaBndCIK5aZv3Re7oenMtQDzpHrEn5586cQWN1col6bhs9/01brf
	 FNi1LqxBIMpQ9VmexI1zvBQHKnuQvF5pg1e6vq/MG5lo5F9S5nN936Ejqg9erfJf+QJlF
	 gbOmdWYX7PKbNHix0J1OlBOsWyXe3v07OiRZWsJIQ7DYgMv+au0B2HC4DzVTYX8mYsUdm
	 Br/GPbL0kIFKLKRFGRDHDtIuWs/Az9lOkNi3x6wrR4hKXnDCF5FdXSMa2CZ3o6MKCRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2QK2iE7noXFpUwQUNk0LfJ3uQv+Asv37AvrfE0uGxCo=;
	b=R4keLl88n1ZaDHizlOxl6TOYVPk2+pwEf7n2S0TvOOg+8pfueOYITku5B315EeOoUOTI
	 WmJHitkiIHX21u9jD/VroaA3/URfEuQlXec0BugJG5c2sp952zp5dvkjHqJa1B9UdSTBP
	 W30vAEkCGrG9EbaBvJSmefYJxPZWRkyDZ87FN7s6xSim8uNZw7SG6kRZ0I/FI2XQdxcL+
	 rRHNsKWxC7IQGT902FnRb/YucuPTi2y+uK9VgLFWWLjbGh4rwyIutJGhCKA0n4ysGpJ06
	 /67Dn9YqxGRjNqq3hxZnIkn7SyuQi6QxLWRshkvxI93Ldi6Ah9xmAXhXcN5lbbZeTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peE75+7g;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE74606A31B
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 03:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE74606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peE75+7g
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-18cdcfc05ffso4526168c88.1
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071577; x=1793676377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2QK2iE7noXFpUwQUNk0LfJ3uQv+Asv37AvrfE0uGxCo=;
        b=peE75+7giTLgdy0neqNE+JHr8K/D+on9j8SKao4hj7hAu/Wbm5v5rH00RFK8CJx1qZ
         mHQ1q2xpj4F/gbbgfG2AWJKh+fSisAgSbnrlcC38YjhxTuXOdgUDGe8gZRDlik8U1Ytd
         DaGFJvYg/aW8JxXWKSwm4R8qAQ9xKP3LWXvhQ2IY8Y+ShvFF89ErNRAYQCo2EFCmNBoN
         RzD9XWfm5V4EbfuKJ5oSAMwOhnmkl7KXzl2vTAbQTFVRTbYULDsiTd8TX84tquj5aRfG
         Nnx6evrTPRvDPH87t9dy8eoVSg8sGJE0W2voOo8dJOTo99BFweHJpu+ARo78Vc0P/DU/
         QsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071577; x=1793676377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2QK2iE7noXFpUwQUNk0LfJ3uQv+Asv37AvrfE0uGxCo=;
        b=iO2fl1FXC7g8J55FfxYRsYp9uL+ev4ULrKMymETYHOEjHZGPgVy4qsfzjXSI96ybnN
         0ipB0AE7lsAAn4bGXlq9ClsIfOboYkYlmzkCsATU3+ohHTjTrDhcGU7oCDvckrpgWHMr
         WbYGM5O4k9yRhE8yewFcM+zzYTTV4GbAn6+0VYbf1I+lJGKzszxz4TGeGUMwdQ4ycTKC
         j4z7oxoKUUgMkVewDewlVSrECj5oT4bau47MXrGK69Cf+1yB1S0xQVNgOE59mWzQaKnN
         oyNsMvWEQc6OUfcOfXe2GwQqglnGmGPj+E7A24SJerAsy2vbMEO3D6alzn6bOemEl9RP
         5qYA==
X-Forwarded-Encrypted: i=1; AKwUvBxsIkD5g4jr4LWG2nOVMJXIlfbHsRneO0u1gX1pK9cmbpad5eQdgKkMhj+ewMHitrvTxtcJFwhRbyGK@vger.kernel.org
X-Gm-Message-State: AFq9FYJAdSp9UipZLIO8cDQ/fPWjFd9LLq2S5+BiwWTn9Q+An2ad0HOT
	xG9Xt+SPXJF0r0NB15FB1w5x3ukIqpoduHILnjMbLZr+HbnmYJOHbgX2
X-Gm-Gg: AYBFou2H8T+RWw/Bf7/kK7Dn299TIwLI4Yw7lzFHiEYWtARLRLVdUsOAFSw3pHnUS6F
	nL87Ysnzk3pGXwuI6Pw36GPgYGvXqigok1NmCq3LvYkozVjUafpVwfHmXfJ5clEUDHz9SV1/Tq+
	tNdP5Mr7zw5ejB6Zbd5g82yYCnSkcLq52SQ8XswkW+b+nNidXAzzbvm7BbGzR7vmDvgz7o6RL7A
	PSij+C2NUUrzpAveujoWs+LsbyxHRjeZx9wUpp5Zh9jGe6+3+sPl954gmOIoSddB9f1j9mpQJVT
	qD5K/WnqtsK1+VI5kftkyQW6ca6AalhluQRiWWWJYNsuvKvH5niRYgRbos1XFE65L9Tn9XgeZwJ
	hotrkb48mNrRkaD2p6xdvE8oBMzNf8b2L+idtowzXt7x8RvKHXDJ0Z8xgaobJIO/MhtzKLFBSsy
	hVBqN6Z5ZuZdTK6JpoGDLaMrHvIxItqRwQiu0H4de+mbEIlTk4GPQRphTVpW9DM+m9a8Xku3tA2
	qC1IJWLb3Z1Dj9BqB67hGaDToj2OtjJL8vKeKUG4SrLXcPuxZVvhdnrXtQoRNjWJXdmmfFS+2YO
	x65ZUEMZtp2avslkVA==
X-Received: by 2002:a05:7022:b886:b0:16a:b995:dc7c with SMTP id a92af1059eb24-19935be80e7mr11905109c88.21.1793071576759;
        Mon, 26 Oct 2026 20:26:16 -0700 (PDT)
Received: from lgs.. ([47.82.67.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm32317865c88.9.2026.10.26.20.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:26:16 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
Date: Tue, 27 Oct 2026 11:26:08 +0800
Message-ID: <20261027032609.119226-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

twl6040_remove() currently removes the regmap IRQ chip before
removing the MFD child devices. This destroys the IRQ mappings
before the child drivers can release their interrupt handlers.

The parent driver also registers READY and thermal interrupt
handlers using devm_request_threaded_irq(). These handlers are
normally released by device-managed cleanup after remove returns,
when the corresponding IRQ descriptors have already been removed.

Consequently, free_irq() cannot find the IRQ descriptors and the
allocated struct irqaction objects are not freed. The associated
IRQ threads also cannot be stopped through the normal cleanup path.

The probe error paths have a similar issue, as they destroy the IRQ
chip before the device-managed IRQ handlers are released.

Remove the MFD child devices first, then explicitly free the
parent's READY and thermal IRQ handlers using devm_free_irq()
before removing the regmap IRQ chip.

Also update the probe error paths to release successfully requested
IRQs before destroying their mappings.

This issue was found by our static analysis tool under development.

Fixes: ab7edb149c75 ("mfd: twl6040: Convert to use regmap_irq")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mfd/twl6040.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 562a0f939f6e..7b05d21cd17d 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -745,7 +745,7 @@ static int twl6040_probe(struct i2c_client *client)
 					"twl6040_irq_th", twl6040);
 	if (ret) {
 		dev_err(twl6040->dev, "Thermal IRQ request failed: %d\n", ret);
-		goto readyirq_err;
+		goto thirq_err;
 	}
 
 	/*
@@ -791,10 +791,14 @@ static int twl6040_probe(struct i2c_client *client)
 	ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
 			      NULL, 0, NULL);
 	if (ret)
-		goto readyirq_err;
+		goto mfd_err;
 
 	return 0;
 
+mfd_err:
+	devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
+thirq_err:
+	devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
 readyirq_err:
 	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 gpio_err:
@@ -809,9 +813,10 @@ static void twl6040_remove(struct i2c_client *client)
 	if (twl6040->power_count)
 		twl6040_power(twl6040, 0);
 
-	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
-
 	mfd_remove_devices(&client->dev);
+	devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
+	devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
+	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 
 	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
 }
-- 
2.43.0

