Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29F3D669C;
	Mon, 30 Mar 2026 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878265; cv=none; b=bNhfFKp5scngz6Glk2TrsFXQP+Z6Q4xeISb6jEzILgB0BQS5REyHxZ3HF/kA0aSgVI/WWBEMxkuzXOtHbZn5WciWNNBDnG/5enaa+RQBTgnuQa0F5CPyCVW7rHsG7MSro+AahIEZyxJSj5//ZIY0gFyi4E0pMOnMbZbTrCdupQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878265; c=relaxed/simple;
	bh=T+lgXz5Iuq7Xyz/UOKz0key+XxGIxOFA4cPs64Zx1ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgfJDqOTNQdRbHLk4UCTbSLfSQlEiFOLqEInTyI6Cv5QYFE6iXJZaZCs1f6Wtv5cQOrKirYo1sgplj0PisZ1u0j7iKJ6sl2zAEdVwhbK0f5hDsxhWf1bDbLmc3cBruZiwiHd/GgzExAaUHKYZgKXWpZ1+2+ecaEXsrP3hk0dq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b0LiTRoN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b0LiTRoN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9BFC11A3037;
	Mon, 30 Mar 2026 13:44:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69BE95FFA8;
	Mon, 30 Mar 2026 13:44:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA3B0104505DF;
	Mon, 30 Mar 2026 15:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8BncPh+xJkGlmXZACvnZW5xd0WAV5aiCq5VNVGQZ02k=;
	b=b0LiTRoNZ5UWqKyknAP0eHiFxVzIE7QRUEGea9BEB0MwtB2P/m62RAa8mbL6Ljyhjr0qK1
	RFozIcFhlOdde4ux3dwIEm8seHvM33pqp4aR0dUvKdFFwgQLl+E+46i6RXf5IhaSW8vpuX
	0BrYmYmiYFhGlAGHWsqCPSVnYyM72iO9K/Lv+LrhAm8oUgRHYZQJT7C7wwh9k1TV1GMSF1
	vT2ICTqYqoN6yPrSkys3kFTSS9OSlkMT73edQL2IazXAM89/J36QRj2lV1zrHXD7PwInKT
	qolnmRLv/QYSdfaG8d6PD8KmaGJwq26EZ+srMjXoL0qJgswP4tBMAt2B1rQApw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:00 +0200
Subject: [PATCH v2 03/11] regulator: pbias: Add pbias SIM regulator for
 OMAP4
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-3-1c1e11b190dc@bootlin.com>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
In-Reply-To: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add support for the pbias SIM regulator found on OMAP4 (for USB I/O cell).

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/regulator/pbias-regulator.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index cd5a0d7e4455..23cc106cd9fb 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -81,6 +81,17 @@ static const struct pbias_reg_info pbias_sim_omap3 = {
 	.name = "pbias_sim_omap3"
 };
 
+static const struct pbias_reg_info pbias_sim_omap4 = {
+	.enable = BIT(28) |  BIT(20),
+	.enable_mask = BIT(31) | BIT(28) | BIT(20),
+	.disable_val = BIT(31),
+	.vmode = BIT(27),
+	.enable_time = 100,
+	.pbias_volt_table = pbias_volt_table_3_0V,
+	.n_voltages = 2,
+	.name = "pbias_sim_omap4"
+};
+
 static const struct pbias_reg_info pbias_mmc_omap4 = {
 	.enable = BIT(26) | BIT(22),
 	.enable_mask = BIT(26) | BIT(25) | BIT(22),
@@ -108,6 +119,7 @@ static struct of_regulator_match pbias_matches[] = {
 	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
 	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
 	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
+	{ .name = "pbias_sim_omap4", .driver_data = (void *)&pbias_sim_omap4},
 };
 #define PBIAS_NUM_REGS	ARRAY_SIZE(pbias_matches)
 

-- 
2.53.0

