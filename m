Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002638BF91;
	Tue, 24 Mar 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345916; cv=none; b=kevV9xVhAub0+Jf6vgYoVx6Qi7CTfBWGnGwSZwadTQfzahn3T9pslpEg9gJ9dUmDbf8pvnI8UGxGT7mex3X5jKbqIytdpdi+vteGha35O9T3Szmb2zQvN2ulxBH8XoISOBtjFo41UCI23upkbj+okDEu/KbiC80cnOgsneqx+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345916; c=relaxed/simple;
	bh=8rhQqrrO9BcsnzfgIxnkjId7Eu++AO/D6Ebk4VlSAIE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Hb7OzeCuRNCGYqkZH9ZKR1dulGKNAFWc98drTaMTjX/2tJALrTn2Vd7YNNAStxb6daZeO4Xx5JgHcnfec3c/Cfj4gU6dAYmGsfLM10zYQbInTCvQQDbx9brDJYB+tSZvm2Qx2ascyB3TxYqpuUfAPRxnDUlhDB0iunZDiREFAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oT8MliXc; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oT8MliXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774345904; bh=H9+UQu1fklD9zOX2xohlxHoPSg/DC46c/U8Vy0yW5BM=;
	h=From:To:Cc:Subject:Date;
	b=oT8MliXcGOUe4wPuWZ92McU5nb0oQ7X/XvWWmbWzYjN1ZN/I5622lDKVge+0xV3hh
	 tlDlUVsIVOQXn44p0h0xGp+DUiai8FZRLsS0Gop9F8rJ2FOS5UELW+AYIGwrLuNY2w
	 lXJnWQTZn2Rb+7GnuvtwPA7Ql2HGeScyKxwAX3nY=
Received: from LAPTOP-KQCD4QBN.localdomain ([123.121.145.48])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id CE835C40; Tue, 24 Mar 2026 17:51:40 +0800
X-QQ-mid: xmsmtpt1774345900tkwemh9ko
Message-ID: <tencent_17F0160215674516DDAB8808ABB11734CF08@qq.com>
X-QQ-XMAILINFO: M1JY6XCfJolWdtvHTsUPGSeZ/D4XE7HmcKaRxGJDaQsivGQfRKNdptKoy1MI8e
	 xkqt88i+74KiU2r5gJYNlgX1HGX+gZOWqC42iWqlHMLvDUTZZhqjtgYQNA5nhR3Wo2I3fsDyI9fy
	 Hi/Xnzrnx7yl9q1ygOPrYchmtkwterv4jw2k0zEjhzO5cmvcJ+gKsi6yaa2xIQJzuiUw65Txxh0R
	 sYyl+qdr431z6GwiSAlKdnILGPaRQjPXe5CauB2euI5epXqz+MHVqAb6NakB9hGzFYCtI8zrWiww
	 xjvKUmnoeLWABcgDTvGqRLLi+UDRrz1J/GBcbIcFQJjEt1SaeJ+xuDG49ptBWe2ECv9T2PHoLcwL
	 o7cMJZdQ8sUCuQhIxjsqvN5feBOLlNC8JFin1AKmPGAaHph/+p+/adHCCL5crZdTUKqzf0TNU2Ze
	 8yl9dTfT0Toaalx+G2n6mX6hXf4Jxs6aBkWUN4NY1vKFtIZX6p/8N++oir24xe+6tBzYPoA4ivmM
	 ZutlFsdOwPuzJ6iCyO/Jfta4DeTv5z+gxYO1b+krA+rKTJS+r73JXYPJghQloE310nOmtrgtOxkr
	 oqFu/f/jYu5/2HR7eedr4CUmAo+JtH30zHqYCTXQ3vw22m7pd2RY14JH2wGne3wKHH7+IOIkwfrv
	 2owIq0kqfEPZgQjyHaTccA5GkboOFXTNWPIe4yaXdJTGWWeaGHSm8WbLPAgxfK9mAAeTgJy7qyW2
	 XOpsZaglBup6sllYdCFXoQ6ZexIHEaOH1lX0UPaOmW59wP51c5LXmXNNOMbMlfR8fXFzIBy3Zj3A
	 GfJNZWo+vPliOIKj5Fyr5/A3NLpQEeFI53eg2Rb3M4omhZGqCOvpfl9fEI+FdaOcJ8pHJV9taWPE
	 BkZIqiT+Y/2WFolm2jmROdvIl9zEzfTrnYH7/i/C/Jdmow0yzwcSmuDoMeZhRv0DqcDV4qeETm07
	 OO6DRfZHKloGYuf6yCl29Xp1Oisx1hhZnalDSoEnuqG3VGAcmbx3j/FZFqKQzu221Yyv2Hb8fP4t
	 t+u57vdEDAuVooncY9VrJ9OYkFmrw6+Olo9CIx7T8NxzRG7c3i
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Wenyuan Li <2063309626@qq.com>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenyuan Li <2063309626@qq.com>
Subject: [PATCH] mfd: tps65910: add error handling for dummy I2C transfer in probe
Date: Tue, 24 Mar 2026 17:51:38 +0800
X-OQ-MSGID: <20260324095138.9764-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tps65910_i2c_probe(), a dummy I2C transfer is performed to work
around silicon erratum SWCZ010. However, the return value of
i2c_master_send() is not checked.

If this dummy transfer fails, the driver continues execution without
detecting the error. This may lead to subsequent I2C operations also
failing, but the driver would incorrectly report success.

Add proper return value checking for the dummy I2C transfer. If the
transfer fails, log the error and return an appropriate error code
to the caller.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 drivers/mfd/tps65910.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 6a7b7a697fb7..6134b28d3ec3 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -472,7 +472,14 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 	 * first I2C transfer. So issue a dummy transfer before the first
 	 * real transfer.
 	 */
-	i2c_master_send(i2c, "", 1);
+	ret = i2c_master_send(i2c, "", 1);
+	if (ret != 1) {
+		int err = ret < 0 ? ret : -EIO;
+
+		dev_err(&i2c->dev, "dummy transfer failed: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
 	tps65910->regmap = devm_regmap_init_i2c(i2c, &tps65910_regmap_config);
 	if (IS_ERR(tps65910->regmap)) {
 		ret = PTR_ERR(tps65910->regmap);
-- 
2.43.0

