Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856D3C13F5
	for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411295; cv=none; b=iZa3WTIGwxvyhW/0lW3dqJDRsS13iQR3+e053Vn029NwULlJniQdqveO2MIlUOE5XRPiSCH7avUUMo3ZQm62DpGgJLUfn15F8xa4BTHZYkYqTGb5YuKw3HSPsIJuGKWu05/FAI/ZvoEKV+wMZrd0SKq8lGpLb9Zgjav7u6IAHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411295; c=relaxed/simple;
	bh=B23Kydln9+sFNwl/EddPsXeSNGxgpJc+Bv5D8Nfp/CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnybP+/62KPsz12rOpr0dZrKANwyCjCEk58hjBkdnJuc9afvVDAFPP/sQgAiuTFfloGHz7UCHVHBr3Ko2Kfxx0fUgfV7bTpTvErrbD5+oHcZSHM50fdRsStr3sRxNTnXL8zz5o6mtyzTAVnAlX6oscTT/bhvfRMK7nXCShVF8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfroaLax; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfroaLax"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84830c774a0so2291725b3a.1
        for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2026 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411294; x=1788016094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/zhBj9KsrWu1iz3uRFGRfIc5hKkqLHf63XbozGChRc=;
        b=sfroaLaxYUfoSaeQ/atwN8JuYjCSALC9mC5xCx6sF+524JQ7rfY5vLRJDlHMq/Y5db
         6vDRF4NerW6nLO7WcoHY/my1AOcIp+pnKy/6UecV9c6B/EpgueiRgyhbSezXELfiAaJ9
         iHIit0wlX+NMT+piVs9CFbsQMkuTA4WsLsM/pMt5kjMt6I10jinjL56ULG17iRWDWuB1
         CuF7KIeeG4hHly9Meo9sPFaWBiO+Nt/rTZrh14MjCeQcRGIVecmyEZCEqL2ncsAJ/o+/
         WRg6d0LMZodoG6FMUJXjdHfEpyvM2RbuHzZN/7y5NOblMd5DASfK8aZVot7M5nK+1K3Y
         G6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411294; x=1788016094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/zhBj9KsrWu1iz3uRFGRfIc5hKkqLHf63XbozGChRc=;
        b=GVGbnljaIvaJe/r3l72wp6+swtVb8sOwDIpnx8OhwKXAJ0f7wwyxKhqm+I0T3x80JQ
         PxV07+EMr6itjcTMUYhxu6I+T9+NcYpeRtkmdS/0QHFC5JQShHpmCuR79VoovKyzX8lG
         q7Ar6DHPNVNXfAyKFQQ9oaUBULHmArTLwpVi59m7KaPZefuCF5MvV/XaIOThKrkRzQXu
         fzUVuDe/XMrVjGsSp5N4eyiahx6zPzRqVbq16S2CUa6frsk49MgcOAD5Q0L310qW8nEM
         RZm6rTfm+scqq31bJXMQW8r37bbPn+KriCYW7xwFbHh/VktoKaCn33wWmVzHwCKJhjUX
         R3dw==
X-Gm-Message-State: AFuF++kDeeTh7579/szuag/+gcBL+Gjp4tUjhsGX1i4i4j6F5DSnW5AC
	uNWs9kFMfskA4HA2RCfSf/HNqh7jsStcsGiNyw9YZ36el88lMBih9RXMe6ocXuPcHwQ=
X-Gm-Gg: AR+sD11jinFV4qbp2vS2tT4GB7qZcFMOuZQf6Svh76RqZRUYoQTBdK+L1FmbKGCLiql
	X6Skk1RgkxMFltjg3SWgT5F/nW1coPdveQsZzP6AIpgAcb9VYW2h1tFo78G9Hnp5LXsMBe7/aDL
	x7/zjLPlyxTbwTq0RxXdKKi6Xbv557py0d+i9ExjzbiaIdnyH086QI3ZGpr8AoP9BDFIQBcLmtC
	581H/u9aiiWzLtfSk8X8FZ1P0kNliV0H19FFGggqomIFwPBRrOHWeiAz5n0DLgCWvkr4BDF/4L1
	kEuHGVSu+rtzgBGxIY1MzdkxX+0zkSgDn8rwUUfefXMUW0MiY8PNWU/DE1AyV8QQ5XOu4qXOU+t
	uVlH3f9bMSS2IQZu5cHBB/Fi/gEuhHSlvhrPyeyR/soFnRYNHiEeTvN5Hx0D9LlYkZ43ndcxJnp
	jutPXzA6p13kGeA5aoY17MM4/NXnjDCLIOYf2pm9HYwAZi8SIEYEGxBKzw3sXp+fUER5Ordm+yr
	xorzkYab+fBSfvnfywvyy/9zuVXqWk0Uc6b94YNoTiasi4u45uB+cTP
X-Received: by 2002:a05:6a00:14d4:b0:84a:2fff:cef9 with SMTP id d2e1a72fcca58-851f9f84b8emr18586843b3a.13.1787411293482;
        Sat, 22 Aug 2026 08:08:13 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b1ebsm628242b3a.30.2026.08.22.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:08:13 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 22 Aug 2026 23:07:48 +0800
Subject: [PATCH 2/3] PCI: dra7xx: Fix device link leak when devm_phy_get()
 fails
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-dra7xx-v1-2-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
In-Reply-To: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787411275; l=1121;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=B23Kydln9+sFNwl/EddPsXeSNGxgpJc+Bv5D8Nfp/CM=;
 b=TX1ESX7RK6u/H0zkVg6E0SCFWHpFzbnS5YCn4VL1Y4bMfduClDLmt6rcMJoaUKwAyiOBXMhmO
 cENEnoJzPM9DLryFJyE8Xfafq84ILfLThjpcV/5SGBtHXPuUruKAjOu
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When devm_phy_get() fails, the code returned immediately and left the
already created device links behind.

Jump to the existing err_link cleanup instead so those links are
deleted on failure.

Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d43253f7dea6..bf32b14436f9 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -740,8 +740,10 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i]))
-			return PTR_ERR(phy[i]);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_link;
+		}
 
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {

-- 
2.43.0

