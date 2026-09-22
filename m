Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE462305660;
	Tue, 22 Sep 2026 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037893; cv=none; b=C3P1d7+tVM1Jk9OWNYdAq7J0PmWnsWO+68lQLcQX+pJQ3bFR51z4JcpcVYMUC8IRK1M/irJ0F/29t3YJiRo4jdBErVxkxoyw5SWp+10TbSYW8TzfTdunSLQ+a6BFygVRcG5tp04ENE1af77BuE5/dkt5JrSGpqm10UKuQSkWfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037893; c=relaxed/simple;
	bh=VrLlNC5NjUVGIlBg5If8kxVhB2ZN9HvHbIjY3kAZXFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXt3evqEcjFU7IzPWdOpDoiWQ1we3PfwNpxuBkXM9FxgSbPCBUMbko6Ws8ZRVwQqkt9/uch8Hn5OUEyb5jtyQ1ezxAhLMEeff55XnYBegTBXqN5Jlcu3ohJ6xlbp0SAstjHx+9Oy5zd4Q93oVzoSsYVoJg1j7FRuLofBLgYLBgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sl6TGMZI; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sl6TGMZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Co
	hANUA8pAKzf6hG5EKMwzcIpvCRsFVt2WMDD3wkgV0=; b=Sl6TGMZIlGVYed0tgx
	UKcLwoP+7qilJAKLT3mZag5yzdF0TvL+eaxOwmvum5TyGpJu2uKBbXqDHYi5CLlZ
	2loQrE/3/ddtll8lKdyNDjsFVEJb4wvDtAVxwxO21k2Pggp6OTqryrRfBOXB78Q2
	wKbiPC94WZf7jc0CHrOvvqYLs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnR1Zgz7FqqM3RAg--.28552S3;
	Tue, 22 Sep 2026 08:44:17 +0800 (CST)
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
Subject: [PATCH v2 1/3] usb: musb: omap2430: track PHY references and check initial setup
Date: Tue, 22 Sep 2026 08:44:12 +0800
Message-ID: <20260922004414.4192-2-hppiscas@163.com>
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
X-CM-TRANSID:PygvCgCnR1Zgz7FqqM3RAg--.28552S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF47KFWkCryxKr1kuFWxWFg_yoWxZFWrpw
	4qgayrKr4kJr9rKasxtw4UAFn5C3s3KFZrG34I9w4fur13G34qkr15AFyjvF15Grn5tFWj
	qF40qa1UWrs0grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDrcDUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QET22qxz2GM-wAA3i

omap2430_musb_init() ignores generic PHY initialization and power-on
errors before accessing the controller. The same PHY is later acquired
and released by runtime PM, system PM and platform exit.

Track initialization and power references separately, and use shared
helpers at all these acquisition and release sites. A failed power-on
releases its initialization reference when possible; a failed release
retains the corresponding ownership flag so a later cleanup does not
double-release or lose track of it. Suspend failures attempt to restore
the PHY before returning the original error.

Abort initial setup before accessing the interface registers on failure.
musb_init_controller() skips platform exit when platform init fails, so
initial setup must unwind its own references. Platform exit uses the same
ownership-aware release path when entered after later setup failures.
Keep the PHY pointer in the parent glue, which owns the managed PHY
handle, so parent removal can retry a release left by a failed child
initialization or exit even after the child clears musb->phy.

Keep phy_suspended as the system-sleep ordering flag: it defers access to
I2C/SPI PHYs until their normal resume phase. It is not a substitute for
tracking the two generic PHY reference counts.

The issue was found by our static-analysis tool.

