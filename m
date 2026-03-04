Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29653A6EE3
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633318; cv=none; b=GIOSAGuSIBDvTJ+DQ9XKU2yBoC8wOKoVKXWqQOPtxlFby8CnMGJei3Jkh7MSGCrbJWLputmfBUakB45BTPzF10gV1KYLe84IkJuHJ9yKWSWdslB4Xeg62f76IsnuvLvM09EFT6ICzzfiJN1siPx0Bk/2vL/S7lI6wmFaunTgsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633318; c=relaxed/simple;
	bh=mXK/wuVbL2lWEcp+yVdrQP9dP9C5hBIvBbQ4WfvEi58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxL/VsEr3fMBrYdymwAoF5I1kgQO0x0q+8SZN5KXh/5+xKa9/dBxzXjjuH8zOBj672Qi+KrOmuGnscsqgYJ1GtkapzJ8a0iGtgn51eJ2AVqcjiIj9ZrkaUoR8m1NvQxvoGrazm2oRApjV+SQqQV60dIYBRR9ma4Wz+u43eLHVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/kcf9Qr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/kcf9Qr"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35995cb33a8so1693410a91.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633317; x=1773238117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zjKUEALhh3sKzrRVkbw1XSt9/jPsMcJZY5h9AuldV0=;
        b=h/kcf9Qr0kA/T+StyAePzfdudHDzBmt6t0hxJH0NBCD9THmzxdFfGDcsAsj9dMKU1n
         k5XEg0u88YpCos34oPQiZtfsElI082N1pcEimIng5NupHHSRX9a86Tx/h7Vozghpb1V7
         yHNz/VGovUux8DVY2b4L9sSN/w60MYRCwM5PpOZFEcQLzfgRI4aS4CLidlldE4rZdmEW
         2keAzvbzwONbPi0m2b2D09tC2v8NjdprQQFn+Ue/evS/CUsKNQIWjyVrkotWhsMfzSoL
         MJbnkFuHgoI8b7zUMdWdO+xo4qBcJLPc8ZHOMQpEX8SoHzFaID8Z5TllIcH/I3NQFLnc
         WPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633317; x=1773238117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zjKUEALhh3sKzrRVkbw1XSt9/jPsMcJZY5h9AuldV0=;
        b=qXrsoG5vE1e6zoYrpYf9Yf07SAgyn5exWCazuk0w1m1g3Ri5Hq+9Tn9bH9a6zSyZ9n
         lwH1VxeTDqgIPUQWuWP6MmXJIMPzp0se0Nb6Ga1vBL0CyrnSCVVD2YgZo2oUFy6ivI5C
         rJoyu2a4QzioLp1JWtDO+43RCr3cRaTvZDL0EwzsvHTMvJUfy5kjm0HwXzSQY91waNvx
         ZyFg7CjTediNlcUq3tGS2rc+8Rf8afLDS5zZ8/zj62orSjtitDmwkJ50WmEFQarmo32D
         lbCgWT0ek0DUmsCy223RdirlUKCZ9rxZ9JNcDhGtayGVf/rz6WOCeGTGyxV0yllPJyVn
         Tf7A==
X-Forwarded-Encrypted: i=1; AJvYcCW4zUZrUDC/TpXwdqp1goFudQ4s3OubCActwBUGqSnaUnAIIUA+EystS9zX3j064m/4+iBLdUgqKBOL@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhkupE5Pbqge3Se9ffHvWs5CS0c8C8TkuSrKeJpBalqyv5Zwo
	mu+Ozc/r8IctA8aRD3MKIpZT1/Vctnq0M/zuLASWPya4/oSdFXBYOYNi
X-Gm-Gg: ATEYQzws2WLLSa7ZVf0FgU12gpiY3gNkykrBg/6KXnpy0rvVReEkwOWTgbaqv94wQYK
	zKKu50L3PuSELYmrh1Tbfw2PzTZTijKCk1qiMVBQjCaLDXCcPSkv0abizEGcMiCcc88HEoQs8cZ
	mA6dADJJOh3gVEGG76r6TRYCBrAEcMtPeSe0jMxuOmRi6jGEoByNTojpCuhy/9xmMoPPrp/HIRz
	J6ihpUJdWd/lDLvulb7OaIwpWHRtBLZqc7xh9GZj+24vVv+eKvxWiR9KKK4mHPaBXuG3HC5X3EX
	OC+abiWOC7kapwHjkRgbp6zuWR0lwd4aHMAr4vxa2aBxEoYqKBoZUjGtw9D0DXf9hwDOVKcLLj0
	W8+QhAXYCLCyyPuQ6fYKR0Fr4+kkHXcG0EzorwIn+9kQ6taZAcmdExPBRH9CVf+HQRTxvBPz43l
	7rkYNos3j6IYQ3ZPRzSABO
X-Received: by 2002:a17:90b:2d8f:b0:359:8df1:8553 with SMTP id 98e67ed59e1d1-359a6d8521amr1962255a91.9.1772633317107;
        Wed, 04 Mar 2026 06:08:37 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:08:35 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Niklas Cassel <cassel@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Koichiro Den <den@valinux.co.jp>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vidya Sagar <vidyas@nvidia.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list),
	linux-samsung-soc@vger.kernel.org (open list:PCI DRIVER FOR SAMSUNG EXYNOS),
	linuxppc-dev@lists.ozlabs.org (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	imx@lists.linux.dev (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	linux-amlogic@lists.infradead.org (open list:PCIE DRIVER FOR AMLOGIC MESON),
	linux-arm-kernel@axis.com (open list:PCIE DRIVER FOR AXIS ARTPEC),
	sophgo@lists.linux.dev (open list:SOPHGO DEVICETREES and DRIVERS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-riscv@lists.infradead.org (open list:SIFIVE DRIVERS:Keyword:fu[57]40)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 06/18] PCI: dra7xx: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:49 +0530
Message-ID: <20260304140329.7089-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304140329.7089-1-linux.amoon@gmail.com>
References: <20260304140329.7089-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Establishing a PCIe link can take a while, allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d5d26229063f..be470d54b2ee 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -951,6 +951,7 @@ static struct platform_driver dra7xx_pcie_driver = {
 		.of_match_table = of_dra7xx_pcie_match,
 		.suppress_bind_attrs = true,
 		.pm	= &dra7xx_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.shutdown = dra7xx_pcie_shutdown,
 };
-- 
2.50.1

