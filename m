Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0763B4E89
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633755; cv=none; b=L2ByDqtUi8pWCA6b2R8TB0lM7Zp+zhyQk9vxT2mu8BjMT18992bvuNmluzX2MY35DplT1ZQHvdReQNmAenCexYRG4yyh14WzegMi4TQHX43bP4FiNbKqdZ1efpwW2h59UFU51SZgWzpkN0LjdFRYjSGWSD4DyNGBLxf6W97b1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633755; c=relaxed/simple;
	bh=sOuf9crnr+mGWYcFQULXSYXyooM+1ooss5UP7AG6ldw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEH8exQl4wQG38FJmBMK58F3Wl+TWYlGpsl17zh1ePLh7l6ooWp4Oqlp7qlav6dAherMUeZrglIHQuIoISCBay8FoPXEW/15i+fIYqr2xX0moutF64937bJSH4vv3Qr2jEpsd58cIb02YVXVA3ZRGsod//v/wLf4CDgv51ws54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3y14wte; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3y14wte"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3059779a91.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633753; x=1773238553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CrWSKJRkZKN008VlCo4uVGQadvKlijsjSi8/hdflIY=;
        b=c3y14wte/Zrj6mW13RYCEN5ZLsiOk35SndeJGwzS/iETGEL9b4YzFr8tpseLouILrk
         cph+xtKU1zlOPnwfL7R41HWQcazqujvlDCrXV8WWsHFtyncdl7fCtbR77F4mrU/qCA6v
         CJ/m5h8CAbW8MEy4XnxPHpo7JQHlxUHHMA6Pzs22KHJBvMPXM2ikoaDXTb+WCeQdK541
         iKTax6Y1zvUBBRrCY6PlIL9SD3u7yEMBqJUWtJewxLyT6Ttus6jPL8Vw8JqHMSI5OHvG
         dcX/h1BEL4MphJSqwY5LCyeqGOoRCpaN3boag3sculxRkSQ4xhiJYSaS+7TRrMYYHEd5
         qn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633753; x=1773238553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/CrWSKJRkZKN008VlCo4uVGQadvKlijsjSi8/hdflIY=;
        b=QgogO8bgSeTUMKHv17M5G3jzIYgJ/qrMjScdrsJbJKz2DQct9Zdhg4OmcK6HtgOjC7
         7Zk7j6Neok1JY1gPKBD47sA6WHeGW5bWbcpwj+tB2L/0nmgvylBG3pHhCmgZj0Z0Dn8w
         m44diSM2driU85Z1kDhoR8M/daZ0814HNc9t9qOViDDum4s9sj1ajjvi5EU5hzjf/soD
         ISM/9TTmB3OqeqepFlsSbYU84Il+BO+8P8f5nFun8ajSJWu9VnbKEKpNUp0vKs7tqUkO
         XhlFcj6RiyqNzxJfdfqyQW/5dZuU51JAEXgtjlwfI6ZVWv4uAqB0KdNiXY48IL+nMVIs
         lSeg==
X-Forwarded-Encrypted: i=1; AJvYcCXBOeWW07e+YDLR1FkA6ow6xY6eIGVagBcqcvuT81eJdS6VFYMxxnbP8CJgZvGqmFrTf31ExUQoSO9V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3U8uQOITvpjrcJOB5T2K4oiJDt4tzT9sNcpvL2rtVcvrrnf+s
	jdF8HXdHq4zoXevKW1vYd1MmLhtvhVVzb21ZoZaGpCjvWI4P1pUL40q6
X-Gm-Gg: ATEYQzzrNKsCbKJ1UMjY5ptapGBHv8lBn6qZrESrGpnFsU6jPtE3xW8ziht4WWpwNdX
	RV/wmlBoayAWTaaLV9sKpkk7zGEtQFBp5w/BWBJ5X/eJKl+u6aQOBst6WviX+vLB+CGFUnm3AP0
	n+3ylXMZCUGgh6uoj1hNiLKiG0ofJIamj6jt9APUvv5getYal7SB7Zhy0B3a2E9WRgagrG+DrQm
	9r7v2YU4YRbB0g7fhC3goSVDv8oOuvC/R0I7cms2xMpSdXbSNVokrxuvfrcQclaHmMXOZmxTbaV
	SdoIE8SuA24d3CQ4DFLOBw9OXu9dDQVO7DE67BqBCcn7ctViWuGAc3P42l1M0nQptC+9THMp3F3
	Cz9JU7LEwhCszF/c8mLvbspa1nP86dayH3jyoUXPUODlyhCsaqbaaKkMYrS5Pmz+N8hvqVRKkLj
	6o2+AcEd2ZNyJq7/oblv9M
X-Received: by 2002:a17:90b:3506:b0:354:a57c:65dd with SMTP id 98e67ed59e1d1-359a6a66b87mr2001714a91.24.1772633753114;
        Wed, 04 Mar 2026 06:15:53 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:15:52 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
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
Subject: [RFC v1 15/18] PCI: sophgo: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:58 +0530
Message-ID: <20260304140329.7089-16-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-sophgo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index 044088898819..0393f4b613de 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -269,6 +269,7 @@ static struct platform_driver sophgo_pcie_driver = {
 		.name = "sophgo-pcie",
 		.of_match_table = sophgo_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sophgo_pcie_probe,
 };
-- 
2.50.1

