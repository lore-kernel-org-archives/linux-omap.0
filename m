Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4073CF21A
	for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411301; cv=none; b=Kau2dF/Yav5F5S+DUibn89A3q7tiFAc4GdVY8HFFAd2fU8SWqJeSGl0Rq9CuAw9ttsEmJdhd6NaGJoEvdvM7Ll+wR7qpHzfvLapiWuZMSTgrncRmB0KIl/q1mfBIFGWhCv0ifXDpRZ5VMDxlBM/rtPT1FsHulyOkIRSiBY+UPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411301; c=relaxed/simple;
	bh=MgRL359uSGGq2G+dbIIbcTFNFWELMsvNpKc3wpRExyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXEVxK3Ltb/y7kpDlgCrl3Oz5vSMHIIqQVJNWBtb4xHFieMZrNcsicY/Tv/sfhfgssitgE6ZeaBwohOq/xow+NMGIGWienPljg6ifaCmxIxEe9mGtEdrFGqrhYPXfSFE4GPsl6LGt5GcwInIiuVQYqji155ptE1Ik9Vzd98F5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD9A96Ud; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD9A96Ud"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8486672f03cso2077037b3a.0
        for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2026 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411299; x=1788016099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+Gfsbw2LT91VcPxORecg8qTC2JGjipjq7k/HN1uFUI=;
        b=cD9A96Udp16/qOdlAflpdBDBlO6daKFiLH+nqRLFwVvstYigVbd5pALihbldHjSYE6
         VPGTFVFbhJMR3tSZbZkZgtin6GLADjXXGTDcnm3ryiUHhZ+Sy1EzpbbZxVzj4OvCeIp6
         yRiYqZz+A6IXvzbTD4F4nfaJlVXC0wVnynlpUklFhW/NEH4KeGGK4+vSBFnQC6Mv69c9
         BrmPj/fiMvpvlV6+eyuwFE0LcadC1b1CXpyd0sr2sYZRqbelJK4OEx1jc4aNn5Q6f6RB
         V0Z8wzHRkknueXL0WK0C5EuGzA07DmVr06wpvMoNdm2plok7B+K/LEhqapehfN5IhlvE
         MRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411299; x=1788016099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+Gfsbw2LT91VcPxORecg8qTC2JGjipjq7k/HN1uFUI=;
        b=AXA8yafX9UV+4uV/dBTNc+VTGwVBm7a79ZXSDczEdJ+fKtEBltaCtICqrt3VcOcwMi
         el5mpy4BOQlkHJAkJ+tIvVBJpvy29wOtroF7g+26ffyCDKMP1TSjAbch1ueClXAVudXH
         fq+HmXqGtzaLTRiWrzTYImgwOEyQIOujBLK/3p4ZwuC89wJA0zxayD8UZC/7O3s5asto
         0os9crsEApIyQVEWy93AnCf9h1b4tzY/KB/3YJDQFPEp4ykmalud2UFoBUtwgzUHMUfa
         zNpPhvU+h0lu7vJzSFesgNHIrdPrrRJ/TOvOF37cFFo9Ht2ySbVwoW4Rejdj7oPDLxKK
         2lzA==
X-Gm-Message-State: AFuF++lODIPaDdCsqyffzYEG3k8aVMNrzgCLbHLjPb7f6WZBScW+XURA
	aydQq8DXMcTFYdiRlUPHX0Dl6tY+ClJL2KZY8eEkFID1GjPSkQ5Pwda0KO5dBFCCmjU=
X-Gm-Gg: AR+sD115hDPIPAEOYlvUUbfdUz8GLea+eUGD+I4qW0g1+nj29NKhYo4Dq4vlUPPL/4k
	ej30djKljJjXJXYekcgQXAt2Hz5DaWZKYuiUblRYGBOAN/OK5C/p3uXDQ6X7ZEPql9UImi0awHR
	QqNjo3ro/pBiJRM7ejckdRenlMaiS/P+9TtyTKSeXZxkJCmcXov385vu5Fngrg8yjsUBq5WJet/
	SoBowlMLZMLr3fg9gxe83NB10bxsewEDcoHWlEMPEOYr1/QazJpZXrAmcq7f/Hfo9WzlAnV0d2H
	Z5vQ0e23zwgxzLaoH2En0dL6fc8rez8xbwuBofED+dVkJUcHiICcrZo972r0/Pd4aKsPWALw42L
	Ct9AM9nUaV+wwBm2216+d8/h3lU+I1cJYRHj31YIqzYiPB528yudbNvWUMd4xct2RQb9rutuukG
	3kV5Ednc8LH9lwjQhOn5NwIq862ouRz0mqqjAKMM1aV/CmEqVP835Jq1s92NhjiNkQVFjx4rgy+
	3lauu8WRMIjxZpyj54WCTEB8ct4XbXQRfi79doC09PXcSamGMxVpgCc
X-Received: by 2002:a05:6a00:1808:b0:84f:a170:4f5b with SMTP id d2e1a72fcca58-8520b984b8dmr9996781b3a.8.1787411299270;
        Sat, 22 Aug 2026 08:08:19 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b1ebsm628242b3a.30.2026.08.22.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:08:19 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 22 Aug 2026 23:07:49 +0800
Subject: [PATCH 3/3] PCI: dra7xx: Fix device links leak when
 dra7xx_pcie_enable_phy() fails
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-dra7xx-v1-3-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
In-Reply-To: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787411275; l=954;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=MgRL359uSGGq2G+dbIIbcTFNFWELMsvNpKc3wpRExyk=;
 b=/wH7RY13/PmdaWC+y3rHEMhSz5gPR2a9yx18qu5QxBfXm8zCfDM7l7ShTSaTY6YWygwzHEBur
 iqgTLyLhnIBBzsUZogCfpqSjebU/34Pm6axVzTGhU5eDzfBT/Je8Qm5
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When dra7xx_pcie_enable_phy() fails, the code returned immediately and
left the already created device links behind.

Jump to the existing err_link cleanup instead so those links are
deleted on failure.

Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index bf32b14436f9..5bd9d1df80ad 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -766,7 +766,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	ret = dra7xx_pcie_enable_phy(dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		return ret;
+		goto err_link;
 	}
 
 	platform_set_drvdata(pdev, dra7xx);

-- 
2.43.0

