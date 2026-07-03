Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493B329C6B;
	Fri,  3 Jul 2026 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056088; cv=none; b=G4K0yxIaMi/U4ZmycbD/LUMxn+1igdmZFZFF+b6KO8V11+XE9kNOvg9vUNVIV4xI3JbBp0O0wD1V0dtiz0+xtLohUjF9ctr/O/K9EnNLusOiMOWe1LMTqBZDqXf/sLGfnSo9Ln9GA4LFR4JKKfaX/mF4pkRHsyLJKUiop4yDYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056088; c=relaxed/simple;
	bh=s/1N+kpmK5axVCvpGkrT6GRdB9Pee1UkY42RPvDFwps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=izPkaLZgvIKFdEf5+E+YP85UPhG+C5zVG/d/psPa3FeCAAOqO0lYi6si3a1joq78wlomFweWmRG+ZUHCqP6M6H4f6NKMLCJ8XdtVCPBEKOxMB1uv0ADOBQokS+h2wfN3VCwOlPmjxPHd8Q/k5J9cpBIx+yCM7esiiG5mW2sjlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=f/c/x27a; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="f/c/x27a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zpuaP5vY9FQFOXs73vk+7vxYfwfou5t1jHctHNaYXO4=; t=1783056084; x=1784265684; 
	b=f/c/x27adI4OdZBw9VNr6822Z5mtjLUZPX5aqmve60jBDN3fKrHC2LqLaeyBfkL/gqsKMI326BX
	d2JKWuAVnF+PInN1aWd9H/qXNRPxLIoRK8b2hppP10P9SmJjyI+yZScb+i/PXOSeZTJzzW6PktAw3
	8h9ZJ0U2PLsGxOEYrdurSF5kuWx+dSwKoeZXW29mSbBxxgNaJRh5R4Flk7/7BeK8mQA0adedz9zc7
	iuCvnO88KMULDIOPORcddzehkJ/N4GQRnmhHTBhA4D21cLI4YUrZHDxo2x0nZb1FSj7egGu7tj5Kd
	l2ELBbHKb7ifd2OhZuroZfoQJw6ZvRU/llwg==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Fri, 03 Jul 2026 07:21:05 +0200
Subject: [PATCH] gpios: palmas: add get_direction op
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-palmas-getdirection-v1-1-046c155961c4@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAMBGR2oC/yWMQQqDMBAAvyJ7bmBjpFK/Ij0kZtUtbZSsLYL4d
 1d7HJiZDYQyk0BTbJDpx8JTUrC3ArrRp4EMR2Uosbxjjc7M/v3xYgZaImfqFvXNw1YUY+8wIIK
 Wc6ae1+vaPv8s3/BS+1zBvh9DNE5KdwAAAA==
X-Change-ID: 20260703-palmas-getdirection-914eddf30b00
To: Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=s/1N+kpmK5axVCvpGkrT6GRdB9Pee1UkY42RPvDFwps=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFnubme2yR1qrOB8ba8yoaLrm72mnOhSH/63us9S43X3K
 0ovjZvcUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwER8VjP8L9CWPvf6yQMp8+gm
 l7cul/qm5ZTV/151LetP7+SdC/9FlDIyrHc5x725tzT5ZMgH9ePLbRR5ErbvfbCocsUyzSUJvst
 XsAEA
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Accessing debug/gpio is quite noisy without a get_direction()
implementation.  To calm that down add an implementation.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpio/gpio-palmas.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index e377f6dd4ccf..e64ee0487718 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -116,6 +116,24 @@ static int palmas_gpio_input(struct gpio_chip *gc, unsigned offset)
 	return ret;
 }
 
+static int palmas_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct palmas_gpio *pg = gpiochip_get_data(gc);
+	struct palmas *palmas = pg->palmas;
+	unsigned int val;
+	unsigned int reg;
+	int ret;
+	int gpio16 = (offset/8);
+
+	offset %= 8;
+	reg = (gpio16) ? PALMAS_GPIO_DATA_DIR2 : PALMAS_GPIO_DATA_DIR;
+	ret = palmas_read(palmas, PALMAS_GPIO_BASE, reg, &val);
+	if (ret)
+		return ret;
+
+	return (val & BIT(offset)) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int palmas_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
 	struct palmas_gpio *pg = gpiochip_get_data(gc);
@@ -165,6 +183,7 @@ static int palmas_gpio_probe(struct platform_device *pdev)
 	palmas_gpio->gpio_chip.can_sleep = true;
 	palmas_gpio->gpio_chip.direction_input = palmas_gpio_input;
 	palmas_gpio->gpio_chip.direction_output = palmas_gpio_output;
+	palmas_gpio->gpio_chip.get_direction = palmas_gpio_get_direction;
 	palmas_gpio->gpio_chip.to_irq = palmas_gpio_to_irq;
 	palmas_gpio->gpio_chip.set	= palmas_gpio_set;
 	palmas_gpio->gpio_chip.get	= palmas_gpio_get;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260703-palmas-getdirection-914eddf30b00

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

