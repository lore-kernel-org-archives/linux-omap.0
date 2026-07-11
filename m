Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FC30F7FB
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802567; cv=none; b=QbKkm/KQBdUa59JjY5i5/bjrFahAog4oZ465HT7XnhgrXbWwBzy+ggfCXbM/HdgWGg2HZeravi7uZiOeCBkAcwkHRvyKQ/ONu4pUd5s8AbmBQqvGpUm73Rnp7DaAccLhLp2c7fKkFCXYHkNCBkhiPfkLicktqqqpQ45Dv+sP0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802567; c=relaxed/simple;
	bh=Ks2eP/cpFMNIiN5iTQ0FeCLHneQLovfhgH+//9ums1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p43N4YvnMGb2VZggAb1LH13EuOgSD8hns5SmlCECJtEhgVftbkalA8kWJsr86SMPs443EMV3w9yuSmF1anF/E+NjWvHhsuq9KJdd5oLDHXVEZ8CIvrBztlmI12nk59BOnrsD1M4okDjqs7dYGOQfBFTWrOD7YcgudK1r0cMZOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvNcRQTV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvNcRQTV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c19bad03so17130965e9.2
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802565; x=1784407365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OR+gVYl7lNIahaA/xS643KgVQohpeipjmcrGmazJ6MU=;
        b=bvNcRQTVVw8n7mMb16mUwF1RBVaHYV+09ypgkxTkb1FOPa6kuMof7CgQv01ABJeDKW
         tvPKp0HatvIkDf8fjvxfIwsBfQQeupcXo3ufOnXhw8VbuxEINFk7Qo3tIzdV3Tc5Pxyl
         CAQ/IjJfbzRwQGYZPx+ME8bSVhR1vt/m7jZKKmlyatqChpD3KaQr7MVcGBg+8v5+zFYL
         eZUIW/jh+zTENTDlBJpzN4pzZHoATWhJAo1Hz1YDnygOakMjnFzPmYZpJBuReJYhdT2Q
         DM8U1wZ1SCyATKfSSI0gfmMrNsW4pUczv0EL8davQJbS0JCJiTPtadxPHRlNuj7X9/f9
         t1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802565; x=1784407365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OR+gVYl7lNIahaA/xS643KgVQohpeipjmcrGmazJ6MU=;
        b=p05xGy1JeNUoO7M4ZRumQoYRQQvfzUbbpwpbJbOj3voBcHK4xgVix2GiA65SlhI/6k
         zuJ4SLYAzYFDOMxWQFLwdvhNq9g+fBfw9GwQ6nzbnLAItpCVY4EinIZz15coIAoiKyKK
         fGAZICPAF0FOjt41rg1a2fTG0KcZ+dk4PRebaUptVGDs6nmK2FXIEsAavqmuCZqY/i+j
         EEovP4Sn+Tf1DWLiKjWu+wK992TxX/CPE4PvoReeQCl8VPBxY91V1KqLTSjds+RPDjVN
         syNBqWPslNQWujVeD54v+8yPq6NtPcKJoLRIGiN/HPh60R0vs2EY55TlRU/0I2YljCNw
         ApDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiQQPNsuPy0dtUqgq2P4R42oDhHFZW0bmo3KCqyhnQ0jUziY4WJ7+bqAtvkVahUp8KEtWsDA4eIegp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Q06xTPxsslRws7Mb5KHp4lqXM5QxAgicNBvhSTCa/qWK2v4i
	UuanrBwpu0FqiVXBe9vWAbPP5DF6rSQKSOpLJJp/1GRWEVZCvgHRXnjl
X-Gm-Gg: AfdE7cnAb097aFlRlOXmUTDz7oo+3pFNeaHzKr1Bly8nMgLIxpPbUkk6HYV8z8gD89f
	En/rxQZg+gKDn44iOhwMk8gd5KQYVfSnA0W+u7NHzqgMamGy23UXJS10lmJFKYeYtnqenFM3tlj
	GBCEm5mCJ7U1xlrJiIdHriquf+/JNoBJJfuCiEQS6h7g8EO3XdYWBQs7zGjgS/rAjorxw2Ugr3R
	QBd+4T9iUbvFwDnlIfO4ZR/R7GoO4wBoCQwIMpx5sIPSl4BPEmHILz4bBsmKWf18aJw9pq15Qk1
	WV5mzUrmBJVxqZx3SG395TYYUS4t/2Cq2nvhOrzbJK+maL/Xz+WeRqTfSX8CsiG7UA7NM4bEgXI
	FBQlemeCDbP6VQlxzbvHrBsWAQ0B3rMFR34dhwPeA04pGKOkDBLH3C1uljoCqHRwNgtxkJ+OwrY
	P2BYL8YDjhWClZpNRWLJai/UJBUkVtmBR+puIP5QZMap2p
X-Received: by 2002:a05:600c:46ce:b0:493:bc92:ef45 with SMTP id 5b1f17b1804b1-493f8820951mr35073795e9.24.1783802564720;
        Sat, 11 Jul 2026 13:42:44 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm172704725e9.2.2026.07.11.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:42:43 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v5 3/7] phy: cpcap-usb: fix IRQ teardown race
Date: Sat, 11 Jul 2026 23:42:06 +0300
Message-Id: <20260711204210.197144-4-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

there is a race between IRQ handler and remove:

IRQ thread:
    ddata->active == 1

remove():
    ddata->active = 0
    cancel_delayed_work_sync()

IRQ thread:
    schedule_delayed_work()

The IRQ handler can therefore queue detect work after it has been canceled
during remove(). Free the IRQ handlers before canceling detect work to
prevent new work from being scheduled during teardown.

Reported by Sashiko

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 7cb020dd3423..741145c89e5b 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -393,6 +393,19 @@ static int cpcap_usb_init_interrupts(struct platform_device *pdev,
 	return 0;
 }
 
+static void cpcap_usb_fini_interrupts(struct platform_device *pdev,
+				     struct cpcap_phy_ddata *ddata)
+{
+	int i, irq;
+
+	for (i = 0; i < ARRAY_SIZE(cpcap_phy_irqs); i++) {
+		irq = platform_get_irq_byname(pdev, cpcap_phy_irqs[i]);
+
+		if (irq >= 0)
+			devm_free_irq(ddata->dev, irq, ddata);
+	}
+}
+
 /*
  * Optional pins and modes. At least Motorola mapphone devices
  * are using two GPIOs and dynamic pinctrl to multiplex PHY pins
@@ -691,6 +704,8 @@ static void cpcap_usb_phy_remove(struct platform_device *pdev)
 	int error;
 
 	atomic_set(&ddata->active, 0);
+	cpcap_usb_fini_interrupts(pdev, ddata);
+	cancel_delayed_work_sync(&ddata->detect_work);
 	error = cpcap_usb_set_uart_mode(ddata);
 	if (error)
 		dev_err(ddata->dev, "could not set UART mode\n");
@@ -698,7 +713,6 @@ static void cpcap_usb_phy_remove(struct platform_device *pdev)
 	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
 
 	usb_remove_phy(&ddata->phy);
-	cancel_delayed_work_sync(&ddata->detect_work);
 	regulator_disable(ddata->vusb);
 }
 
-- 
2.39.5

