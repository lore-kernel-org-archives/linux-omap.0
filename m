Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114693;
	b=t/Ov/4fKntevdZMv8Suhhfa/4JfyTnrqcEYwXQ8I+T22Hpf7ZOJ15BQGxCEkKbZ+QptN
	 tSjlb9F8rs6z1xqpAcSFx6xsszSJ0Si6Taq9pOuZphQ0jiS/JNcDYsYnGDlS6CwhLZekQ
	 bjtFxEsrR/houI7IrNqo1UVJCwfVQ94Gfb6dMxM0uDhVHLxq2ta0EJktpCCshMnANG0UC
	 wgyhNzAdjjE3xzxhE7Y1q0RBa4zOkggicOlR2RaXDmkEhC1OuDAvbwDpRw6PUO71IZc4b
	 y1kZ2289Lk/mBY8e/SC/Trp/9GE9BuyZ1BuvHmofr83BoASS36peAUVhG9vFPxtY+pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hDdFqYy/BQ5aunaQkAI9mUkJJTdQwxxuNDFrcHBEph0=;
	b=KLt1C6e+MZECDYVaeLTzXfg7FXRpFzdlc0Bu80FqkKtuQmlywHuZV9ZrjSuXXk/06gf+
	 pSV9PHZqtN0JgnxahQ+TQd2WASp5d9wDQEC4RaM+pdfBUHzsy95AlGdLPvuHtg0LPetEg
	 g6vzaPYl31rIAqURgLX1a+4/rU2IcFDLCxw1LXXrBRO0RhTPJ35l7nYIfpGeUSY4sosWT
	 JW0ypN/gjoPEhug6BJQQLuwmg0DT/OUZWa6dsn5doyDanBYTGegyj749WVkQ1UPjLLGkZ
	 32/QCJ2udwuIgQaLjaMGlFW6Dpahp6PNetcoO6gMHEWKGzPq3N9YD5tUTLDrAOsLqfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBAYUZK8;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57433606A32A
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 15:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57433606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBAYUZK8
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c46bd7a7345so206906666b.0
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114692; x=1793719492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDdFqYy/BQ5aunaQkAI9mUkJJTdQwxxuNDFrcHBEph0=;
        b=TBAYUZK8KvgIcWUedocZgwbiEiI/0dkvjz3DRZ7aDfIpEXiwshPWwZodz8RTQmPwwu
         /N8kzZGEbq1HnbOM9AeZfCwNGHKVyeR9rliCKA55OEGckc8lAr3xsJhe9iRevtQVUsyc
         4pb0h8Ff/XPEIkRuAI1GrxjGm6C5MUXnpWtItrFOWCQoK0hRQe4tKyuu8ljQC1ZjS3qF
         dmXBS+cC/suvGEXD1eSnT4GsqoPRK9KrAWEHQvY0yxYjEedO8/DTbcTnf+CBPH/5/cn0
         Hvk+fhQnVDlSBSeJCBYgiAe8y/EFa7c2lT8nQcpXX+cvMqDdQ3czJqC5qygVHnjHANik
         plHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114692; x=1793719492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hDdFqYy/BQ5aunaQkAI9mUkJJTdQwxxuNDFrcHBEph0=;
        b=PKs8cDQN8znDvCuElIcjAbq4vzvxfHSsKAVBG7xPpi3zNohnnE6Yl1CR6wwaqFGzPa
         u/RhTx728yxtAkADfKCxn22Gw6aochJmQP7P7sWR3Lz6xM6s/hbxWjxWZDTGRefeCZ8p
         Z5Z6njAYztF3wcFKidWO9JCKxwu3wYjQFvDKqWk4aP+hzT/mQI604Q/zxe7dltY1mP09
         MRtuzYAQgcDaMqoTzN4wVXkgoIERWZMBpYA+IuUU/DVzEzWOWqUnuXK4jvexE00Va2Nz
         /5sJbPHoe0YXacI+xjyPi1zl67dG+59PU7IU8d7qqFFPu1oRaJucsgBiF/2mT8dMCBVK
         CtyA==
