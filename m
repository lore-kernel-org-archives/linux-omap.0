Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E1513557
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059830; cv=none; b=iELc6mwFf7AFwEYdmdkPvBuOi8zlx3oV3jH2bX9G1eBixQqdXwmEDPExkLrA2/9JvcnngeahHBbWNv5ox0/qf73MJlZd9Edxm8em7WLq98YAoRBEpXQa0l+co0yeNLhnpvQwbZk0nu5g56vlxPrmk60GamU3jnaInV7eTBppfVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059830; c=relaxed/simple;
	bh=nSmXuMKhoIgAobqpkzs+VXQaRMleH57PzdSWjcWc2zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPgjGhQng4+yIm3ervWMTawK4ObbEajuHKfW/xgRT6RHDzwIzLNetD8VC85CZkCe1IIdlwVnbwNolyR/FJ0eDQo61RqY1T1GR2jjkxokMZ6I51dfRhj9pcmYJTugMzdMFi2YCcADRZUrOt8OhXpDhYlw5BIcxQ203vF1Y5dfBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1bmfbfb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1bmfbfb"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so728638f8f.0
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792059826; x=1792664626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HteFBMsv61wMUi+iQYixSn1H5G1GsfDrtUwr2aL1cHg=;
        b=G1bmfbfbhZpSyS+0T9SyKr8bo1LQdS8wSGccWKWCpunwCRS5HGjEuwZzPSL7HXHo4x
         JpHNGZIhWP/8tVZsIx7MLvCezVNmyoqIlg/ofe1XISZk0OzdDc0a6IQCKMsyoWlB8pGE
         HVrQCOtUubg2UVXbWnd4A96LJAiskP627wMlfJYOsEndqualBXz8V0IkyoDAUswJ9+wB
         XCgSmJx+p8azki+EAzjidkSa32igo074pXzWmnrE8bQBRXl3j9rgrZFVfeCVdLyvey6V
         JU1gO/T0fFeLtjGSReXsjB2JosOD/YOJjTBBVB3lgS5ev1qySVydW9jIVLvYzA5cinMh
         mnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792059826; x=1792664626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HteFBMsv61wMUi+iQYixSn1H5G1GsfDrtUwr2aL1cHg=;
        b=fZ3ukIwX8BcxXrYS0wJCLyX1+L8tC47st1qD7bi2+eZwLUCn1SwCdJsZC2HJs0/ouA
         IGDdiI29T+dJ6tyZYdGnyOGsIh8RmCqvfLFUKFttGtDWXZ+lvs7m43HTHXaMkOGEKt7U
         wk/xyN5H5CFEw3w8Ly7At4aaEUVzC3q8yWAJ9uU2mado+s3xrFlSbP++XWWbGsJGPb99
         9Gi2VFwTaMzWZNA+bxLRo+2UeESnpRJxtGnaX63K+9kNn9Gl4LQthWGmeij7c+RSgNnf
         RQcR97AnmcHsuhbCgGggr6HTkR2Qkhcle9hwRB7+d2EjL0aNjMnrNMT9Sq6MEfC4+pLo
         Gywg==
X-Gm-Message-State: AFq9FYKsC+w+an9yv51CQGFY1fSe7QE26ir0JG/cmhxkw9G+D0PkllhV
	FGDcpglVjCH/b9/HIuX0AfkMZOwB6XLSzcrf+FNtD0QKK4xk6DcnaKj4
X-Gm-Gg: AYBFou10szxiDrjDCbezwcLGMlDetboiZXh/taKREl2AUqPZXC8Sjjo/cPHF5+e7+lm
	yesEUStoZOcaLsteZ6pkqGJoAjxs3YpznLa1X86hYxvs12o2dbNK/9JQYoQRgPFiosHoHC1tGB7
	xYkNJgVCih+ySQZEwlzJewM5DZcXws6jFf8IVlp/fd2GHErbNN4nXfoz8VxRd6nDHwPWyay7IVK
	FOuyucb8ZpnXutcAcN6vanYCXZ7bbg5WYnJ5R3lIHBIVorSUv6rL6iSj7DkLssMA6urX99uBKjF
	xsfltCy5koVkdLidh32irNBQixTKv+AEMl+1XGILsSP4qRmOhUpfzCcZ3sT1NeVchxmskSAeV/S
	Y4ZjV3s3iJjygF4JU/cNNrfDK2bQP/TgUXYDKI2k2PORcp/SoVEhHq6tZybwd4B1jqM2CpZdw0h
	QkoF0UUqduZcAlwmJXeEr7l4pWlVlUvwAxHT8goFk/ysUVysAmGs5s1o6MR4H0zo4YBLeux4tb0
	jFGWynp+IxWZkU/ekg=
X-Received: by 2002:adf:e005:0:20b0:48b:437:8fbb with SMTP id ffacd0b85a97d-48db948204amr27843290f8f.19.1792059826507;
        Thu, 15 Oct 2026 03:23:46 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab6361sm14952542f8f.32.2026.10.15.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:23:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] mfd: tps65910: Add restart handler
Date: Thu, 15 Oct 2026 13:23:20 +0300
Message-ID: <20261015102320.23760-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015102320.23760-1-clamor95@gmail.com>
References: <20261015102320.23760-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <digetx@gmail.com>

Add restart handler to reset hardware properly on system reboot.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # ASUS TF700T
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/tps65910.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 18b76359046b8..a1734fee1485a 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -440,6 +440,20 @@ static int tps65910_power_off(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
+static int tps65910_restart(struct sys_off_data *data)
+{
+	struct i2c_client *tps65910_i2c_client = data->cb_data;
+	struct tps65910 *tps65910;
+
+	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);
+
+	regmap_update_bits(tps65910->regmap, TPS65910_DEVCTRL,
+			   DEVCTRL_DEV_OFF_RST_MASK | DEVCTRL_DEV_ON_MASK,
+			   DEVCTRL_DEV_OFF_RST_MASK);
+
+	return NOTIFY_DONE;
+}
+
 static int tps65910_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
@@ -525,6 +539,14 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 				"failed to register power-off handler: %d\n", ret);
 			return ret;
 		}
+
+		ret = devm_register_restart_handler(&i2c->dev,
+						    tps65910_restart, i2c);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"failed to register restart handler: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = devm_mfd_add_devices(tps65910->dev, -1,
-- 
2.53.0

