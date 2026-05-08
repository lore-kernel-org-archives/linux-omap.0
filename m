Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323453D1CA2
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236768; cv=none; b=ez6TiB5gFakf7TDDW1cvXaUKVz0Li8Q4wWg30NEKjO06jJIhTO0valmZ/t3cbwoTKyE7v+PaWBahNorsU/SxXHfoa9VcDZG9RgIa0e19PlR3p/dnhKrSww5un80tEk0RTFkgof2XY8ZhiUMKdL39reGseGAa3H4/D3i2QtLBXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236768; c=relaxed/simple;
	bh=MLsKqFKAlvte/Ce0NqocdXRNTbr4yO+y0hO4ieQL4ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pceO1NV5dUu+UOOM2C8HHPdEW3CDcB2exOUGCUf/wB0IYWgaa9pnd7Gw0veSY914caFQ19bNzfyNdsjDN7bcnleqyX/DXTCRUiGBdPy6oIWrhMbo1Bzu22G1NHS3478eaa102CppQRXieKucQVFcSVyhrRIKh6Kop1Tzf/8gpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgUS7yJH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgUS7yJH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2baca4df358so10242595ad.2
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236766; x=1778841566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOavnxnn6OqOTlyeC3XVG683zOAFflfaW3EaEqxauqo=;
        b=RgUS7yJHF5S+nPf5JD6tEABtHdxrNtQaJrGcgzx+QrsMr0ophz8FViSpG6miKoIdHy
         gygFgVGpvdmkSx7wQhbIlSjMvOkY9738FIa670+3IZTNbfPKYLv5QyrQFsSDPxpOoc+A
         OnRTjr90pZ5DjkOtmVbqTcKGYw81QzSBsUw0ZU8nHNez80VgQUDwEzK6m9mk9FMRXBgE
         orSdkYBdQHhIzTkqxqZr9D3r4Oe4/3Jk8qYS7JNQK+wfPAD6qTRB6El6hZAXcLQDaQTK
         d1K0txOJy13tdA8BdPjZ4nZjsEdCCa5ud0y6AvACL7b20oRgkTvcjkJ/1XhaGgAYoheR
         e+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236766; x=1778841566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOavnxnn6OqOTlyeC3XVG683zOAFflfaW3EaEqxauqo=;
        b=ebQp9wr4PrSKknXlTTEES9SNN/swEIpOxqKbVsN2TkLlIj+0zklkhoXDxOsHZTkjQR
         ZDKhn9JRjPKnH4+FluHnO6ZSocFZeM68MKm3fFZK+eSHUheoA6bqSji+BYaAlQH2Z3nY
         /z2Sdo1MQn9y68DQ4fQpRpIo9BOpKCrN24eYuA9CISg4I7c+bLDqh4hIfU/bh4LTeOiN
         lb34nBlT7swQMhdDJJxH9NNC9/hE47WzFgfS/zarT2oUzn/3x1D/bIKNN8KEX4NbSCdH
         GH9GNKOh9jURS5Tfs8/GphE0Itad0wfZPIw2C4r4jPIsxC8IIC8GQBiKJ6/VEzx+EyJV
         sLTA==
X-Forwarded-Encrypted: i=1; AFNElJ9D7fuxfxRBI3kTq65UWAwbfi+/4S5V8paYtdFZofHjbGy82uot/Wkkd3OpoMR7DrOfGxWfHOBw34QA@vger.kernel.org
X-Gm-Message-State: AOJu0YwhT3Gcvcj8PRIiwy1BAOImbMxzJ4XOSN/X0WM48Eo/VC7dKwga
	B/meJby2/P+AvTx/AztKSFG+ZJ7issKyScKOoenDoJeNYiAW5JFtn+yn
X-Gm-Gg: Acq92OGAK7Xwa8gA9h762oyafKqCcYkHHvZCkZ5+cSP8QsJtos+qdjE/1TpXhnZ4wH4
	8yDg2VmtWK1lP1iAJXjeaJDFt6DmC35lx3fyWI9PmyaNL9CrIap3y4PUPzFHZ15jVo2OnPU0R+x
	NPNnPOnjtzQpZgnmb6U/okBcZDA01YE6wA98n4f9H2NJv67Kiq9iDr9TYBCJ3ErhOckyjv2zuAy
	cVCGPC0HoSZ8bQjAvZbAs9vRpXv372Nkek5YXp85WfUGtokuAfS0I/fyv8mgDS4wxLnZU7ReSEs
	48ZohPX3qwvPTUFynonpV8zfvcHVevruwPnKYjm3C19uYvbGJ6Y0YJDcU/k4S5dnKJxDq2Vtz3i
	uAFrJXqHfqTtptBBIfF7ndIW/gJI7jBti/k9vQ7vVf2Dyb7dy986eSfq09L7mNNR3nB0iIG4wpg
	8KBDjJ6kGOY/PDndIivBgvydkwPB4DuRm+Ia+hum2q7ejPaTjXTNARFafLWA==
