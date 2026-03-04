Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9923B5316
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633077; cv=none; b=qkHj2CXGsCq003q4UfPB10kl77Z0EM9SSiYeGoPLEV0xrfxeBfbsVvPp5qp001Vq5aeVhe3o/67du68cn951jWCbGpsbIwNaIwDqYkIHHOYoopFFzX9+GxlMri3gkMkxpMMf8rk7ba4wGcrkXa85cAyWUQKQSFgiojZ1Pf0YDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633077; c=relaxed/simple;
	bh=fysw4+7uigVqwi3HpSXPiZOY0cBAcQNqSX3ljElSVyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/fvHRC39TgZsOtKWlLYB662uQ1KsIpegbvvnWzr6V4MGC0A0BGz8pG/X6tw15GMEsDJUbdcxF+i+8cK3BL6ROZflOirI0TOWnPsTBMpSWZ0g4xqOB9wogk8gV95Korv80Y+5QE6yPHPGwU+n/ZrMkmRohqo7Rw9hwFsTI6K3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P82o5M37; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P82o5M37"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-359863611faso1495446a91.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633075; x=1773237875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HTAseI2RZvMiSq6piqVCjZa6XAi6fGRFqwpnmtjoWI=;
        b=P82o5M37MaotPz1tYMfxW+okAT85R5oHUFQ7cIRyQEvuZyOEecLcUNidCseyoIUcLZ
         GsaHIWi1+HLYqxoEq5aufiOe1uhk+4JgzK+A0sJPXP+G6+tjwRi7LDBJqM+a0nnfzuia
         aVwG8xstGLERkT3TUgyE4YVpd7GxZAMXcOlDYMCYDxxObv3qRZjbzsUJsdacoGZlPUbJ
         Rhlx6uR60hSE38luVxLa0T5J2j19GPNtSO3iKMrPPBqyMb1/EAkqPPJ7kLCWxXvpVeT4
         WYJJdWwfyeDqcocTU653UbgptobOy8TmqCqY6yvUFfm/QzFgVjHBQHMyU/5etNjy7kOZ
         5giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633075; x=1773237875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HTAseI2RZvMiSq6piqVCjZa6XAi6fGRFqwpnmtjoWI=;
        b=u0yga5TzvR2mHLCIs4gskAHdGO5Jvhatz31IAVpfdKXNQnnV7bI1hASboHqWmknbkU
         Cd62HMUCD3QGZNc9D1js2gUEaWDntXpZlUGuzvHQcrNXgjATS/iMWN8Wv4qqXJcDQ+Nm
         3SwRqwMkx485KlnF+7GyVxvhgZTrQXxKHu8bJhNKAVKIyQEKa2HvUbqo3KwhGv0umCzH
         gGu+Nu2TQTrwkpQ7X1UlBayLYCSyy0m8RrcK9xU1DiqyGfpSmlmRH02RYy5ztlMyCCal
         us8RhiM7HFO2rvBb4SaIs4CyrPKGxRuNkab+cn3FmPW1zOMo3mKH3JTfHWdanWjP8y1A
         /Rug==
X-Forwarded-Encrypted: i=1; AJvYcCXcLcvwFkwNrtVF1cYxj6FS1ZUwa5khTycIhzdapRFMSaYy/+Ir/xr2MDfBDEVWSSKVJ8Yp+HFoPmuP@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQ17htutuhvG/UQBUvsejqE1oFfNO8sbrNncRIf4Qrn16LAyv
	6Rd50CYT82SiB8Avz4k9Uq7+tdVX32b6Lq+gcihJaDKk+3RV03aS5vCY
X-Gm-Gg: ATEYQzwxdJmsXCvTrqSkFsXTX9q3vIYP8r6d7fqZVt8MDE/gQ/dJSrIl/KnRAe4UarE
	trYR0cuhQOhqB8SIhEzN3fuzHjGDmyDpAUqBywcnNg7UY5khgwzIDz5fgk3LpbkE9mC60Cl8SSn
	rLtlZn/JyxKf5nVFBGcMfUo4bMX8P68HIA2Vv/uHPwo59Gly+9CR5HGzFKpwLDQGheY2tuJqfHN
	7Dr3HbMvXifZx98gJpLHP+6KsK5CdAnD36ikl1F0kHIPMlzhZtjWCIVzgJN8C+cmscitehkIpip
	c0/xWja8s/RZdfgz5zs7gmyZtP/GGGps1Rr5NLCuUu3U1HcEWAcTFr+W4jW4GbIJ00VbZBHzD9i
	eMjjqAzlMgRQnNZZNBX2KEg6a5qkIZZIwuFWcX4Dw4WYPshTzK7w4k+5gGuGpUQkHepJJi80LtY
	tYCCVMvij/zPY4IayRQGchHg37qOyEFMU=
X-Received: by 2002:a17:90b:4ecd:b0:359:120f:d3aa with SMTP id 98e67ed59e1d1-359a69e5682mr2092330a91.14.1772633074556;
        Wed, 04 Mar 2026 06:04:34 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:04:33 -0800 (PST)
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
	Koichiro Den <den@valinux.co.jp>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Hans Zhang <18255117159@163.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
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
Subject: [RFC v1 01/18] PCI: al: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:44 +0530
Message-ID: <20260304140329.7089-2-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-al.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 345c281c74fe..6e3f52ccc1fa 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -383,6 +383,7 @@ static struct platform_driver al_pcie_driver = {
 		.name	= "al-pcie",
 		.of_match_table = al_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = al_pcie_probe,
 };
-- 
2.50.1