X-Gm-Message-State: AFq9FYLhsIpgRWGjGhklFSI1KS2EunpKFvehIpfZuQtMy4tEc4LHpNic
	7thA0KoO1lKUGveBxynThpd5hrpv2ZxSSvI2ZMxYTYDxX4nl/aJfPc6g
X-Gm-Gg: AYBFou1a2h0oAc5CY/SM2D5W5YVh8psviyCqqiNTNryJ2sle5evn5SiYpI/vyv18pB2
	aLSIFG8tsIBDuqSQ28M0cI3MNksYWlrcfBNVPqVkbEpOYC9gqFjadDMmq/RC84s6qhFM/a6gIeS
	/gWX8PNtbOIFF8WXFJkSh63ZnavKm5GLHCwzMgNjDatQVhyt4I4WzIVpKgP3IWeTAnAxnnplfbs
	lTnq5pabwnX88SYZWtl0SJ+NCI1nbwjH33vzXuPQ/See/gmUoVApKSWR3UVb0orFTXIFVz2V8gW
	s3Gi6XNyqM0VmMf0jIcJWrW8WL59Sjhb5X+tRSgH4+f2YWeTMCXkxBwhFtKpEt6V9sLeP+ayihF
	QDMUqWf85A5jHs7IHqibZX5cxFcsdxqk5owZpfQQLxrdkmVrQhy/ghQRshXy9isbd5tSGR8Wper
	zTVRw8q5uAXYP8VJnOombS1ao2XVAYhkjPFo8d7JOWTY4JgtsMgLyfRoQRpXHbZ3C/uMAcdS0yL
	LBPghgdgpfPSyAMAiBTobLSTBfhtgcMw3Q16ZYrwTDbBOIXVI8RhW37oxsTZGN4B1OKdHmeukW+
X-Received: by 2002:a17:906:c10b:b0:c45:219c:7fec with SMTP id a640c23a62f3a-c49a744591bmr269233766b.27.1793114691772;
        Tue, 27 Oct 2026 08:24:51 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd529b3csm467303866b.37.2026.10.27.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:24:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mfd: tps65910: Use devm_register_power_off_handler()
Date: Tue, 27 Oct 2026 17:24:21 +0200
Message-ID: <20261027152423.194794-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027152423.194794-1-clamor95@gmail.com>
References: <20261027152423.194794-1-clamor95@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <digetx@gmail.com>

Use devm_register_power_off_handler() that replaces global pm_power_off
variable and allows to register multiple power-off handlers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/tps65910.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 6243b66b1b6f2..97855bd9cc3c8 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/core.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/mfd/tps65910.h>
 #include <linux/of.h>
@@ -425,16 +426,15 @@ struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 }
 #endif
 
-static struct i2c_client *tps65910_i2c_client;
-static void tps65910_power_off(void)
+static int tps65910_power_off(struct sys_off_data *data)
 {
-	struct tps65910 *tps65910;
-
-	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);
+	struct tps65910 *tps65910 = data->cb_data;
 
 	regmap_update_bits(tps65910->regmap, TPS65910_DEVCTRL,
 			   DEVCTRL_DEV_OFF_MASK | DEVCTRL_DEV_ON_MASK,
 			   DEVCTRL_DEV_OFF_MASK);
+
+	return NOTIFY_DONE;
 }
 
 static int tps65910_i2c_probe(struct i2c_client *i2c)
@@ -501,7 +501,7 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 	tps65910_ck32k_init(tps65910, pmic_plat_data);
 	tps65910_sleepinit(tps65910, pmic_plat_data);
 
-	if (pmic_plat_data->pm_off && !pm_power_off) {
+	if (pmic_plat_data->pm_off) {
 		/*
 		 * The PWR_OFF bit needs to be set separately, before
 		 * transitioning to the OFF state. It enables the "sequential"
@@ -515,8 +515,11 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 			return ret;
 		}
 
-		tps65910_i2c_client = i2c;
-		pm_power_off = tps65910_power_off;
+		ret = devm_register_power_off_handler(&i2c->dev,
+						      tps65910_power_off, tps65910);
+		if (ret)
+			return dev_err_probe(&i2c->dev, ret,
+					     "failed to register power-off handler\n");
 	}
 
 	ret = devm_mfd_add_devices(tps65910->dev, -1,
-- 
2.53.0

