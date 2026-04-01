Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8061A9F82;
	Wed,  1 Apr 2026 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020306; cv=none; b=iBl9snDhQhsR3NV6XnJ4Pjkx8tjprqPSEYTBUfYeYde0W0IwVMSIOHPj6k52sMyOOnrKZg5ZiYBeP2jwVIN3Bi9vL6aODXU+igdhAcJ4RaRRYY53eVsfdBupfSyfWKNMspHjs/QuB/248GZAlvcMkXtkK7WNXq2hVFXhCP5FzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020306; c=relaxed/simple;
	bh=ND1cUuEErH2AdNPTFBbsVIYswLNxvu3CDQQQx8hsNjE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QknSFReKI6J7OY59pgn0YjXirZeKk+2C2Ci2TaSmZQIvpos4slehtpDWxhhVkPebRFHSlXwPDwzSb8wohTJaIeo0JiMCRBkZPcm+aCNBpAkTM5q4zxq5fGbwHUim+mTFUhyNdNcFg+tzc9U4TTCAWGqwZU6gKgs14r59lCucfbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pzEfluo5; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pzEfluo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775020293; bh=TkFX3orHFyRY+ygpTsAR6Hl6Oki8OsXPNZzTf/O7Wx4=;
	h=From:To:Cc:Subject:Date;
	b=pzEfluo5CpZAWbFnRxYo17GkGUs0uiY6bJNMJbnYCvp4RqdFTBJibaSii6LWXP8qc
	 NDgOBYoAAdDkEmZS1BiHctaxD75ndJyllj8+yUZQgO3BFh3+DHjOGsoUu3f3/RKcqE
	 k8l4x234vmL7vxOFzS70pPTtlTn/HM/nnJ0JKifs=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 26085003; Wed, 01 Apr 2026 13:09:32 +0800
X-QQ-mid: xmsmtpt1775020172tek2ganzz
Message-ID: <tencent_01102156392EC89EDF2CA22A7C8B4ABB2509@qq.com>
X-QQ-XMAILINFO: NAEPl/HULyKM0b6PGDzEYvzldcZRCFgS0CgtiJsluNHkzKlIrHqqYu9tgsbge0
	 U/+dT/mmRoN//i3ju7leELdLR/BIjvKd96kAY6RDnchOL6LYqS3FgL+5YDgBAVRIXH2H5FceU0Is
	 j7czDuUeTPAl2CFkOiPPPu5pwhqsN0r9UaDD2Nas79yRX/jgpTs5nEwc/t1mheW53wpv3VphDyIi
	 m918rr0b81rWkUr522Vr8mbAAnZOd5XnNClPERA0Z+CgV/ggF1x7ZO3wLwR8fTRR6QKOSfodHgCe
	 L9+Si6fLvMJEiqSVoxh3HdhQrLW6pbYhitEdy87uOTTb2nFhYS19mD4OVvVqW3uXFTJBSvQLiZRL
	 jpBKZMBbanMW5nHJvoy4pHKC0gZt6DjCY8vJBi5E7RM37wVvmq87LJpl/UbsNmGlJ890rKmZTN5g
	 EjvCKV0dnMX0Kkq+ktRbAOBLAuj2IKaQlf6AZRWwZc7hiRCBKTb1o7pRMBQwjcTfTR0OdCQ5mzJV
	 mZ6sxoHGKZnu92A4x4LIH40sX+6nBtTW7vDIu3Ic24NUdBNOwKEW/Nbj5gf9WsMOROoSgpL5WY4d
	 ZkgBceSaQ9wOHCI3Y6HrubsiBLXX1UJUWyp0uW87XIIfNBUZu/6Xld//4R4lU+Y/Np5LzNwc07Tw
	 Ru4wR/F/CEjkfzuN/CEUeA/8o2ExKJGv2Eq3F6VHdNbDQF4wTAYL2i6ef2WH8xbynC2JSRpCVstX
	 KRHZyEwBmd7wX+u9j6+IdvA5V3Zi9rzivyka/mKzN21gBP1x6JtwgjF05mVKyLgrN7i0RQd6duPh
	 4wdT9/f9ZJGYzoCMJujDDS3fjF/EoSOJRUapwPZBnIjGKa0HQZHYTtkAIs1cyLbFeHYCxTCQT/6z
	 Jm5j2cgJGPEiPpXWGyihKc0dFsKSEu+TQemfM7NB4jflizivmKb1d1Jq2e9GlUwk63nJBJOHkNHv
	 PkuyhNtdOv8Ec2vYgG2TraZCq3Z1hATtSLsJp3IVdlqudk78LEwFAZb4DbqBWXlsERlZ91QTjzd5
	 0B/nXRxClvmQw8sNYEmpfODo4Q1F/RN9XelrnggEQ+LBbcDsrv91yw9/izTi1XKMzcccOuSh4doo
	 wPXDWXeoCg1KY1rdk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Date: Wed,  1 Apr 2026 13:09:31 +0800
X-OQ-MSGID: <20260401050931.2543-1-2063309626@qq.com>
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
---
 drivers/mfd/tps65910.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 6a7b7a697fb7..6243b66b1b6f 100644
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
+		return dev_err_probe(&i2c->dev, err, "dummy transfer failed\n");
+	}
+
 	tps65910->regmap = devm_regmap_init_i2c(i2c, &tps65910_regmap_config);
 	if (IS_ERR(tps65910->regmap)) {
 		ret = PTR_ERR(tps65910->regmap);
-- 
2.43.0

