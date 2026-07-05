Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17936655C
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238323; cv=none; b=e7xw8+2shFQ+sHyg7CweZOp/NN+62ALbA7ldQ9BklN8Yq8+uLbspvEn7rheewmh0nMlY2t3gVAJSRfr2k3/8a6P0ixvKfXpe+bYFQJXsbbUPkBWBhDk7FvanSSYKej4zrjTlauw54fSBXpESXrhEkyuN1rI3cqylOyU8l6k0X/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238323; c=relaxed/simple;
	bh=UOdS+ggItBo8Fbxj7Cwq/9AocOYrjMGNU/RcBG7UEQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uo7tqI3M5ep93DkQ71X+Y+pRKnXIDiTKnS6bSyoIBlixB9fVXkUMuC5LcRc+Hyady+M+t5WjM73I81EfhFD/gIVg08Ko3ib5IulXnpHFqCdBl78aVqyoMIga0NISymSS+1fNKfwEzaRCL2Hlvt0rpv9s4kdIohSIArrgWCsyPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYWuA4CX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYWuA4CX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so17381295e9.1
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783238320; x=1783843120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8luoQD6yVJJNuYdfTQQskkaqAeRmMzwRB2xqljwPj5g=;
        b=CYWuA4CXgmmGc3HCRXu7Q17xp2H6REiy9NJb/iHz1N/9IdCkOwGa7gQesUzpaylWQx
         uMdyq0LfxGsS/HJFlJFQo7uCatURt52ZJK+EIHsMSNJ1WZ+ojQqUMaTiEN458a2/QR2C
         ccRFr4o3B+8hT6B3nbFcvbI63oROn5KE505SdgNwUp/ylnlJwOsoraEt0ygWv5XpNNS3
         jCEij5JcIEEMIPsF/lnHK8PehYnvygRaN5hWQquVZDsNuWozeQN+TDtjhgq5cLsCyH0A
         k5DQP79siclJXYF5GJYRUFBx2QutzbQjT68cph0VfrFMyXT1Xj7jof8Wyh3Z8OCZAHEs
         uJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238320; x=1783843120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8luoQD6yVJJNuYdfTQQskkaqAeRmMzwRB2xqljwPj5g=;
        b=S/BRc8Tqqn6Rb/R+kyhU9PagRR7uO9PsDM2w5njDqno12n7wKZ83BkoF0BtJBRJF7h
         CnWDfBfWAoxevmJobj3uB7cR2DTH1FKnIusmSfOSkAN1cUVVjIgm4OSzG8lOP57LI82y
         8tjtsibKlNLwfCxjUgoG2t6jHjElxEmL3Fz8ZGYwQf/XI8IIV+uMbXobzzyKmL/wek1d
         fOs8NEodQOA24pa4V9iOWDnjM0E0N/IoVORiMuyaNARptudmVayu8PwRm5yM8XRvzF7U
         PsAUoTDWgVJCsaN+JaHCr3XfpDoOL+pTdt6bUOx9JV5o5dhucI9eyl9DHI3OYGK2moWr
         I/XQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AV9g9niNXzmjhroq/rpNpN7FgOtwYOs6Be5cD4TAy3NYmQt0rmRYKUfTeJhxeNPZ4vPYQVEjWpefh@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnbNvRBOJdt5B+PAjro6lgX1tY72iWHACflo759dExEDxFXIo
	2Th926MyWhDnX2s1hqaRknVDcXB7rQY2tg35RGO2qzerguuZfoaMVyoC
X-Gm-Gg: AfdE7ck8Siks68+vIojQSe8vOYukITrbU8z0EMgaCyUUFOsaXrmKL9cL+kfQ/JbOgau
	jxgzDOmXbeP8ECDtV8PF+QZnnDTENadrc9RS4dI7lPbObYZ4BnT2iCGQkoht1uCN9x7W0w6g9ie
	xEDAli3iMKpXxiQdM5uWZFgqNZCom0dBod8S7y5Cld1B8MF7eAuSWlB785MB+Ie4DsC2w/wJJb0
	4EOzlAovS2J4fC60qpa4bIPtPc7QzRAFNJuhAw6DwDhZw7cVB7RCTA/MBu1kk2JcSNaXra6j8C8
	dRH2RnqWl3OBiKxO7jX1YxU9T2fa1/NdZrmIigSWpF7t+fxWj2VpK4bxntvNy7oWu1w5lcCILZ3
	0ff+tKYuCjzmq7Er9gPLYr6B+S+MaCUPhe6nFtZpDielGw7rpZGn4x1slZ3LVDsD8gJ64xPvAcJ
	5Og/oEAQXN4ehITAvqRdtDJ178W7Xv5QUnxQ==
X-Received: by 2002:a05:600d:8654:20b0:493:bfea:2786 with SMTP id 5b1f17b1804b1-493d11f6d34mr45957155e9.32.1783238319733;
        Sun, 05 Jul 2026 00:58:39 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm305769765e9.15.2026.07.05.00.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 00:58:38 -0700 (PDT)
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
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2 1/5] phy: cpcap-usb: Prevent line glitches from triggering sysrq
Date: Sun,  5 Jul 2026 10:58:05 +0300
Message-Id: <20260705075809.1793784-2-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260705075809.1793784-1-ivo.g.dimitrov.75@gmail.com>
References: <20260705075809.1793784-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can get random sysrq events on switching from USB to debug serial
port mode unless we temporarily disable sysrq on serial line for the mode
changes.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 7cb020dd3423..d1c70c715346 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/sysrq.h>
 
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/motorola-cpcap.h>
@@ -413,7 +414,12 @@ static int cpcap_usb_gpio_set_mode(struct cpcap_phy_ddata *ddata,
 
 static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 {
-	int error;
+	int old_sysrq_mask, error;
+
+	/* Disable sysrq to prevent random sysrq events on line glitches */
+	old_sysrq_mask = sysrq_mask();
+	if (old_sysrq_mask & 1)
+		sysrq_toggle_support(old_sysrq_mask & ~1);
 
 	/* Disable lines to prevent glitches from waking up mdm6600 */
 	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
@@ -445,13 +451,13 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 
 	/* Enable UART mode */
 	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
-	if (error)
-		goto out_err;
-
-	return 0;
 
 out_err:
-	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
+	if (old_sysrq_mask & 1)
+		sysrq_toggle_support(old_sysrq_mask);
+
+	if (error)
+		dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
 
 	return error;
 }
-- 
2.39.5

