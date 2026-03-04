Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BD1C84DC
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633657; cv=none; b=Pr3pqHfNIlSlWf7U22Dh7OBbzNfo6HyXqcRho2O8SAoNLilVtUnfzDsilZEhVhwe4tVZAN5xv719DSTW3BdWvaAKT+QkWXhLF4Wqgi3gQtkN+ybvFnBUNIFD9ryEyMWbsvN47RgIO+Fh5zYYsredtFyfdsudmIRtIF2V2omFRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633657; c=relaxed/simple;
	bh=usU4AsKxYiL9wPQdX55tLEiVuRtsJkW47W4gt0QH30A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp5RkJhv3Bwziet1wefyBA7GS2FTCDCOjZBCVI9+CH6y+a//KC56/NRI4/p7Smo4g569JOkC6eBQWVX6APOx1rbTmPfmVCCySoToITqisKL9QAixwkukpHIV4lsoGucwuxPGwyB+u9HhiLp+rQZzTXLeMrigX2pRfJOkxH3HDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArhD8jr8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArhD8jr8"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3057940a91.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633656; x=1773238456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iMM5LSmFDPAj9DIWsk4fCcz5M6Z1n4D1h8BmNreiQQ=;
        b=ArhD8jr84XISWVl9gGSrPW55hIVw3gBtgBKt477yhgWT45O36LWXe4aN0XIP6hcMj8
         mWAhK5n4JzP2AqnJsXs4O030F5lYx2A2hpJzmZ3eb6IqV5/CfnDzAHXTAS+t3L5l+N/4
         hmeJ5uEe1eia/mOH+QE6NdrbbXCZNK/H1oLcySWmwrRT7MsONmFNQ1nugQl70PiAwsIO
         UUuGDBikvkgVk5C+OJD9oxCwxfBKoQ3nsL1ApAwqPAg7EscfkUu+xwA5Oej/AXO8+NE/
         UwA9TY+F8i60eZH6hA7lFUTGC4B13JysNYlw52Dakhrzktky1O4vu/s5CIBbaeFaO0wA
         jG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633656; x=1773238456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iMM5LSmFDPAj9DIWsk4fCcz5M6Z1n4D1h8BmNreiQQ=;
        b=Is+q0lACL4AsN38UZvO46ksdM92RNDBAZNKS5Ljpr/9BbHeMDZR+Le6Ehr7lhDT6ev
         Zeg47z1Ii4LIh7HZaXmYXRPBQA5aik3tVM1phq4WfN+qOoGtaFr7FOJkvwn6EI85LSOi
         CG3Xd4qaLh4zZRIyswBjGfmgVHMvGBzxk3EB9ySNqW5IU4ZozJCFDFypM8xpKrxxw4hQ
         KUysiztPDPQh+Kpp+K9lELqOnE2aa9/u8VWdvBnynMKuIte7oHuQcPPoJN4fWP52mrQp
         sNkOE4v2HMgRd/Bu8GqoztYg4opUI3XjNOzRlj7vP62aqISDfApDITU3niDuH+5wgGJ2
         cvGg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2paYK+/kwszEjnFKBE3B26/oP1zo7qeed1FRKuTBm6JDhAmzAkdiU2ewCdIbTr1JSNcl7srRXhD/@vger.kernel.org
X-Gm-Message-State: AOJu0YxXho97omcIqdU0EH2kNy3XzHrYHLFDOgKETxfv6UrMlKH+E6BB
	Uig/+1Ox3woDe/iyWIjwa1tFUvJK1c0WHSV7+E/zwsoQDNVxsiOMY7Rg
X-Gm-Gg: ATEYQzyP85/1Ddm9qI248rGIoDnZC3n2fBtJ4lWFZl1Y24Rqm1jxe7wxoeCzxcLacXx
	kHnUX4NNZMo2GACP5Z17UEGt9RT3mfKn0rwrXnZkToBcJUb6ubH+GPjhdt/lihG80fSsRSrsbtT
	AXbYNrmpbw0OhBNnx/KF409QkvJLCAY3cCbGn9EJb+QLx5ZBCRtSdzms94nJsxrt03tUqChWIQD
	6yr6pipzQpnwAbA/1uSqqZIuP0mH0lb6uNg7479PJtWgIRUvgQT96wiZe3ViD77jMtqRw1O/H7L
	7Dlxf08Atn6XpplfukY1a+OkBoqpYhzsA1HPapvi1J4tH0iCb1K/Lvv9+tyE5b0pCuMQt22jiCp
	UA5f8DNiS1oFYR+z/8UWHFLF+C/zB2lyPhF9TFZq3P6BuXgc5/be9oekd54q20ky6EvPGOpTxNw
	oBrn1ND/gKMNDZiqtNb3Gu
X-Received: by 2002:a17:90b:278e:b0:359:8632:5e39 with SMTP id 98e67ed59e1d1-359a69adc3dmr1844903a91.5.1772633655971;
        Wed, 04 Mar 2026 06:14:15 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:14:15 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Hans Zhang <18255117159@163.com>,
	Thomas Gleixner <tglx@kernel.org>,
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
Subject: [RFC v1 13/18] PCI: layerscape: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:56 +0530
Message-ID: <20260304140329.7089-14-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-layerscape.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index a44b5c256d6e..43a28d9ea7b0 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -410,6 +410,7 @@ static struct platform_driver ls_pcie_driver = {
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
 		.pm = &ls_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(ls_pcie_driver);
-- 
2.50.1