Fixes: 3e3101d57c50 ("usb: musb: omap2430: use the new generic PHY framework")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/usb/musb/omap2430.c | 105 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 6e749faac33c..df807ee9deec 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -34,14 +34,71 @@ struct omap2430_glue {
 	enum musb_vbus_id_status status;
 	struct work_struct	omap_musb_mailbox_work;
 	struct device		*control_otghs;
+	struct phy		*phy;
 	unsigned int		is_runtime_suspended:1;
 	unsigned int		needs_resume:1;
+	/* Defer PHY access until the normal system-resume phase. */
 	unsigned int		phy_suspended:1;
+	unsigned int		phy_initialized:1;
+	unsigned int		phy_powered:1;
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
 static struct omap2430_glue	*_glue;
 
+static int omap2430_phy_power_on(struct omap2430_glue *glue)
+{
+	int ret;
+
+	if (!glue->phy)
+		return 0;
+
+	if (!glue->phy_initialized) {
+		ret = phy_init(glue->phy);
+		if (ret)
+			return ret;
+		glue->phy_initialized = 1;
+	}
+
+	if (glue->phy_powered)
+		return 0;
+
+	ret = phy_power_on(glue->phy);
+	if (ret) {
+		/* Keep ownership if phy_exit() itself cannot release the reference. */
+		if (!phy_exit(glue->phy))
+			glue->phy_initialized = 0;
+		return ret;
+	}
+	glue->phy_powered = 1;
+
+	return 0;
+}
+
+static int omap2430_phy_power_off(struct omap2430_glue *glue)
+{
+	int ret;
+
+	if (!glue->phy)
+		return 0;
+
+	if (glue->phy_powered) {
+		ret = phy_power_off(glue->phy);
+		if (ret)
+			return ret;
+		glue->phy_powered = 0;
+	}
+
+	if (glue->phy_initialized) {
+		ret = phy_exit(glue->phy);
+		if (ret)
+			return ret;
+		glue->phy_initialized = 0;
+	}
+
+	return 0;
+}
+
 static inline void omap2430_low_level_exit(struct musb *musb)
 {
 	u32 l;
@@ -192,6 +249,7 @@ static int omap2430_musb_init(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
 	struct omap_musb_board_data *data = plat->board_data;
+	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
 	/* We require some kind of external transceiver, hooked
 	 * up through ULPI.  TWL4030-family PMICs include one,
@@ -222,8 +280,10 @@ static int omap2430_musb_init(struct musb *musb)
 		return PTR_ERR(musb->phy);
 	}
 	musb->isr = omap2430_musb_interrupt;
-	phy_init(musb->phy);
-	phy_power_on(musb->phy);
+	glue->phy = musb->phy;
+	status = omap2430_phy_power_on(glue);
+	if (status)
+		return status;
 
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
@@ -272,10 +332,12 @@ static int omap2430_musb_exit(struct musb *musb)
 {
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
+	int ret;
 
 	omap2430_low_level_exit(musb);
-	phy_power_off(musb->phy);
-	phy_exit(musb->phy);
+	ret = omap2430_phy_power_off(glue);
+	if (ret)
+		dev_err(dev, "failed to shut down PHY: %d\n", ret);
 	musb->phy = NULL;
 	cancel_work_sync(&glue->omap_musb_mailbox_work);
 
@@ -471,9 +533,13 @@ static int omap2430_probe(struct platform_device *pdev)
 static void omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue *glue = platform_get_drvdata(pdev);
+	int ret;
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	ret = omap2430_phy_power_off(glue);
+	if (ret)
+		dev_err(&pdev->dev, "failed to release PHY references: %d\n", ret);
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 }
@@ -484,6 +550,7 @@ static int omap2430_runtime_suspend(struct device *dev)
 {
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
+	int ret;
 
 	if (!musb)
 		return 0;
@@ -494,8 +561,13 @@ static int omap2430_runtime_suspend(struct device *dev)
 	omap2430_low_level_exit(musb);
 
 	if (!glue->phy_suspended) {
-		phy_power_off(musb->phy);
-		phy_exit(musb->phy);
+		ret = omap2430_phy_power_off(glue);
+		if (ret) {
+			if (omap2430_phy_power_on(glue))
+				dev_err(dev, "failed to restore PHY after suspend error\n");
+			omap2430_low_level_init(musb);
+			return ret;
+		}
 	}
 
 	glue->is_runtime_suspended = 1;
@@ -512,8 +584,7 @@ static int omap2430_runtime_resume(struct device *dev)
 		return 0;
 
 	if (!glue->phy_suspended) {
-		phy_init(musb->phy);
-		phy_power_on(musb->phy);
+		omap2430_phy_power_on(glue);
 	}
 
 	omap2430_low_level_init(musb);
@@ -533,9 +604,17 @@ static int omap2430_suspend(struct device *dev)
 {
 	struct omap2430_glue *glue = dev_get_drvdata(dev);
 	struct musb *musb = glue_to_musb(glue);
+	int ret;
 
-	phy_power_off(musb->phy);
-	phy_exit(musb->phy);
+	if (!musb)
+		return 0;
+
+	ret = omap2430_phy_power_off(glue);
+	if (ret) {
+		if (omap2430_phy_power_on(glue))
+			dev_err(dev, "failed to restore PHY after suspend error\n");
+		return ret;
+	}
 	glue->phy_suspended = 1;
 
 	return 0;
@@ -571,8 +650,10 @@ static int omap2430_resume(struct device *dev)
 	struct omap2430_glue *glue = dev_get_drvdata(dev);
 	struct musb *musb = glue_to_musb(glue);
 
-	phy_init(musb->phy);
-	phy_power_on(musb->phy);
+	if (!musb)
+		return 0;
+
+	omap2430_phy_power_on(glue);
 	glue->phy_suspended = 0;
 
 	return 0;

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.50.1 (Apple Git-155)

