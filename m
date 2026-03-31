Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148173E0C51;
	Tue, 31 Mar 2026 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960308; cv=none; b=DmES2RMreC4LsWUCDJcet9TTUSnRR8oExKkwoKrnnuohLJpoFPHHBhc1DrZTrWEVjPOLzia45VxHO/tS2ftmnMrXvjNp5bNT9JmffTqJogXd1INOy8CmhH2014SNUJBSyBoqyV1MzoKZMqH3OKnx3zCfIvwv6tSSWjPlu9P31F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960308; c=relaxed/simple;
	bh=ld0ceCtRwQxW3BqX6YHV9i+WaXMmLeZ3mJAWYproT2w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=faTl6YwweOb1Qxeyi1hvHFHbNp7xMOvU2SmfKw/o9JHES98uPQhYWYzjhEF5ZFl6A+eu4bZh9bLp0Ds3/dupqmltDZIIbkBit0MJGmrSlMumRG+tbfVTe8jDhuWcxcb461uNVFeQs3AnNpUtD2NvOMgsDoS8zP94Ls4kCSxHjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kwJu93PG; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kwJu93PG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774960297; bh=5/VvbOXeI2Yc5WbpHQIFX2KzeSEo9vfcmy/9QvyW8Kk=;
	h=From:To:Cc:Subject:Date;
	b=kwJu93PG7gujs5JTH3CeDHqIBmTkANLRw+FkeEr2VvCInaKGgtDqkJYrmdLSDaaYE
	 u28r0k7SuHRW+XDxhcQAfzGtHBKQVO2XaYud1yTTZUZ4cN8rFUhaBLLSq/cDfqZHCd
	 dS89R8OW1t3d90KQ7oDfDfNLyUN2pnh7Y3iRvJFA=
Received: from LAPTOP-KQCD4QBN.localdomain ([123.121.145.48])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 7E119C3E; Tue, 31 Mar 2026 20:31:33 +0800
X-QQ-mid: xmsmtpt1774960293t512z5y9j
Message-ID: <tencent_74C5C53384C579056ED161B70122D16ACF06@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GmJ6tVvoTTBz7ZHOYyDmyVzYbmrj7uQfXW9BoPELZ+4VVwbgugR
	 s055osWOrd376iF3PjKLRvvyuCtVQ2kWC1DHK8pvmiOgHXKZ+o9vaZGzcYvOG2L8TDp9IAZmNI1v
	 Q6lZp7KbtqHcn7qKUn/KON/tvWS7bBN+Qa4Kxm998McPEYry7KYkULgTIpOgVvh9zD8sDFHRFP1U
	 RfURKYAHGRdqUoYTap/nAIZawEUFCDwRYliYmNifvNdXleOdwaSq/u9KnqFn04iYuSchP5jlU8nh
	 1snclsF4FP5nS5468/INOesDsz/43x3c5vZKHh2hZXXy8dc2aqZkq/JmDi1brNVx/z7KdJ1dd0W4
	 682txVizzOVF7lSxkTISEm05zuIivMiKz1zkXvk14C4+rlOZgW09X6jmdglBk69To5zozqOFtSqx
	 62OMPnDWs2lDlcLdxGuPHZN6BBvTaBFpCzyPGHKyLj6Ei1ef//CSiGJb9hfUP9FWN/DVTG2IpoqJ
	 qaSjZhB89oGjy1Y3mLEToa7NS1l5eYNcvb3AHsagkbPZcrMbwdEAI1XA5yLIfufVtKgZ859DyaxB
	 FG62t6twJdAlHTKywVQl7/zsw4tc4M/WqiM6AbEBdhgwFpIwJKurDMifeZJMRcZynfHehr+pJrHC
	 aE2nqggS4i74AbRr9bAJYcbCVHCKtyYHGqbaYrRe2TtcbhP1stCrv7jJkRHKNbUTamelbK9kpVVj
	 bCfks+piGzcY//c6QpYvsvzWXu8KkVjCpsk0dVh6P4dHYYlfVsGqRQ2UGiFOH7akPGdZ+0oy1CZQ
	 DaS0ZCYeUWAjtKkajWzgV3GfUFNcCvLTO1l3MLmddZKw9P8jRaGbwhSqtqT+lu1tEK6dCo5elmeD
	 4LOL1TfSkWIK258ybXFmM1gdv30rm+etOMOXTED9Eay8j6+hpKfURKtvLdzPOd85zDAURNHvNcFY
	 tKrxS17ESiRajqCtYbWA0rgUZOrnFpVpoMCmUqrAqmbcliD1+SNTcTIZIMbs8tE5lrpQAC1lImR9
	 NKclUMz1eRvjKv7AurXmZVHMHC9X6EbQmlD50DTJChx8HZeWrlE4rORcErwhI=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Wenyuan Li <2063309626@qq.com>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wenyuan Li <2063309626@qq.com>
Subject: [PATCH v2] mfd: tps65910: add error handling for dummy I2C transfer in probe
Date: Tue, 31 Mar 2026 20:31:31 +0800
X-OQ-MSGID: <20260331123131.10635-1-2063309626@qq.com>
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
v2:
- Use dev_err_probe() for error handling
- Replace ternary operator with if/else
- Add TPS65910_DUMMY_XFER_LEN macro
---
 drivers/mfd/tps65910.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 6a7b7a697fb7..31e4726118b3 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -21,6 +21,9 @@
 #include <linux/of.h>
 #include <linux/property.h>
 
+/* Dummy I2C transfer length for SWCZ010 workaround */
+#define TPS65910_DUMMY_XFER_LEN 1
+
 static const struct resource rtc_resources[] = {
 	{
 		.start  = TPS65910_IRQ_RTC_ALARM,
@@ -472,7 +475,18 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 	 * first I2C transfer. So issue a dummy transfer before the first
 	 * real transfer.
 	 */
-	i2c_master_send(i2c, "", 1);
+	ret = i2c_master_send(i2c, "", TPS65910_DUMMY_XFER_LEN);
+	if (ret != TPS65910_DUMMY_XFER_LEN) {
+		int err;
+
+		if (ret < 0)
+			err = ret;
+		else
+			err = -EIO;
+
+	return dev_err_probe(&i2c->dev, err, "dummy transfer failed\n");
+	}
+
 	tps65910->regmap = devm_regmap_init_i2c(i2c, &tps65910_regmap_config);
 	if (IS_ERR(tps65910->regmap)) {
 		ret = PTR_ERR(tps65910->regmap);
-- 
2.43.0

