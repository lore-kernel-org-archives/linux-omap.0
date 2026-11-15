Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754290;
	b=ccMM1TswawLIY/vXB6PaeHWm1NMqkY+5cki15spoZctfVLnPmJp2Jj2W+h+baJm6vH2g
	 uj3eYpPbCiS8KSrwf0AVpVPBtxF4vFF5/ZoFSzumRlui6P8K12Qz8YVQhWfv6nPG2eVt1
	 WqOHN3/JAag71gILKpUtAmoEab8YKV8vR/ShI/rQmRxARRNNvhe9+LFjA51xzRDTZRxEe
	 Sni8zQ7zsqEnjO4Y8jJSz5OTjfpVgUjOkjyCMgXTHze08pk3B2OiXQrTx6T62kuY90lrv
	 QdAKC2hp0xboYXTfL2Sl/Po0W1a9I7PDpSVYJ6TtrjbCn1XnY8n7TxwFqkbTbPCvXJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1ZfYp2fVOAsovMDBuZ6IFcNyy3aPY7Zpal+R9H3Fzo8=;
	b=sAhventGTmjug2SKrzzJB9axBqZtZf/YD6uMXSwXbOW+ck87tMvuQdj+cHx6FdTRK61H
	 IoPGiBEB5+P+c7YWoHF06U61ImEM4eo71pjjiQHg+kPGNKTuDCFw06KwuMArldMM/EOmH
	 emai1oysXfaDJYIwtRj7hkib4KCgt7vH9KUXcXvcB4yebTXtUbu8wvY/xG4gn0iA5bdKF
	 SM4OWFNeggHtY8hAAzz3AzSbGEAC9pwK8dGo0E47LcGvrXYrhM5c9/p8aMeSE1CRwP6VV
	 JKz2MpCF4naJc7AYUnopp2b9KSoCmSyuYAF+2eUv+YL8G/Tp/bYFaGFn9LjYPYt6k/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9SIedi3;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5B606A31D
	for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2026 14:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C5B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9SIedi3
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso847163a91.2
        for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2026 06:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754290; x=1795359090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ZfYp2fVOAsovMDBuZ6IFcNyy3aPY7Zpal+R9H3Fzo8=;
        b=a9SIedi3C6EHJCF1iS7LlJ9JTawYnDP3geGbLahyMmZbYrRcciEIC5LWSZov4Y4nrU
         EnIp44EKasSUXQILotvPIDflq2Mq2xRA7WmbmxFmA2JccePPAdK1VCbsUeZYE2Ew2LB+
         TB6XSaDhRBVzJ9gGln7vw7Nv8zzVIFRPyiz4CHMSgbpxeq9LTLNDlxY6OCky8pyOcmUW
         xLyt6jqpxoY1DIWqkhsd5j+KsbLfr/7gv/PgfMqSQUxI7V0OTMnpyGgpcf3oT1Ib3E8Y
         zLw18kCeVI9c6ee8KcvdYtGF5d9j+gpTf3L4i9gMPKLqUppZGKUxN/hUmP1e/MRDhLM+
         FZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754290; x=1795359090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZfYp2fVOAsovMDBuZ6IFcNyy3aPY7Zpal+R9H3Fzo8=;
        b=MRxE0ZOOt7mXwQcaWBK7qPV6X+UeAFikPC0dS+UtvKFPsWjYxsWPjE1HJHucXWzU0d
         PAkv9iO3CqYW+xV6nhHYvyY6Q9VGrfZFshV75q/ZxVyob57hrPkt7+9xxFL+CNPnpDz3
         RWEbqc/FpSqTzGjWItV7VgTVwIXD2futSrNZL3zyOAYLyizDUXahxmNi2DhcwQPmuDt/
         +0qfG5cSjiDIT1yLHjMGKFrFosNghhI/FB8a00t/36BoEK/SO5c7Uxec9rqOHrBpSPod
         Ggm80DmiAmgOd93W3lww91WnjQihebzdrEFFiP5MK7du1FVT5cjx9qDX23hrBT7P68eM
         txTA==
X-Forwarded-Encrypted: i=1; AL+hErET4WOuA3ENMshtLa9gFlvlGKLtGonyxNuCQPXaqGTzo68hFCWK9x20hdX+yrIE7xWXIIyUb3iYgrkm@vger.kernel.org
X-Gm-Message-State: APuU4Z8kpVmZikdGDY+QOtyZqtc8BhjDSAxLggH73YT3sVa2BuLb4Us9
	EhuUedlnIIyiRjDVvxiyVy4Q98biLLAyiKMwFiMWaaf6zkbm0NiCOwSz