X-Received: by 2002:a17:903:3887:b0:2b9:6453:389a with SMTP id d9443c01a7336-2ba7928595bmr126945125ad.8.1778236766474;
        Fri, 08 May 2026 03:39:26 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:39:26 -0700 (PDT)
From: phucduc.bui@gmail.com
To: peter.ujfalusi@gmail.com,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	jarkko.nikula@bitmer.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 7/7] ASoC: ti: omap-mcbsp: Simplify lock and resource handling
Date: Fri,  8 May 2026 17:38:37 +0700
Message-ID: <20260508103837.138142-8-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508103837.138142-1-phucduc.bui@gmail.com>
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Convert spinlock protected sections to guard()/scoped_guard()
helpers and simplify the cleanup paths, including the
reg_cache lifetime handling in omap_mcbsp_request().

No functional change intended.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-mcbsp.c | 54 +++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 411970399271..d82fef629867 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -290,23 +290,22 @@ static u16 omap_mcbsp_get_rx_delay(struct omap_mcbsp *mcbsp)
 
 static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
-	void *reg_cache;
+	void *reg_cache __free(kfree) = kzalloc(mcbsp->reg_cache_size, GFP_KERNEL);
 	int err;
 
-	reg_cache = kzalloc(mcbsp->reg_cache_size, GFP_KERNEL);
 	if (!reg_cache)
 		return -ENOMEM;
 
-	spin_lock(&mcbsp->lock);
-	if (!mcbsp->free) {
-		dev_err(mcbsp->dev, "McBSP%d is currently in use\n", mcbsp->id);
-		err = -EBUSY;
-		goto err_kfree;
-	}
+	scoped_guard(spinlock, &mcbsp->lock) {
+		if (!mcbsp->free) {
+			dev_err(mcbsp->dev, "McBSP%d is currently in use\n", mcbsp->id);
+			return -EBUSY;
+		}
 
-	mcbsp->free = false;
-	mcbsp->reg_cache = reg_cache;
-	spin_unlock(&mcbsp->lock);
+		mcbsp->free = false;
+		mcbsp->reg_cache = reg_cache;
+		reg_cache = NULL;
+	}
 
 	if(mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(mcbsp->id - 1);
@@ -352,12 +351,11 @@ static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 	if (mcbsp->pdata->has_wakeup)
 		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
-	spin_lock(&mcbsp->lock);
-	mcbsp->free = true;
-	mcbsp->reg_cache = NULL;
-err_kfree:
-	spin_unlock(&mcbsp->lock);
-	kfree(reg_cache);
+	scoped_guard(spinlock, &mcbsp->lock) {
+		reg_cache = mcbsp->reg_cache;
+		mcbsp->free = true;
+		mcbsp->reg_cache = NULL;
+	}
 
 	return err;
 }
@@ -395,13 +393,13 @@ static void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 	if (!mcbsp_omap1())
 		omap2_mcbsp_set_clks_src(mcbsp, MCBSP_CLKS_PRCM_SRC);
 
-	spin_lock(&mcbsp->lock);
-	if (mcbsp->free)
-		dev_err(mcbsp->dev, "McBSP%d was not reserved\n", mcbsp->id);
-	else
-		mcbsp->free = true;
-	mcbsp->reg_cache = NULL;
-	spin_unlock(&mcbsp->lock);
+	scoped_guard(spinlock, &mcbsp->lock) {
+		if (mcbsp->free)
+			dev_err(mcbsp->dev, "McBSP%d was not reserved\n", mcbsp->id);
+		else
+			mcbsp->free = true;
+		mcbsp->reg_cache = NULL;
+	}
 
 	kfree(reg_cache);
 }
@@ -581,16 +579,12 @@ static ssize_t dma_op_mode_store(struct device *dev,
 	if (i < 0)
 		return i;
 
-	spin_lock_irq(&mcbsp->lock);
+	guard(spinlock_irq)(&mcbsp->lock);
 	if (!mcbsp->free) {
-		size = -EBUSY;
-		goto unlock;
+		return -EBUSY;
 	}
 	mcbsp->dma_op_mode = i;
 
-unlock:
-	spin_unlock_irq(&mcbsp->lock);
-
 	return size;
 }
 
-- 
2.43.0

