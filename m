Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA126ED41;
	Tue, 22 Sep 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037890; cv=none; b=tSH4Z3I1b/Da91oamvIwsNjlW5qf8GwyZlgdkAiDlYnIbaocUs56rvizBT8XaYbGvVV2yeLfgkMn1d64tlwWaFhRhwBdpIUVi7PPFnm8c8EIwCHhTLumwvPu9w3Uvurb+ubjS/4K6F0KQGJOiZG4jCdTB1P5/6gvlpMimb8nUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037890; c=relaxed/simple;
	bh=6ZHWOUdWkh5+imYRzYrnoG2iop+2EzkUyqyeIpADv9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqeHYjQgI/zZBLjOcg8EBEgeJtpvhZtyZej+N0wPjrlr0rrJCFvH2u2OQ1H7Vl+SrLEfDablosuwtTaPk8mEYvKOEHvPpEAUnLgxw1Fz235IyOJP3qpzxVlERR/X+E1v5FpdUHRLSCvPMCuEYv5RPh6dTMfvuTHDrys4yTPMrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xtb4Jqzu; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xtb4Jqzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GL
	gLHIwuK/H+KBkRuw2xJOrRSt4Ac8dgz8uqhNoWav4=; b=Xtb4Jqzucf5bZLmsC7
	iRrvPZf1/PECpp3AfrIXoN3j1ul23FQhCRq0oranRpFlIJPhQBaJTfnqxo8Wwtt8
	Pn5v9vzW2/DLymKMRIW7rgRLlzVjowzgCA0WEmgX5j9DCunNv6mB3zKIfoG258CK
	FXABB8NSU/SYXu5hUfRgOfVG8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnR1Zgz7FqqM3RAg--.28552S5;
	Tue, 22 Sep 2026 08:44:18 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: b-liu@ti.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s.nawrocki@samsung.com,
	kishon@kernel.org,
	balbi@ti.com,
	tony@atomide.com,
	hppiscas@163.com
Subject: [PATCH v2 3/3] usb: musb: omap2430: report system-resume PHY setup failures
Date: Tue, 22 Sep 2026 08:44:14 +0800
Message-ID: <20260922004414.4192-4-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922004414.4192-1-hppiscas@163.com>
References: <20260922004414.4192-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnR1Zgz7FqqM3RAg--.28552S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1xKryUJrW5tr1UCw43Awb_yoW8WF18pr
	ZrKF40krWkt3Z7Ka1DtF4Iv3WrC39akrW5Cr9F9397ZrnxGa42kr15GFyjvFsYgF18tF42
	yr4UAayUZF4vkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6VbPUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxgMT22qxz2NPeAAA3N

omap2430_resume() ignores PHY setup failures and always reports success.

Return the result of the ownership-aware PHY setup helper. End the
system-sleep deferral even on failure: leaving phy_suspended set would
make later runtime resumes skip the PHY permanently. The independent
reference flags still record which resources need cleanup or retry.

A later suspend or platform exit therefore releases only references
actually held, while a runtime resume can retry setup without adding a
second initialization reference left over from a failed cleanup.

The issue was found by our static-analysis tool.

Fixes: 68d9f95d6fd5 ("usb: musb: Fix suspend and resume issues for PHYs on I2C and SPI")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/usb/musb/omap2430.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 382d6cd4a9e6..951e60906f2c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -657,14 +657,16 @@ static int omap2430_resume(struct device *dev)
 {
 	struct omap2430_glue *glue = dev_get_drvdata(dev);
 	struct musb *musb = glue_to_musb(glue);
+	int ret;
 
 	if (!musb)
 		return 0;
 
-	omap2430_phy_power_on(glue);
+	ret = omap2430_phy_power_on(glue);
+	/* End system-sleep deferral so a later runtime resume can retry. */
 	glue->phy_suspended = 0;
 
-	return 0;
+	return ret;
 }
 
 static const struct dev_pm_ops omap2430_pm_ops = {

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.50.1 (Apple Git-155)

