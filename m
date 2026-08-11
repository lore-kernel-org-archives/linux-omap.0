Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC01F09AD;
	Tue, 11 Aug 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453415; cv=none; b=p/7BBQJHzuQUZv8v1/oCi+x9VUCVLbw4cLy+b70N4mSgtrOKSZ47AK8ljTieO52uOVrkAengDkOmcCiZl8VO+DHeLZhwO7t7V+rPmXwO8ZXgT9HVoiDYZN324AQJJvD9o7IWTx3hQR9hQy5/F8leQro0DMP94RKQqWxzqxODoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453415; c=relaxed/simple;
	bh=0wMUQ5qPclzmrIkaz3deA/LEEF2M2PQxy+VQQnfvVy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXegHznh06s7XjgduN8uAGxk7duYK18GegC+lsGeHJ2XrkJZZIlI1JJL62WlE9F4fwt8ancyl05V4xhqC4NDRzvGW2NS3RDD6r40uLHY3TQg8QVIIZpRXY/rAi6hOnKT4xEOQp0j3owNxQ78/iKUW/S6JxAYMpnPcXCAKYn0P7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3C7E82698C0;
	Tue, 11 Aug 2026 15:03:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8zozc2Fdbl03; Tue, 11 Aug 2026 15:03:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D3D3E2B4F67;
	Tue, 11 Aug 2026 15:03:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bW4shW0w-Lmy; Tue, 11 Aug 2026 15:03:23 +0200 (CEST)
Received: from nailgun.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 5FC282B03EB;
	Tue, 11 Aug 2026 15:03:23 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	brgl@kernel.org,
	linusw@kernel.org,
	khilman@kernel.org,
	ssantosh@kernel.org,
	grygorii.strashko@ti.com,
	upstream+linux@sigma-star.at,
	Julian.FRIEDRICH@frequentis.com,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] gpio: omap: Use device name as chip label
Date: Tue, 11 Aug 2026 15:03:10 +0200
Message-ID: <20260811130310.3867697-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 92bf78b33b0b4 ("gpio: omap: use dynamic allocation of base")=
,
the driver no longer statically allocates the gpio base.
Having chip labels with the old static allocation makes no sense anymore.

Use the device name to have a unique name such that gpiod users can clear=
y
distinguish between gpio chips.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/gpio/gpio-omap.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e39723b5901b..3fed7b1bebf3 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1033,8 +1033,6 @@ static void omap_gpio_mod_init(struct gpio_bank *ba=
nk)
 static int omap_gpio_chip_init(struct gpio_bank *bank, struct device *pm=
_dev)
 {
 	struct gpio_irq_chip *irq;
-	static int gpio;
-	const char *label;
 	int ret;
=20
 	/*
@@ -1056,11 +1054,7 @@ static int omap_gpio_chip_init(struct gpio_bank *b=
ank, struct device *pm_dev)
 		if (bank->regs->wkup_en)
 			bank->chip.parent =3D &omap_mpuio_device.dev;
 	} else {
-		label =3D devm_kasprintf(bank->chip.parent, GFP_KERNEL, "gpio-%d-%d",
-				       gpio, gpio + bank->width - 1);
-		if (!label)
-			return -ENOMEM;
-		bank->chip.label =3D label;
+		bank->chip.label =3D dev_name(bank->chip.parent);
 	}
 	bank->chip.base =3D -1;
 	bank->chip.ngpio =3D bank->width;
@@ -1087,9 +1081,6 @@ static int omap_gpio_chip_init(struct gpio_bank *ba=
nk, struct device *pm_dev)
 	if (ret)
 		gpiochip_remove(&bank->chip);
=20
-	if (!bank->is_mpuio)
-		gpio +=3D bank->width;
-
 	return ret;
 }
=20
--=20
2.51.0

