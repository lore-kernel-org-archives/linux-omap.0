Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982F3B4E94
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633899; cv=none; b=nk66jYiReC7jKVPxjyA3VDP8FyuKdagIDIIlAnTJ3rf9JspIpDXFTk5uoH5ohW5X9tofS1a7IlaWn53oF3r+y9ycw17bkpDu06OSq7tm3QpT++URhTNAAckqqb4KlqskJcMtZTBBiXdfCWipNoS/pDCYHo4VV9NldT1nm6v8TfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633899; c=relaxed/simple;
	bh=MFtn++fehPz2bcYxQs56cfdjtPdPajpg8F67EhLU4r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsYwyFF5dR02DnXvXhK96pjH6wnKP4wlku9FSFmYwCj0ogtFh72lVhb8VW7F+7vJJzImzy14ZkssJqp2kHXVLWd0pjlAQzZ2GTz9+ZCYvbPA4/3xgizDvx9tZRTj5JWIJe48GnBAx0lJuOqUPE269qRxdm7kwXPn42So+12u3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCY2yi9f; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCY2yi9f"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so2008800a91.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633897; x=1773238697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOqiu9rk3pfbNQbzbq46fMvxLJFiDFeJ6tCyKh6dPNk=;
        b=dCY2yi9fpzXaTO93FzvbGxrN5zrVrSNiKzsDjv9krXAuw5iO51gCedPntI1sFcvvYc
         JpTZ4oW4MZq7ZurW9PuZzqwvfHTvhugisL7lA+iKfObo7nclFMfJBrlGhrBcrgrXIPHT
         8pTdOjnvKOA0jUjneAozr4wA3OKDOrglg8ircrZpe7OnthMFybZ27QqrbzekBnW/Bn7K
         zddU2DHhlNBSUesgzyK+jjI1PCEiii+dPXPJfInTOsXArVXLZ3zeDpe16VbtGG0dgs4d
         Fba/6mJq5/uk9WbDsdzfX8wxqijN1B0hJ89OHpI36VWClKD/jBWKcbZS2Bq8oS0X3VnW
         qGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633897; x=1773238697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOqiu9rk3pfbNQbzbq46fMvxLJFiDFeJ6tCyKh6dPNk=;
        b=aOl1gSOt9Fyy07GYCAB36y+6rWkipcvEyXve/KZdW0OJKUnm4ErJ4cF3VFP4FSV1Io
         bABdw+g0XUcaDejB9VFfveFJs/YxXOnLCOJmpIJJ5t3u3IoIkw6VxAxWY0uSXOWLfG7m
         Y6nMkLpplL+ZTGdNwtqpIgQpY+9+0O8d7xMJxISzop5svQzgWLGz04UhmjCI4q3gz2au
         nbDTXoP/jOQyllPqpbYj6l/okJQPrVacpHmgq6B/wpGQ4YlOSYpTsDpyIBm1zKGKS7Az
         7HYlYKlg0sfQ9W4Vx9P5A/o5+R4ef7ddhPTiXuTUVAmptp7CSPPZbCZX2+vjYEXfHT+y
         3Cwg==
X-Forwarded-Encrypted: i=1; AJvYcCVlJTFV0whKz6YENBn6d3wZdY1gdcgmAlRCaAM2ne9gCM3q5R1NIMQ5Z5n4TqhLKMIP6H67FM7+s8tP@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2Dn+6zVGhroiVfBvgJQX2XJfo6mvcazkjbUOKMfq60Fx2SRo
	mMJCunIRpKjNRBZfH5QJrkwQZPuXl1cC0xuQoDRytZQhwBUoH9dYCNOP
X-Gm-Gg: ATEYQzzSRFcKvUTMKLYFzrkQBildlV4hMvE3mRKXUhFgPgEIZ1zkLhmD7OO1+IImrG+
	72drPC7/Dw/gcXopc4hmcpSTTyVl87IrtvfkjMC5ONS75szTRflY90rEXua4c3iU5sfUaH/XmSY
	3T8LAqcnmMQZt4UAxxPyngG/894bEh1oYpgmTVrRg+0ye+EWMg7ycsBn4gUQGYNzPYrlHTtyRgw
	NfnXlZieotzSc5HNRkgyO90qh21dWFMENS/4zSN77EGRZis8lBZLtU0eubIqBUdjguZe3xAn3t/
	MNsMM19rDIPm/W0I9iaNlhv2NY+YxP5QDhgQ3tugJJl33Dzz5cR48aeC2YR3PQpxM6Jl32VGfTE
	L3ZlTrnosaPUhBp/ihVo0ZgMr9plmhpOJRkbRnYKv9OPxDY4ueD1RrhJiY5xp0/QHt/vVKsEN7Q
	hlHxUgwbSUioqtxlCzQKDUB1BOFQUE2Z0=
X-Received: by 2002:a17:90b:4a87:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-359a6a21675mr2061241a91.21.1772633897136;
        Wed, 04 Mar 2026 06:18:17 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:18:16 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Frank Li <Frank.Li@nxp.com>,
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
Subject: [RFC v1 18/18] PCI: visconti: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:22:01 +0530
Message-ID: <20260304140329.7089-19-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-visconti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index cdeac6177143..f21cc95fe89f 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -324,6 +324,7 @@ static struct platform_driver visconti_pcie_driver = {
 		.name = "visconti-pcie",
 		.of_match_table = visconti_pcie_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(visconti_pcie_driver);
-- 
2.50.1

