Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD23B7B9C
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633464; cv=none; b=CQk4AfUsomW/XmwGoztaFGdA4CVHdttH7DBgsTHeGAe43n7d04+uIMBe6QB5WpOj49Jn/AV8Knzv/9aawA6IJabe4jFZRhR0Xaqya0RCB18XA3vdHXcZGqZaiJq3xNhXyI2OilSFXBcQCWh/MCu3CRIZK/Eat5m3uIDnKbQgGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633464; c=relaxed/simple;
	bh=dGHDNG1M30BMwVefPBCW8ENkGd1Eu9rEV3i7SZBHTKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoCo9wKT+S8k/xISeGtb+NjseZWMbz1y1T/l9BDHBMLEL3BjS2wF9CMcwDefDCU/b3HURVojOhZLXvyh9XOg7xA+v9qec4F8Qv9dP4kBl0AHvjScspIC5eBC8BE1RRDMZV0VaCO4nVCDACTbGFM+JkMX0UN7kpwRIdJZAKMP9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShJEYBH0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShJEYBH0"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70e96737a5so2195532a12.2
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633463; x=1773238263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eksk2NaSU09NJtKXet9GHYtfaMBPJpP6oyy4wD9BvXA=;
        b=ShJEYBH0UB9Ray7VjyXCHI6fyNKvIlHbA+xrR4m/AGdpQH2whwgI7uRmfUjLqxyUdj
         IeI1kvLuJv9pZJ74g3sCEe/QyLPURPuMRjLJsXRqFf0VqmYQHgBMeLJfE7Ed+Pa6+NmH
         7XaC7sKjPG0DFY8sBmb/PhVT42QxtSVW/dLCLJxvpEnJiQWVcC/WYzmz87J7GM0vd0yf
         B9BKoTN4y/t5tWYOftwMt1K95cAWTSiesPWDtyr8t/GrC5tO6Z5e14GxLPWD6RBAuYVA
         e7J/VkSCwUASaRdb7ckRv+elx4KddU4ns/y5ya6iHk/fwL79amP8+rX5D21o8gq7iVBy
         npPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633463; x=1773238263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eksk2NaSU09NJtKXet9GHYtfaMBPJpP6oyy4wD9BvXA=;
        b=DcUYuJiFyqEAIXElH2TU8BMXHv+TLOHAu5gwaUY3/Z5lJPuKVypcigBgkp6WAI4osl
         I7KDjCUNAuH8uAc10rBGU13H4uVV0GRr3wMtV1svjLQUiHvNZJUpl8LzjcbFrTGEgmzW
         W2C2QKtU5p0QfKBKK3I/Jl6C8ZLW+pwR53MhPlrtKnEney83/n9CIrHH0N/RcxhgPdEB
         kjt2PWJ2wBhdBg3/Ojd0u/3m1KfyZ6JMbhSbR8iHYMngr2gUPA2XYLOQg5hydT9PUHZU
         /c44HU+SZVnRflyaO5+jFnne4eWKY1C/6tmcoWCcwUPyhMViWuli/GrWc1blw/ryrTs8
         hiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqVNfMYKraxcyVz0htzmTiYB5JGBikhK/jF4Intt1Vt3RgOSe7RzqAotEBR6v0Yu/Z7+f6eAddhDv@vger.kernel.org
X-Gm-Message-State: AOJu0YxTv1bwkk32pnjTaY1nvwLTJjcgjr6Rbxmd0bqqpiuo97l0SI4C
	N+Ci7rrkNG8x3b1TFOolUKqplK0jMYK0X42UKqffKR6wFfq6WT6O/2eB
X-Gm-Gg: ATEYQzzF+UPf6Zy3u3rORZRRcguLpAUaGe5XoYUUoXCPQiQ5c0MYpBzprJcQ0pMWm8Z
	PTld5OBv0uKZBx3ODfDa3SEGMdIedPkGBMmzTDQWGvPScdLcUoY0dqIzdhkeJ75j7/KJOk1oBhl
	MqFJLaBkhgBwggacWqyqBZpD7toYaD2fBlYWWu4v8xO2nPqsl5SaqE05/YiaEStvDxIQLVMYxz4
	jAUB36Yi7hm97md/16XdyKXZ2WNMOeH5RKNGMo+YzI6Xku9ILqh4ugjSDCn3XNarP8qNTdvnuLt
	4tXhjuXK5KsvELB3XFRWR4Vz2IKIG7l/SOB3CHjiI/jVIamI4WQpRlBK6R7g9o2kSObG8hdT4Gq
	mNHL9jzMjkG8Vxl9Uq7WZGpD2UhiAjeqPDeByIbky4eJfdsTVrDsSofXICo1ssGuPtF/iJRcBsZ
	cHF+ersfAtOsQUsu52Scg3HIYV6QoGczE=
X-Received: by 2002:a17:90b:510d:b0:359:8c63:8ff2 with SMTP id 98e67ed59e1d1-359a6a4f880mr1548752a91.22.1772633463114;
        Wed, 04 Mar 2026 06:11:03 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:11:02 -0800 (PST)
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
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
Subject: [RFC v1 09/18] PCI: intel-gw: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:52 +0530
Message-ID: <20260304140329.7089-10-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-intel-gw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c21906eced61..bc5d96dc12bf 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -442,6 +442,7 @@ static struct platform_driver intel_pcie_driver = {
 		.name = "intel-gw-pcie",
 		.of_match_table = of_intel_pcie_match,
 		.pm = &intel_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(intel_pcie_driver);
-- 
2.50.1