X-Gm-Gg: AYBFou04OrahqubPL8KpCspvKqouJtpk0+Y5EYUeTa4B/gWOJQjF2FRy0oLcpeSfTIy
	MLAxvqJSqE+TqXdbMLtkrV8m279Fbqz9+yvoi++9NL7bRB2AysiMZew9jHfUakILZ7Z2f373m5X
	tGy62+i1OSk8+UqJJt7ra1Z37Nzhy+/0P3PKVJph1TtmKyRWO6L3vAo5+LFCsGcR+Lx2LPbyZCT
	s27TbnvFKFJrTfNYTVw8liNs0FX+ZnZS0EJRA0Y3qBNIGdlCvBKYqVcqs32hRr3rZotKwmmsmkm
	NKPEx9Fh6nhhZWWXCckXRmJflzHh0dBzJN2UjGbOEV63mohyNdrwL6m/r+WUWCg56tQPjS9XC3k
	Sl0h6AralT3rsE24HCfvIVPwlvw7kK154lQYz9Nw9ctjoKk8zm3zl89Nt479mnFyvPqqCDUaqvk
	gRt8AoVD+6E3H8FHgDsJc2P4rdSKaOoG37UBxGFRJWn97IPh6X2p24ZU40vcKlFIhqs+dtkYGuU
	eVLT7uC+UmDzov3Jbpp+7v7AJ9dVOsX8ldl5jHqlUTlAPJZy7tkWWcx27IDpeGcT7cpV3nUllO/
	UJwCId2EaKf5FucAijmGTJ1mJuCuoVjdTdSjDosxCWkzxV/C
X-Received: by 2002:a17:90b:1650:b0:3b1:8396:ebf8 with SMTP id 98e67ed59e1d1-3b1b0a4fe2emr7626437a91.36.1794754289600;
        Sun, 15 Nov 2026 06:51:29 -0800 (PST)
Received: from localhost.localdomain ([115.76.89.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm17353559a91.15.2026.11.15.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:51:29 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Olivia Mackall <olivia@selenic.com>,
	Deepak Saxena <dsaxena@plexity.net>
Cc: linux-crypto@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwrng: omap - Unregister hwrng before disabling the device on remove
Date: Sun, 15 Nov 2026 21:50:50 +0700
Message-Id: <20261115145050.88427-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Commit 3e75241be808 ("hwrng: drivers - Use device-managed registration
API") switched omap-rng to devm_hwrng_register() and dropped the
hwrng_unregister() call from the start of omap_rng_remove(). Since then
the hwrng is unregistered by devres only after omap_rng_remove() has
returned, i.e. after the device has been runtime suspended and its
runtime PM disabled.

When the omap-rng is the current hwrng, hwrng_unregister() drops the
last reference and schedules cleanup_rng_work(), which calls
omap_rng_cleanup() and in turn omap4_rng_cleanup(). That reads and
writes RNG_CONTROL_REG while the module clock is gated. On a
BeagleBone Black (AM335x) unbinding the driver triggers:

  # echo 48310000.rng > /sys/bus/platform/drivers/omap_rng/unbind
  Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa310014
  Internal error: : 1028 [#1] SMP ARM
  Workqueue: events cleanup_rng_work
  PC is at omap4_rng_cleanup+0x14/0x24
  LR is at cleanup_rng_work+0x30/0x48
  Call trace:
   omap4_rng_cleanup from cleanup_rng_work+0x30/0x48
   cleanup_rng_work from process_scheduled_works+0xf0/0x518
   process_scheduled_works from worker_thread+0x140/0x2f0
   worker_thread from kthread+0xfc/0x134
   kthread from ret_from_fork+0x14/0x28

The worker dies before it completes rng->cleanup_done, so the unbind
also never returns because hwrng_unregister() waits for that
completion. The same window lets the hwrng fill thread call
omap_rng_do_read() on the suspended device.

Restore the original teardown order: register with hwrng_register()
and call hwrng_unregister() first in omap_rng_remove(), while the
device is still powered.

Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration API")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/char/hw_random/omap-rng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 49d7f021fd31..e5b14ab1b7e4 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -493,7 +493,7 @@ static int omap_rng_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_register;
 
-	ret = devm_hwrng_register(&pdev->dev, &priv->rng);
+	ret = hwrng_register(&priv->rng);
 	if (ret)
 		goto err_register;
 
@@ -520,6 +520,7 @@ static void omap_rng_remove(struct platform_device *pdev)
 {
 	struct omap_rng_dev *priv = platform_get_drvdata(pdev);
 
+	hwrng_unregister(&priv->rng);
 
 	priv->pdata->cleanup(priv);
 
-- 
2.25.1

