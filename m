Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239E3B8D7A
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633221; cv=none; b=nbh/HP76ztqYdBJL4CQD0728j1Qp9HK8CENRd/gYws4MiU9mS4uX18+TBpubb7t+Vyk+gjRyi7InOiKuDTRBSBXVLsnFdsdR6a/Vrs8Rky6HH7c42dA/ZW5Hcn3INlNKjcdkSJHgr21oiNOMfMI+p5mmIayZvdfhEuxiUDUTAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633221; c=relaxed/simple;
	bh=emXK8/tfYDDxa1P8iYWbMlLlPlfkDwMG4hmrO9QaGWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKFACWERSMF7Ih1AuQaSRinur3hUFB+1SM3mXRynw1wYHFk+AVa2VSeFh99lOYyst0m3FhRn5wGjjFCmRSPKcYV2uPLz0Hcw5R/9izVxYbdAJAkD2ACvD5B1z9n71WqThEERSPG7SRdzGKStWIELWLzFqAEPXjHqPSzKe5QJnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWZbxcMJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWZbxcMJ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3598e7155bbso2179059a91.2
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633219; x=1773238019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GDiK7aQGiQOGUD0oRaiplszyhTYrKMycTga1oNn5ks=;
        b=TWZbxcMJ8QJK9lOtUzQ4JM0j3E1Xv6WNFtTjpWgDC8sVkyW/GgZM2qzv2qHaPY1cXv
         o5egNlSOJgiKIdYdfgM3BojNbGsVUZ7hj5Vuu74Vl9rTTiAjQZ7JKh0lWVVpjXmA5bQx
         yzanEov9ZHbr654nmyAkkwTT7oQsLLZMgdTmCA372piQq/vj4fkluiiFKI4bdVlpVS24
         Q21I7Lb7my5oKTE7oX5j9fZeRmDZfAGTITAa3iMcsW0SPlIEG3RVlFRk+w/Xbf9q6/+r
         WIoKBvhehvGlI7ZnhZj+qncNBCwnJg6AnGS9ntsFb0Jg3ReVPTPfsHWjhT7RgibJXh+8
         JNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633219; x=1773238019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GDiK7aQGiQOGUD0oRaiplszyhTYrKMycTga1oNn5ks=;
        b=Kfjz1ly9kxxOMMJNUlYcWiYfzqwtoX7zGXKowWwbuUxayv38PVMkgt43MlJzMTHnUc
         pQvNnvfiod84Yz3Z7E+QwZG4dKVx8jijwBtKjBmE5SbXC638U4RE1wdnfoOu2zGQxWBd
         eZiTuoI2HEotlXPlF54jxynba8yu29P06hHUgEkrfzx8YdlCLc8jjBUHlpka86xYy1zU
         tmZwpxjEsNOuZ20WGjY5g6CDHvPwEAxMDCueeNK/YOjatc2bCpblQxeHt8qwYGsBhmjq
         6SfNDRrvUqMZKKmdVNqnTuTjm/dzfBntz1jzxLiskz2ychTUk/9a3s9XPe1h/PY4s5J8
         JVcA==
X-Forwarded-Encrypted: i=1; AJvYcCU1mabzfGPMLxGpjPnuNsfKl9AB/sXeM39QTJX3TUJyZ+HuOvRIdWA2fZj0hyy6jITxbCI4vqeombvL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99RdpPGIUkWYdpfhFb222QWLJ5p1HyGACNi9SGX8WvEjplyCv
	gXvGiY/5aRT3yTCN55V4uLvQ/o5Qx0FIjBTxawPBFJ9FCIP87LuEF5NB
X-Gm-Gg: ATEYQzx++uXxKdfPTfFCEuCKP2+HlbC+KqSciyzZtiBOES0ftyEpSKT8FRxOo49UqXW
	/pbdSuEi30kETW6dqV2GaMq3gMSkkF5mXdtcY5rGHTBq+UQ7mgqdM3Ol+q7trgWCjrYryYH9vpV
	MOIeaPQEYNON5d601N/endI4sXniwCxorQo87kNXIOhL+RCBaEkiZ0paSPw+qXjCkuw+oQTc3gM
	F+hKUjy4tooswKouLEJTA4ZjRKTIvSGq1TG1Iv/3nMW9gpcw/JqKotaeaykhT5BLoLk0dtHoqBu
	2/pL3BeezR8vB8TmcMJSw3tl6RIjT0BTTqXyBoLEYRlSu/t6ZApygXpYu1JHynS6JQqdAyfo8sU
	6IRKG9oYrieKTVGurv4Q4/nHjCsS2N65+MBXy/I9UOnxJB8Dup/gMVpucjrzvXiqUGczJwIJh14
	zwhFPWVfyaE/WfNf/ynIcu
X-Received: by 2002:a17:90b:5547:b0:359:7c55:c166 with SMTP id 98e67ed59e1d1-359a69a94e9mr1892448a91.7.1772633219172;
        Wed, 04 Mar 2026 06:06:59 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:06:58 -0800 (PST)
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
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
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
Subject: [RFC v1 04/18] PCI: artpec6: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:47 +0530
Message-ID: <20260304140329.7089-5-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-artpec6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index e994b75986c3..d8b827926b85 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -520,6 +520,7 @@ static struct platform_driver artpec6_pcie_driver = {
 		.name	= "artpec6-pcie",
 		.of_match_table = artpec6_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(artpec6_pcie_driver);
-- 
2.50.1

