Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AECA3B52E5
	for <linux-omap@vger.kernel.org>; Wed,  4 Mar 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633561; cv=none; b=abw5SjHTjp1YxIOPT0uu/lBs6MlxCsEh4E9aKFfphLqiu5V6wm0YP5F4Po2UWARoGsKkZXBOK5ahawvEc/5DYbczi5u3r1pdotxk9l2YNW9F4EvJdoRj5q1m5eB3vlRsolZYf7QYYHHi2E2xecarHPbwUSl+ryvygSdv6Mmp38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633561; c=relaxed/simple;
	bh=uNokBxxuyt+zPVO0vcOQK89zVSyGR0Yqq+jATpwqTR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amBYUis2MLSqp0kl8tBTcVgsPM/tYZl++Hw6764w5FTOHmkByXOqL+0e5xeD688pRLuBGfJO6CDbD3Ida4w5wSUQZkEGah1kD0Wc+PBHl7ImtHYR5lqKm71uRAfKRBV8r5s5SHeJFSKocJiLStS/WhaSBWldy2qemUMk3RXIG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaB/qiKt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaB/qiKt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3598c008455so2003394a91.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2026 06:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633559; x=1773238359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvXorwNx3S8EJD2J965xM8gci4hmlt6ydwx4B/ML9So=;
        b=SaB/qiKtUg1EEiMnY+AOLfojjqSUJ/zgyZ1Wl4KBgNMT9p+Yj8LRKxo2pUJFaZ5ANc
         E85LgaMsAND4ZfEMU19YvzxN5e9FmTF/tGVxohrPbzIzHkuC9xwlGg+jEQaXYKQfVZ4M
         H+C0UgQHh3/qyJ0CcJyPnIrlDMDFBpv71CwZY4WPS3cZVzjFA0nbpnH2CalhkWULoV29
         ofXVlYtTMxlznZkt08BKjNRlmK+OsWcHD4Zmgf2tQzObjiTn7+ofIwyzfN/+50BhqRy9
         i8upZ1v7vN91I7pZuIrKpFDhnoX8M4fMuDkSUk5w9ZgrVQyW2I0tyBDBugV6pEVnpaN3
         l3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633559; x=1773238359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wvXorwNx3S8EJD2J965xM8gci4hmlt6ydwx4B/ML9So=;
        b=mM8/bXbdTWVgPug0pkLIizJPCxL+iKKKBLHkR0rIRV/gteTLBsQSh9CwTzvhMSUFAO
         ZmOI36jS+TgkPpl74FcXfP9vDJ5T4gM/snKA79ezOgl2eXldH+Zt+aci3f6e9+s7lF07
         l+W5vzYxXDFjBZb2huTUD+ATRm0oYdA+ieH10J+Crip2kZaQgzKcTKCfqnkr02Nk7ES8
         yThW8X7KQgL1zsQ6QM3dFRZ1c5ODXMSKo194n4xPXkWArYJH4tvfJquHuGFNpR1uNDwQ
         DuVmBtrFrtizDP40+nDZvGKzFVlD3SJPKYvp+KK8doiQEkP1f8EAmQZI8UObiTCf1eW9
         nKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPEFG7ucBXMTwj3d8Dh4+GzMLMJK7SnWz1vCkmP2amKrax6cujqqpQZJZQSgMz2McuR+eVzsN9ycDx@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcxiddJmHVxTEuRiIoynuRtZ/iLWWmUaBuCUtp4AuZuY9JOlz
	9xe4aKz9fxbxzTPI+faf9t+b4xHyHOvDVtFzC7O5CMc2jcQTSihwemwR
X-Gm-Gg: ATEYQzyfYPmVm6ZTk0jyWyr3xrRrv/cz0XoGwbCc7qPovwVIVejHLj3qsd73Y5PgZB9
	9g/iDRkb2hAErVdoaVoKGw367Da0Bb2g4pJeg/WjvzALGSRm5UtLyi2C6sQ38vG42/G2PexMKuA
	MDr9WzPcu7vLvu8fvqGhCBlnk2XewJ8C5EMLLA5O/pWgBBYAVQWoJqixC3BhupPYrFKyFDD1v38
	mQ0KAFL3vn0NPbTCLXfc9B8Emh8BPfueToGUKEHRls1vZeQy6L5+TcoH9UHLoujs9bE2iqCEylw
	3nO+bDndhKGBYuzlSeFsdkXU59fGk4O1gyiSDskyEMeQgdOh2SIdfvy2xPyep3MvdzsYfa1Q3n5
	2UPNto15xHgJTtkXTUortq7dwLz10tASp3FuvKGU9BsImpfnmuQJH5VUVJS+KopthpNNzgVyYO2
	/hmrGp+6ASvKmaaEtJnX3U
X-Received: by 2002:a17:90b:3c46:b0:354:9b26:cdf8 with SMTP id 98e67ed59e1d1-359a69c774cmr2111843a91.10.1772633559439;
        Wed, 04 Mar 2026 06:12:39 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:12:38 -0800 (PST)
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
	Hans Zhang <18255117159@163.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
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
Subject: [RFC v1 11/18] PCI: keembay: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:54 +0530
Message-ID: <20260304140329.7089-12-linux.amoon@gmail.com>
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

Establishing a PCIe link can take a while; allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-keembay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 2666a9c3d67e..a82d69b37e4d 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -478,6 +478,7 @@ static struct platform_driver keembay_pcie_driver = {
 		.name = "keembay-pcie",
 		.of_match_table = keembay_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe  = keembay_pcie_probe,
 };
-- 
2.50.1

