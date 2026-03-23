Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB023B62C
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278178; cv=none; b=JnQzQhYmE68oQKHEbF1PbvH9hE9ctokvT6vM0mLZfSuEjykgCqUaqb/q8ke28kCJsUf4AIxPVBuOkLgdRtK0EwhqUPZTquJhJiL+e+sPM2x2JevMz5DrnnrFSEFWtFsE7uQEYx+SeYaMd2a4Fsx4NtkyRKiYGWCGiorbbrZDH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278178; c=relaxed/simple;
	bh=RZ05fnOTL36RbaEJ7PXDwSaGMbnBPKVWLVV46u9AL7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrVArlUGvxnw/Hax8fueslbmCae5MEMml0ceQA7IsgntwHX2QmjgEUW0TlSHasG8rABu+3Ae3wceSt/SbIyiCVMqeKFLvehjgZG0bLplOECWnNm/qb5J7ZR6U+MrNepigVURmK8jxCJ3b2VuDs+PTdoZJO1XZvZgCV4k4/xlNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cHLe6CVF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cHLe6CVF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BDDF71A2FA1;
	Mon, 23 Mar 2026 15:02:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93B0D5FEF6;
	Mon, 23 Mar 2026 15:02:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F1DB10450FC6;
	Mon, 23 Mar 2026 16:02:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278174; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D6IKIdRvwM2R3lKzRFHKfHPihb9IxMVhpD6K+aGvwec=;
	b=cHLe6CVFn8B4vtUTT9G5iXO6l9rxYJD6AyrSeaXaaBGXf4FQ5FKqesbCPiI/KmxXBGt3Fc
	wrgu5Yryh1mxFFp/Oc4JGr7eR2AE2j7PhhxBRp1jwdL1/KrTQczGG4aSE8igHYcby8R0pQ
	A0c3AEj6QDp5GtaADqxXrljJGMXH/1x8+RYJrq3+m5ifFXtzVmNf3VieA2PFLzx1hp3exL
	9YkDpm8jDWveFK/fzVJFBx7xhym0xckVCFrnJZQnva/ww/mkisUz3nl00i/SXdWcUhTVCL
	dKKmlYSTpu9LBpCXaqYF/+7MfeFD97dWS7hx7PhpbMwlMhHZP4nY1p/k1XDhiQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:42 +0100
Subject: [PATCH 1/8] regulator: pbias: Add pbias SIM regulator for OMAP4
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-1-b668132124ac@bootlin.com>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
In-Reply-To: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Add support for the pbias SIM regulator found on OMAP4 (for USB I/O cell).

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/regulator/pbias-regulator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index cd5a0d7e44555f04d1e44470036c6e3d9feb7be6..10c4940e73635293bebd26bf99a9067eb6e39107 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -81,6 +81,16 @@ static const struct pbias_reg_info pbias_sim_omap3 = {
 	.name = "pbias_sim_omap3"
 };
 
+static const struct pbias_reg_info pbias_sim_omap4 = {
+	.enable = BIT(28) |  BIT(20),
+	.enable_mask = BIT(31) | BIT(28) | BIT(20),
+	.vmode = BIT(31),
+	.enable_time = 100,
+	.pbias_volt_table = pbias_volt_table_3_0V,
+	.n_voltages = 2,
+	.name = "pbias_sim_omap4"
+};
+
 static const struct pbias_reg_info pbias_mmc_omap4 = {
 	.enable = BIT(26) | BIT(22),
 	.enable_mask = BIT(26) | BIT(25) | BIT(22),
@@ -108,6 +118,7 @@ static struct of_regulator_match pbias_matches[] = {
 	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
 	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
 	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
+	{ .name = "pbias_sim_omap4", .driver_data = (void *)&pbias_sim_omap4},
 };
 #define PBIAS_NUM_REGS	ARRAY_SIZE(pbias_matches)
 

-- 
2.53.0

