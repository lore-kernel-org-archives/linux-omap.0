Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10234381AEC
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633368; cv=none; b=iT/b3QwdPusGnSDEGNvwrKplwau0JGcKyNOYjBy3b/ily8aNQrIQzFuQGOiHKkYjP1+sP+YSIvqVQI+EtNVP58D1uL2tWKLRaN3FxtrtiMdvCxsfp96UTO1yA8zGqaSDivgGU8K3CV85e8IjLxP04BA+/o6eZIsIMrqrGFDySrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633368; c=relaxed/simple;
	bh=BgfoZYz1aliRBDgJ1DdD/5E6heRlZbhIb6uE6aX6V8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lsjr4smrqsQC0tyJhBVtvApOMJ5nEOwcnECKNod5AECBc7x8EWdDB3bG9fEryXVIiP9TsIqAttQqofsu5dsMDWnThTZVjCDG2C4x95wFbILFK//b0nCZ7r+MB9GeoD97FaLt6RacCzaenBNgDFOwQgHuXyA8UBnLAN9MJGi/MVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN+Refc7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN+Refc7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829781b2b01so264553b3a.2
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633366; x=1773238166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrS7ZIa0rilgM/jlzfLJJeKLRZ0Q0OYSRBkIhGwwFqw=;
        b=cN+Refc7fn7q43LlZwDVfyzC7ROxPMcCkSfQ9UnWYFa8xB9+s4psaCBMgpNYEAQEDj
         3YIM9wjJkJPraQ0sgdEhp9YRmbIkvnt15XLh4S9e8INGR/PX2vujBZnpxnIM9FQHfO98
         HukjkUSzXi4EVD4+BV0wNxBazf/u7RGYv2PQclUwdocI66/bzBtjoKduFQEFtLYGgGhv
         Zk2iVfuYur5LLhzXb4zxxR4gvDEJPSprFGbM/ammE3ejF+eqCdtk/Ut5TC6wTW4gs/h2
         S+CqeU+x85uJK+/o9Lu11KXJ3e7PWYvFYI9mFbcr8lUTlJU6kJjXsB0ZpQBpG0yrHPTx
         BpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633366; x=1773238166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mrS7ZIa0rilgM/jlzfLJJeKLRZ0Q0OYSRBkIhGwwFqw=;
        b=FePJ7fZ8/YaqR5HGMCAqLFKmU8AhA1cOoH+vak0U8mOSD2lJZ0Jm+bKXqDaGmYE96B
         Rzsvf8SF5r+1S9vHkrLAgesxRebcJ+DNTJ+ovgxdl9l7zTgvbp+2EmP/kBM6ZhChl5lx
         w6JjZbbxp6T+SAdRwpYBzbcyklMUYEEaIo+EWwF3Z8725k94sQzsQiqwfosHJx6ZCUmz
         3ZdNNerJ0KdVjQxsaC1mHRfoMhyp7mJnzN/DNNfhf7X/8mb3/LxF636upzIj1aehy5sh
         STwwmPT0ZQKwrW0cLT9wpM/Zsc4bfMkujHhwUK8jVapmghbsEX7XkuQ1c4HoVWwwhwiM
         4N+g==
X-Forwarded-Encrypted: i=1; AJvYcCXnGvtJH/0sUl5jPuBDGyAWRFvh78bPgxHP4qhznjwokVyEeCPnebPHVqgahKMMAng8yBpGbfxlRNmZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxEN/qaF2K+3SJ+7jqWvZn/FKEzhRyHnAYpa7MJMAxOCZz9dRwO
	dWUpCGMMOKUPMSQHV3RHyPhFnzHBvzzWjanMCklha3cc9pDXV0937mfW
X-Gm-Gg: ATEYQzxPromYQc1gQz2gkysorn2s55Wn4PKhmYHvEhiFQXeW0gdez8l3EUxJnjIzmI/
	cPdrkt88hpmvGudVd2pOlRqyae8xc8vozQ4e3CEZeORdSR6+IIwc+mo5GyNjobqsk0X8JEzYG53
	q0rI3f2ZaF07tJNab6h7tVwxnO9zYVmelJl00yMDIK6saqYYekqwaJXqcqy7M+HgMtaPSFtvMWj
	hjBzClwViTh7rJsjZTq9jukdMWoKpvmqKrdNm+8z9CNg1fd7uPdCkOQVi28TOWVocYw9FtS5+p2
	KDkOk08xG6z6kcWE45m2M8K9OzikF/IkLT9L+UbVwHLiOQ8yuIC2A1E/XdjWwSTGqzVTJ0ghRtt
	lMAOc/zhsSmNQprvsy9y8tWG+DdmZBg61GTp8/V9G3+XppTOMLD73iEkt8HpTWrNCOB55GoP/Sy
	wUGhSmveabnJokF9epboJ8
X-Received: by 2002:a17:90a:d00b:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-359a6a7a0a3mr1687183a91.27.1772633366451;
        Wed, 04 Mar 2026 06:09:26 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:09:25 -0800 (PST)
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
	Hans Zhang <18255117159@163.com>,
	Koichiro Den <den@valinux.co.jp>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
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
Subject: [RFC v1 07/18] PCI: exynos: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:50 +0530
Message-ID: <20260304140329.7089-8-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 0bb7d4f5d784..ee2423e16b58 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -388,6 +388,7 @@ static struct platform_driver exynos_pcie_driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,
 		.pm		= &exynos_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(exynos_pcie_driver);
-- 
2.50.1

