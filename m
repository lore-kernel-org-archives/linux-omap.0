Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36381A681B
	for <linux-omap@vger.kernel.org>; Sat, 26 Sep 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790386409; cv=none; b=uS6G6AvHXwwZLCPzI4c/Rlx80suAaLQT+rOfZ1WJIYW0JngnjlERNbtSXdLvVBl80eKl5sCq+wUxUAwY5am9n0xmkvfSI1JWDox9uH86saaqV0+k+3/7jTW41BrRhB7Fkm++F39Gg82esQdJr0kka2psYlxO5HzxnW6JA38WUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790386409; c=relaxed/simple;
	bh=1f1mz/u1DXLFELJxB0lWigtpTDzng/wOa0yeqTZVdUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0+I2uJF+X0yBjWVQZNpXvp03L5a0ncWGvrMH/gX7wuEXKWOOBQmdBEFxuq26nBYAivgDrnn2QFS65JeW6XNra5spEX6Oj3ZVI0HOKyXFAY257JokD9F2zhg9R/SXNZvB3oLH+t+dfB2+UL+l++XFJc3L1TKZh/ZAgHEsvImhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULdY1+xs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULdY1+xs"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso9223105ad.0
        for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 18:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790386408; x=1790991208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XO5IQrDqXhCVEXobXwqmnVmb7P8gC0TesjStAXIcO2g=;
        b=ULdY1+xsnz/tq00tmvNx6qoyew18D1cJcNxiL4bmI7C4hbENDIwiiGFq/bdTGk0abV
         hHLWEWiNQ0wd/wm85I1Y3sPfiMk0K0K1Q8IlN80TvxpERd8+PutKTTbU1w1q4G0yNJdj
         CuMv2fNGxwo4ZBWniUqKGVrLaRX9yUvBKW2EIQqUxzL66aBGmy7glZQqStFDk1d5ea16
         a4DqnpivnP9JhhRe1d6OHMDyCToviItvixla+LzPAR6iUPXmWleyNJaLb2FU1noFiit5
         wpn5C3vziWs9dFTOY3i8BVZIfLbLMeosiZw6FKYlO4c4kD40skl5z0/v/2mFKQ/j6HGb
         EEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790386408; x=1790991208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XO5IQrDqXhCVEXobXwqmnVmb7P8gC0TesjStAXIcO2g=;
        b=pHMRXWGrIcEFNE9598a4YGsnEpLorkEmtWS4Sl4M9XVbESuw6oLqhO04megu0RDMKz
         Qm+MJu719qGPPEkWYVaWvmCNBUAXxvISbrTJ4iJ40/HsK3/HZc6YJhd3MBKIY2jyEd57
         HzWn2vdFL8WSnMiiROLORsf6k7FytXbWsXnTsr8dnpQllnN97rHJ13NJ/jTsJcOPnZGd
         WgFUofBhgObDAeN+SuxnZthlSPY8jTaJqtXGKT2eH+SuaU0snKR0ymzDwj+g7R7FK/VD
         SGOAiRytDdKGdzeU9dVBfpUboqj5S9WZYYP7RzHw+5PIRSinWfjTIr0HiJ1cOs9Uu9/G
         +bVg==
X-Forwarded-Encrypted: i=1; AKwUvBwUYPzAMp5imeN9VSQUxau+OkBnFotp43fHjs4ImBJu1+J5Zj2yWbrQE/fcUIErKExuDNEg0SM495FD@vger.kernel.org
X-Gm-Message-State: AFuF++mbK424E0MqiVrxiyDnnU0waq7lHkz/vA9jYdSMwPBY6rIdYHTo
	p9kTP5yuBX5Sf0Slkl7U+PmJjxzXCvV9HuCHsREmOkVNAjn3hzvT1a+J
X-Gm-Gg: AYBFou2aFCOWhX3raSqR97vLSEj5EX/b5ZquP8acIYcIKZJHLDZ/tZfEu9ItQ9M2M2x
	QpDdUcWFgKUVjNBMxxAzd3urLGUChDkXgs/7TvsBe/1DlFmv15NbCsT5NT9FJOjx88sUMwK6yGW
	uJAmvpNFkSdKC7Sgjvq/AUQPptczfNhEClhA817e34YVkfO9bwLfH4sVjIhJb3VIyNAgJLpZUXs
	QgNKkYI1lsgkZzcwWc96hQEqDDcp2G428322kcx2OFsfCXT1MivX9U8YhJBMFGziiuAd+/dxnn+
	QOXQTuGUf7p76tFuDY6prduvnwdAZLOgE8WucPgex7m5+UMgExbVeLJrK48dOfknhqIWX3izoXR
	2c/75uce7azWxJa9Ppo9BIcKEj5TEBjMNeKFs8jpeYJUCA0rDv3mJZ0EmLLqECZPoLphk4yBB4Y
	lWVacvgddox8CzGZntoXgESthTWvx5eq+fE1iTU/wBgzqklOOmWwbqXqGSGySXRLqov/T6bR0E0
	dIRptQSQjSMrVTQqA/jn+ZOxfDppGLDb88uvdK615WSlwrQGUPvhgEN4Rmcj7RjIAD7fTQYn8Zd
	aLcaTrlpWDCXe7kxZcB2pP83NCklC0EYukIAVqS1+kT9o4E+JcXtzTz9a2U=
X-Received: by 2002:a17:902:cf0f:b0:2d9:2ff6:246e with SMTP id d9443c01a7336-2df7e251f3bmr42954915ad.23.1790386407959;
        Fri, 25 Sep 2026 18:33:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fc39ddsm17396165ad.7.2026.09.25.18.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:33:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: mfd@lists.linux.dev
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org (open list:OMAP2+ SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] mfd: twl-core: Allocate modules with twl_private
Date: Fri, 25 Sep 2026 18:33:25 -0700
Message-ID: <20260926013325.75073-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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
 v3: Capitalize Allocate.
 v2: don't use twl_get_num_slaves().
 drivers/mfd/twl-core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f86df356d658..0b78fe30e047 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -159,7 +159,7 @@ struct twl_private {
 	unsigned int twl_id;
 
 	struct twl_mapping *twl_map;
-	struct twl_client *twl_modules;
+	struct twl_client twl_modules[];
 };
 
 static struct twl_private *twl_priv;
@@ -770,7 +770,9 @@ twl_probe(struct i2c_client *client)
 		goto out;
 	}
 
-	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
+	num_slaves = (id->driver_data & TWL6030_CLASS) ? 3 : 4;
+	twl_priv = devm_kzalloc(&client->dev,
+				struct_size(twl_priv, twl_modules, num_slaves),
 				GFP_KERNEL);
 	if (!twl_priv) {
 		status = -ENOMEM;
@@ -787,16 +789,6 @@ twl_probe(struct i2c_client *client)
 		twl_regmap_config = twl4030_regmap_config;
 	}
 
-	num_slaves = twl_get_num_slaves();
-	twl_priv->twl_modules = devm_kcalloc(&client->dev,
-					 num_slaves,
-					 sizeof(struct twl_client),
-					 GFP_KERNEL);
-	if (!twl_priv->twl_modules) {
-		status = -ENOMEM;
-		goto out;
-	}
-
 	for (i = 0; i < num_slaves; i++) {
 		struct twl_client *twl = &twl_priv->twl_modules[i];
 
-- 
2.55.0

