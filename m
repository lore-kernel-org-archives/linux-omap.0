Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EC3AC17;
	Sat, 10 Oct 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649146; cv=none; b=tspkmonrdCP4H2+BA0doDUec7yiA6GFNkdeclPPVbW7rabNGNgsR1cZk2Y3/Du0UPRizjeax+AmvdH6qcuBCw8Tj1Fmt+x4fN6jBEi96COQmoWxXViIpmOL9ppJTv5jvjnfjtT5kCzG7I+eCXtByYQXihllrjgils00Hb+hLuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649146; c=relaxed/simple;
	bh=fGo0ENJUfeMBImXgrDZx5qB9HxEPo7FMx1opDzrkJo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKSOUjvRaCGdY5z9rExl6gHNSt3QVC4R2QAh+g+QvrgNPi9+9jUGHkR1UaF9BGC3Y0V3BsKA87+NFoDZspsHSCMHlNNObxnyHhWZmKRnna4452Mf0HP7bgCHBctEAhlrU0QAZ34aRhusc7GRj2qvu0cq5upG30OZXSaFErMBdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ksl6Ix34; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ksl6Ix34"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 77C8A807C7;
	Sat, 10 Oct 2026 18:19:01 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47OIXOBtmTSa; Sat, 10 Oct 2026 18:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791649140; bh=fGo0ENJUfeMBImXgrDZx5qB9HxEPo7FMx1opDzrkJo4=;
	h=From:To:Cc:Subject:Date;
	b=ksl6Ix34rrtexVNLWo/x4C1BwXveXOnYtRd/rcTti0GrXYjcPQIJdtjZts8pyw6Mf
	 j6hXgopOc9nnBeRRU5oM5EuAZaMK+sSIN024pxl3alr7gLN/FhMvSNCNkkP+wOFKDt
	 53j07cv2zRiFRtxb8hZn+q/gAFBO6BLdRVTT+SApNQz9pcptk7jIdDsw1AY36cPkBo
	 rYTsgYT/u8lKTFa3zWr3NoOnrfoFxOR6c8Vmo0HTMZSnyQvPfLv979R3Xpwjt+G1Mb
	 SD9xdftlHszViZxnrkzHT6yMWH0U4kc+456X/Vf6akN+JBbze0CcRN6laB8K9Zqnsr
	 VV0x/2u+U0Kdw==
From: Rustam Adilov <adilov@disroot.org>
To: Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH] pinctrl: single: add big endian support
Date: Sat, 10 Oct 2026 21:15:44 +0500
Message-ID: <20261010161545.62959-1-adilov@disroot.org>
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
 drivers/pinctrl/pinctrl-single.c | 41 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e0eb7240a985..001a0c157d6a 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -265,6 +265,26 @@ static void pcs_writel(unsigned int val, void __iomem *reg)
 	writel(val, reg);
 }
 
+static unsigned int pcs_readw_be(void __iomem *reg)
+{
+	return readw_be(reg);
+}
+
+static unsigned int pcs_readl_be(void __iomem *reg)
+{
+	return readl_be(reg);
+}
+
+static void pcs_writew_be(unsigned int val, void __iomem *reg)
+{
+	writew_be(val, reg);
+}
+
+static void pcs_writel_be(unsigned int val, void __iomem *reg)
+{
+	writel_be(val, reg);
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

