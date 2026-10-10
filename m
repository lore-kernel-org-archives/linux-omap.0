Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F0352032;
	Sat, 10 Oct 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655070; cv=none; b=E43IcptDpikCPpSky/bsV3WuQ6XillvNQlRbvCEl7I52MeDhPE82QF6s3EmajsH0BzEFu5Pa4KsBwTXhCZLrZB8/qifgQS91o3TZ86100tzxHI2gwk2jE8Yv13C+2k2HngAJmx4mEkLtCdKKeCLSS3Um8B1xC4tHV3V0dkCsm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655070; c=relaxed/simple;
	bh=amUnCp8nO/3YDfeN8K6fzquoB8WYxfrrFRaRFx4B9xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdMAbFThcDhDYsQaKeVGjzb1vVu6/IKao3AfjFp4eUJk9xucdqjEClGvk7CBbb9AclfZG495455ao8oZRkg8E1P361S7Z49EzFW7Dnr+OZI/dInPMbm3cOi7tm5ITYtUfADQuYrNjh/jZ8wOxLmQxeCY62YLr8oaXugddPZfq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MrP3MGdP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MrP3MGdP"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B16AC82A48;
	Sat, 10 Oct 2026 19:57:46 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kf6abI61CVjB; Sat, 10 Oct 2026 19:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791655066; bh=amUnCp8nO/3YDfeN8K6fzquoB8WYxfrrFRaRFx4B9xI=;
	h=From:To:Cc:Subject:Date;
	b=MrP3MGdPHBjQqW2QKx9m5v0deClKQfdcmK9LQJneCnlLX4dTiA85kW4zToX1+OBgD
	 Nv9UgAbpa9n2NCircHWkpemNXlfDVq6KT3W+y3m70soJDjfWUiROTlF765U41wPJbR
	 rEgp1So5JXacGgX/2T7XyxQ3cdwcFmnHgz2mGopEpUmU+CCgXcqRuBzLe0iP+yI0bM
	 UnNwVploy6zqmmYbu9O+1SBhkyBp4igeVfniPt9s5AB73itopgu+L+HTMO7/0QzLKN
	 39GJbZlzhF6wcz4xjYTCVRu08gt1UudumKzPBh44UkTMXX8LP8iYVFWcPGqOuZrtyO
	 kcl9jwQn7YCiw==
From: Rustam Adilov <adilov@disroot.org>
To: Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v2] pinctrl: single: add big endian support
Date: Sat, 10 Oct 2026 22:57:21 +0500
Message-ID: <20261010175721.76213-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for big endian pin controllers by taking into account
a big-endian device tree property.

This is needed on big endian MIPS platforms like RTL930X, RTL931X
and RTL9607C who use pinctrl-single, because when SWAP_IO_SPACE is
enabled, the mmio accessors in pinctrl-single perform a byte swap.

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
Change in v2:
- Change to generic big endian io read/write functions.

 drivers/pinctrl/pinctrl-single.c | 41 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e0eb7240a985..cdfe38f259b0 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -265,6 +265,26 @@ static void pcs_writel(unsigned int val, void __iomem *reg)
 	writel(val, reg);
 }
 
+static unsigned int pcs_readw_be(void __iomem *reg)
+{
+	return ioread16be(reg);
+}
+
+static unsigned int pcs_readl_be(void __iomem *reg)
+{
+	return ioread32be(reg);
+}
+
+static void pcs_writew_be(unsigned int val, void __iomem *reg)
+{
+	iowrite16be(val, reg);
+}
+
+static void pcs_writel_be(unsigned int val, void __iomem *reg)
+{
+	iowrite32be(val, reg);
+}
+
 static unsigned int pcs_pin_reg_offset_get(struct pcs_device *pcs,
 					   unsigned int pin)
 {
@@ -1785,6 +1805,7 @@ static int pcs_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct pcs_device *pcs;
 	const struct pcs_soc_data *soc;
+	bool byte_be;
 	int ret;
 
 	soc = of_device_get_match_data(&pdev->dev);
@@ -1860,18 +1881,30 @@ static int pcs_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcs);
 
+	byte_be = device_is_big_endian(pcs->dev);
+
 	switch (pcs->width) {
 	case 8:
 		pcs->read = pcs_readb;
 		pcs->write = pcs_writeb;
 		break;
 	case 16:
-		pcs->read = pcs_readw;
-		pcs->write = pcs_writew;
+		if (byte_be) {
+			pcs->read = pcs_readw_be;
+			pcs->write = pcs_writew_be;
+		} else {
+			pcs->read = pcs_readw;
+			pcs->write = pcs_writew;
+		}
 		break;
 	case 32:
-		pcs->read = pcs_readl;
-		pcs->write = pcs_writel;
+		if (byte_be) {
+			pcs->read = pcs_readl_be;
+			pcs->write = pcs_writel_be;
+		} else {
+			pcs->read = pcs_readl;
+			pcs->write = pcs_writel;
+		}
 		break;
 	default:
 		break;
-- 
2.56.0

