Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58C3914EF
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633802; cv=none; b=d7EhR/KMiw5HpPlk9r+0Zw+/XMUeF9nMSEFT5mIT0eUZ0KtgxFMteGieSAb8QX12yJu6QZ1R2ARI21Dadv+prwfxHO8oCkfDFS6ZSpWFdNZzVLMMkdC0WX1IMvd+C1WasI/tfWE8Xcm0C3EblDcSsPRw5v4gqPb7V5Y/IbEJ18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633802; c=relaxed/simple;
	bh=AAR1uDouR8gmyuDZeOFLpxM99huHX4k3NzQIgrMbcCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXnAB7lkmYZ0pOqn6p2zs9sXp9mCLYurfOb50anK/m+hXyOdcp9Xmskck9c9ChNwVwd+PApzdU00ZZnAGQUdUNfQDV5sU2SOAorg0XcQE/KLu5K3/ue5VrbKEq4WmhVezzwUseIp8Qvz+Sc3DPJps6Y5Z84HwvoVx99GaGYRCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECvJoJcZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECvJoJcZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3591cc98871so3036819a91.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633801; x=1773238601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDjBy/zS51mD1PxaQ7mIKoDOiKAIHa799oQhdGW8t+4=;
        b=ECvJoJcZ6LU9DSGltASg+kMYcIa/VBRXIDiDG49N2FQ+m1OL16FVP/J/LlCKsdDSe0
         UZ4FMPONV8SXD/GHS2e9pTqpnb/ch4kVBOoZ7REhClw/gwKZSRaeJDn9eXQk8rqNp4Dl
         L+Lh5mrL5tjVEByXBR1BEb9lI2X7Qw6HbR4zUpR6KjxzCbgSwEYQZ82TYJZOIrYWRFX1
         UdcmnM+gCuK8q5pZAJO1oyDox+R+/jGH1kJE3dr5nQT3tZy/IHYDm14cydKGBJH3qv6u
         5d7fy2Gwn5RZ6VTFyB2q+O2D9vvkpPHsnWQ4Cyi4HJ5ewrRyHcdtwS2qRfsOQSPKwIhx
         ZqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633801; x=1773238601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDjBy/zS51mD1PxaQ7mIKoDOiKAIHa799oQhdGW8t+4=;
        b=balCuv+9gzLftM874Qxj9TALGfuzbCsSr18xrUHT/V2hyfUMMq/8+jQ2UVRTXtNyn9
         xVuMd8wBHUCeb9bwhly3wZF4k++XZaU6T0pIQHsjiZ2wOwJMfrv/GM4ChxVMORbeq0tU
         EZTU+FWEAtSaE1RUgNYBtA6BXkQEP1xZD5E8/zsIETazitTgT6kx7YDsH5KRRWYfv39s
         BRxiQah4v2gvAlftfWa2d9QNkbLvLddgtQ0jOUSMuQqZY29UISXhLh4I9xBSmERO8hDn
         J5f9kRnhKRzjCTsCjJvoqz2zkO3nm4pPSY4uBhEYB4RqupGLkw/TS9EMJfzO5zooDHvo
         WKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZQU4gaeBhdZpkyblqrKVLKPz89BpdGphtr3wiXOnrtNu81+lM588f2o7zIPIuc+dqFLFfHJVpkrt@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzDANlWfi4AcRJcW9TI73S6hf+WitnMRdx2LtNGVdnNgut0/s
	424GWwdqq8UTeKB1qMt3MLRi3QRxF8FclaI5BnWvPDoOketuqO/cb55V
X-Gm-Gg: ATEYQzwiRPi87qVCw3XzH6ZCZBHA364mLkHDpFJm+a4gFsV4jm8DipbjI1AvYjd0/Hj
	7+9ihtFjl6JcwT8ebGMCZrA195HkNeh6YaD+xaYGZua7VCScJjCROEONByDccRwcE+0noqvcRMn
	XX80hs513fyju9oqPD85R2yz0vJ6PH4sum0cKzD0lUhsbW73VhIr0nKbqLkB2j9G+Qwk87LuBh2
	uKtMgQhJQ1Fz0Nbsug0oIYKufdDfbQX0Z2AhevMP64cBaQpeMZxYlG+ScIm8zIEwy4XTozFLFxx
	scvvTsga6WCZ9t1Du00r44S71/Q0e1NVUnyJgYaULn+/qjbDIgYzCWo2foCs3WP0opKJwHeCMAg
	ohzQ5yRLnE9sqRRPiMqO+B+Ta0aJxGUnKGhnenK0h9aE+zPO+q52Gx7yKyXxLVmIfWTwAuXzPD3
	Y6Yifl+HaYs43XEzISv1sV
X-Received: by 2002:a17:90b:1d4e:b0:359:8f84:ad8a with SMTP id 98e67ed59e1d1-359a6a88709mr2213203a91.33.1772633800980;
        Wed, 04 Mar 2026 06:16:40 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:16:40 -0800 (PST)
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
	Hans Zhang <18255117159@163.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
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
Subject: [RFC v1 16/18] PCI: tegra194: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:59 +0530
Message-ID: <20260304140329.7089-17-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 06571d806ab3..7381d0019d24 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2493,6 +2493,7 @@ static struct platform_driver tegra_pcie_dw_driver = {
 		.name	= "tegra194-pcie",
 		.pm = &tegra_pcie_dw_pm_ops,
 		.of_match_table = tegra_pcie_dw_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(tegra_pcie_dw_driver);
-- 
2.50.1

