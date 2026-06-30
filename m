Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113736F905
	for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783012; cv=none; b=Q0HgRRLUMNxRQkB/lJsVAqISC1drkcBzX/ZY64dO7a+ZYCLDj2V9YASFn+55edHBVRDayA93NrEkr/BDe+dCFwvKZokUtqDE4xuPHIh2M6AdToJmBzy1x/0Ee78P0cKx4qNM1J6kyBrGlpuv5LFIHNjLmO0Hs+gWVx9tLNEMpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783012; c=relaxed/simple;
	bh=bXq+zgUWFqiQ0o2Lg+6U13J89mOnPzmZWo0e+EaO3GE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZS+O8bP7etRbJFQXTQKoN9GsMHuaLDcytYIF1sueoRsvl4HJydqpXGSoxeUOt7lAirwecMXf62uRQFpFYSLEGzsRwKsydCXjXXXkEdmFJhKxKv5r9RGjtnXY3+SCYGH3Auyi2GeG7YkvrynUGAGC7PqpuQTdkozrOZmrZ65X9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEUmtRwv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEUmtRwv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37fa53bc22dso2614727a91.3
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2026 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782783001; x=1783387801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYEsXemwGTTK1ewS6tBft6CHPQFa/c3l/+EJIKVBxps=;
        b=YEUmtRwv8JqhJz1Dp84DuXJqYuOJaHhwGhTc4vNrgK6XQshxZ8FMMsegSJQHrnb0F7
         U7ol6K1ZJZY50ajjyzlSRaVBjN65gzGXoaqL4RO+UeD3bYtVMRramz2sZs7MtoIzTvqN
         P7ZqRzJnwChXlNqj8JXUCP1c6QPj5ai2w5vu4TSfFO2eXGFHIxOz25ZvQ19esLpWYoh5
         Z6GiTx1+QQ4thv77oE3il5PuqXA2erFI+xKllFPBuV1zEiWs63+jylTUEsRK2udN0h04
         yf9bs+ecNyVxAdHvTnGrtPAheDlvG58lk4tQiGnr1Ai0h+aJm1xn9knLQC2yvz/SyBbw
         LnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782783001; x=1783387801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYEsXemwGTTK1ewS6tBft6CHPQFa/c3l/+EJIKVBxps=;
        b=GrEm+EXMj4pyDirxzzGmXdjNIBAsGV9lJUPuikGjWPJqpdekD9XNiGie40ceJSxK87
         SflsTqQ8KK/ufllZ/anXg0aaBk+9DT1q+/V3dPnk6aQBV0mDpfiW5Gzz0i5WfQB5FzXr
         Vl9j4Cjmo2Yi8MgLF0QvEc8sAASVRPLjDCc42SAUh+ZnVPVlrls746ut0lZ7WMFUgNlO
         ev7XHTAhccc95ODP/2zHv86JurysXGXtyBT77lQOmSNzRGEN3Oj4nnrqejK/29+Mjucq
         mLiqKHLBycdnicxwNbcj/GZ1i7Z4h7yKGSnAYHI0VpSHh2jn49q4cax72r4Bxcxbz/64
         tZ6Q==
X-Gm-Message-State: AOJu0Yw36RdtTBltdzHoJ7uBfc7IyFS4jBEBfWm/Pj7V0oaU5dDqfDXZ
	id0vR76w61k3ynp3G4FUHEAlR/BrO5HAukGnTz5DOFFkYVQYkJEHXbwtbdeTv2NW
X-Gm-Gg: AfdE7cnBTgr0A+HE3JPbFc70WLec5EZcIcvOF2Lpf/wswNSAFwNIrEjUiDwRJ00vSr8
	8epEnue3+/fEUH+33ttj0rGol1KG8NrDORtWdprdu4ACvrm6k8YVUg6civSdXlPJA8usJaVf/Mw
	QtDZMh4CgYxSEbP9xGddeuLFqeDXjjfH6MUQZeDbi4otmC5M/OI70n8tIlrS2ceVJnVM1yppf5R
	k4t6ms7cCS4P3o8Ptqn/984k+9IklpttR2z+4yyaZTiMglx1MgU6YlwxkamLC9KwznOd3iLlY9L
	wCe7Sg1m2IRjo8oU4B/JI/a4SMjditO3+NsI0X14LzOolfgkCxK6Wgs9JtXlVY5jRRWgoK40Weo
	5HmxrSIj8fP8tUhDei1XGvY6o4dKwRTDUhE6a2U20V7jdVUB5zTWu0pP6915mK/efpgaX+bxCIE
	KjIKqh/DrsXDbC6lYqohzJzjJ0kBqD+eWuB1u9chP0q8oe2oRyW9a4Foc4nG1POMaD6Pu6xKgno
	IvHGMXAUg==
X-Received: by 2002:a17:90b:2808:b0:37f:b0a9:1a55 with SMTP id 98e67ed59e1d1-380525651b9mr1105722a91.11.1782783000906;
        Mon, 29 Jun 2026 18:30:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3805b7dd427sm63092a91.0.2026.06.29.18.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:30:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mfd: twl-core: allocate modules with twl_private
Date: Mon, 29 Jun 2026 18:29:58 -0700
Message-ID: <20260630012958.1498689-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to allocate the twl_client array together
with struct twl_private. This removes a separate devm_kcalloc() and
keeps the module data tied to the main private structure.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mfd/twl-core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c024a28b057e..a7754b7ccae0 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -159,7 +159,7 @@ struct twl_private {
 	unsigned int twl_id;
 
 	struct twl_mapping *twl_map;
-	struct twl_client *twl_modules;
+	struct twl_client twl_modules[];
 };
 
 static struct twl_private *twl_priv;
@@ -760,7 +760,8 @@ twl_probe(struct i2c_client *client)
 		goto free;
 	}
 
-	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
+	num_slaves = twl_get_num_slaves();
+	twl_priv = devm_kzalloc(&client->dev, struct_size(twl_priv, twl_modules, num_slaves),
 				GFP_KERNEL);
 	if (!twl_priv) {
 		status = -ENOMEM;
@@ -777,16 +778,6 @@ twl_probe(struct i2c_client *client)
 		twl_regmap_config = twl4030_regmap_config;
 	}
 
-	num_slaves = twl_get_num_slaves();
-	twl_priv->twl_modules = devm_kcalloc(&client->dev,
-					 num_slaves,
-					 sizeof(struct twl_client),
-					 GFP_KERNEL);
-	if (!twl_priv->twl_modules) {
-		status = -ENOMEM;
-		goto free;
-	}
-
 	for (i = 0; i < num_slaves; i++) {
 		struct twl_client *twl = &twl_priv->twl_modules[i];
 
-- 
2.54.0

