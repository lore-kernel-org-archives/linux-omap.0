Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CF344DB5;
	Tue, 22 Sep 2026 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037890; cv=none; b=WqZqmu9bgZjfaXe3MM/zRuP58WTHpHXYVoNLgr/pv1ntrRora16VIYGe17Te1Nail9fR341aOZCkoJYU4pNpL3Q51/jJm7P7oH9TZ6ITrb6ghWDkeGvpALtkv06j44/fyTbVmkKPlMBueg8wdNAQoFnm9d3u1rsyACOdAqnBWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037890; c=relaxed/simple;
	bh=OapBVDM1BACiesDc4iNzC/wyazWdBFwkaUbab1prGrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV/i7YKEbHDO3UbeaHFOVUgMxecgTsfpHMGhm9GSR6eqnlExVU3HFwbPxCgA+/shAa3GU8eDSJBav9NBh/spWolb3YM55spb87w96pSnyKYiHehdahk/gclSx+LiavLdNWev/OwIH4hySgo0moNDUTtjF4X4Sp64LEOOnj7b/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ufzs+gA/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ufzs+gA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BV
	dXhhy7xNn0j7m1AF71D4qBh7abCZuY0BzyTFBCcYs=; b=Ufzs+gA/E3ocEoCjhh
	WUa+YBNi8++h12aM2G3L9OzmoOaSLv+T892XwM+QkxeMjcmqqk18B1tlibVKsvMv
	WP9cTLkDu8KdEEMGlNUFTJ9mQv77vhpFzpNoTjp6rElv/aOttZ/UqxHUtD3Al9eG
	OGVcN/SDdnal8n2YO7xYo+UL8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnR1Zgz7FqqM3RAg--.28552S4;
	Tue, 22 Sep 2026 08:44:18 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: b-liu@ti.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s.nawrocki@samsung.com,
	kishon@kernel.org,
	balbi@ti.com,
	tony@atomide.com,
	hppiscas@163.com
Subject: [PATCH v2 2/3] usb: musb: omap2430: stop runtime resume after PHY setup failure
Date: Tue, 22 Sep 2026 08:44:13 +0800
Message-ID: <20260922004414.4192-3-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922004414.4192-1-hppiscas@163.com>
References: <20260922004414.4192-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnR1Zgz7FqqM3RAg--.28552S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWxKF1kZw18Gw4xZF1xAFb_yoW5Jr15pw
	s8Ka18Cr4kXrnrKws2yrn2qF1akws3JrZrC3sFq3s7Zr17G34qkr15uFyjyFnY9rWrJFW7
	tF4UJay7ur4SqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgjjkUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxQIT22qxz2KGYgAA3d

omap2430_runtime_resume() continues restoring the glue registers and
clears is_runtime_suspended even when generic PHY setup fails.

Return the setup error before accessing those registers or publishing
the resumed state. Also stop mailbox processing if its runtime-PM get
fails, rather than treating an unsuccessful resume as access permission.
pm_runtime_resume_and_get() balances its usage reference on failure.

Keep needs_resume set until the early system-resume operation succeeds.
The normal system-resume phase remains responsible for I2C/SPI PHYs.

The issue was found by our static-analysis tool.

Fixes: 10ac7e7757f5 ("usb: musb: omap2430: Add support for idling phy when musb is idle")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/usb/musb/omap2430.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index df807ee9deec..382d6cd4a9e6 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -150,7 +150,9 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 	struct musb *musb = glue_to_musb(glue);
 	int error;
 
-	pm_runtime_get_sync(musb->controller);
+	error = pm_runtime_resume_and_get(musb->controller);
+	if (error < 0)
+		return;
 
 	dev_dbg(musb->controller, "VBUS %s, devctl %02x\n",
 		usb_otg_state_string(musb->xceiv->otg->state),
@@ -579,12 +581,15 @@ static int omap2430_runtime_resume(struct device *dev)
 {
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
+	int ret;
 
 	if (!musb)
 		return 0;
 
 	if (!glue->phy_suspended) {
-		omap2430_phy_power_on(glue);
+		ret = omap2430_phy_power_on(glue);
+		if (ret)
+			return ret;
 	}
 
 	omap2430_low_level_init(musb);
@@ -636,13 +641,16 @@ static int omap2430_suspend_late(struct device *dev)
 static int omap2430_resume_early(struct device *dev)
 {
 	struct omap2430_glue *glue = dev_get_drvdata(dev);
+	int ret;
 
 	if (!glue->needs_resume)
 		return 0;
 
-	glue->needs_resume = 0;
+	ret = omap2430_runtime_resume(dev);
+	if (!ret)
+		glue->needs_resume = 0;
 
-	return omap2430_runtime_resume(dev);
+	return ret;
 }
 
 static int omap2430_resume(struct device *dev)

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.50.1 (Apple Git-155)

