Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E313D170C
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236765; cv=none; b=Hl4Asr4ycCEdcFdN+APdyxyNzY08cGi9oe29t8s+FtbWoSwLxa6eddNvcpGv/ki/yZNRoAe9qFLMI7jivnq3ZY+I6dpE6bbiVsJApeTU+LrH26dWheuuinOq72GrnYgoZkY+ar/tueWJOhOYBY/fO3ZRRxjJEuAmOkb8S4w6wVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236765; c=relaxed/simple;
	bh=X8FuvP/99gyNUMmHvPuFXmMMvK2n28I6GDJoLygfXIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh52nwTE3d47gY1z/5pZyEhp9AFj2rG08NppVdUwm2pgyTyj9r/wO4teQ/5wbG2dk2eL37CKnTfH1koCGqTDbNVGLvD9M9t9xga6pS8as2F9pb8Vl9nA9UYLj56gxXCwLDpYkg0EyiP3RHWMk7Mnftl2k72AQCVM3ZfQ6ZwtxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLu3fxGn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLu3fxGn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-356337f058aso1195863a91.2
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236763; x=1778841563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7TyisERyCLhAIeiN1+m/zKrVKHagMvjPp9LlZU4W08=;
        b=rLu3fxGn+Fj+3HwvzCP3KAd1YotEsTpF9GtKQ3KXKw0L3GN8yBXti4vZPtfGxqW4Gj
         87pWMyjruW9LAObvvJDhTqTmb55sdZg+aM80YvLGdCD4ANm1M/IMu6N/gaRriiQIwmib
         5j2pH2oE3IqqXDngueuPKceQOhkNkI9FuqDinaYByQ8rEmkgiIZLXUUcEAaMLGHhyU2Y
         Jg7mdsPzFNxe9ssgYWqz55yeE5r5ITdkqqQmXZSj0AAxLgUBGT99vE5euoqg4NqNzccz
         0aYSs9MJ5VuJrKxMAVMI062/zMjbX4yJWZbp6N5ZCVG+7eiTvOFuhuhrkmsHywD/6GwD
         BOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236763; x=1778841563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7TyisERyCLhAIeiN1+m/zKrVKHagMvjPp9LlZU4W08=;
        b=GP0whd+P8wzeM0umXa1cus2O3/d5bjJjPpzxqlF/y9SShTvLIcMaaPuziuc7MuXh9y
         PhYwE1QIa4Q2yDUOTaEMo8mvKfM5jCjSsSN5cQrJKS90wkCXF4jvF0/Xm3UnQ4fdNgCI
         EvK2KoWzLLk6zrPcARrVC2l1cvP5d698V3ZS3+05DQ/b/MkimbM1ij3oOExzdqvpmkVw
         XNIwnAfNmw+c7u7aRP+DNT+PH+RqnPodiYsRzREDhnAoh583kJtBlH+ru/fj01/0RDpi
         48KWYItGJrtY5v7TdYx8rzl6ttDJ3g1tjyzNLQqTmbOGIZ/tHGfpm9xNfHygb0dwbNEw
         fyjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QXxahjZiIOSXqo6SEn0ot5BjMvd2os7jNunVM3ihGPTzwVSq3EY/TjtAjK6CyzMg4BbE3fg1cA1Ot@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzu1F3JnNd6LgESDirIVQ005x0dpfRhuC/uxejTQ2UU6cyP4Ht
	q+8exWM88v2A+nkIPTcuBwoip8p8Lmv1KJcXp1OBViRXEXay2wqt3PYz
X-Gm-Gg: Acq92OFIdl29aVbHWy1tLBU5z9eBIgokHo9uM61LbLVlvYm78WxbP+EjYQ5oni4kbp2
	Aeuq2fK1AnbaMw7tv09KOvOzuGVEglRz2+72cYXXhyo4M+hyrFF9cGq8xz1XYwAZ1k0+qjdo1Sl
	E2buvh9QBtSqwL1QQpCd2qvvtnBi+FPkElYMivNXtnG30FoXzh7pGogeDpRmRdOpixyVddpCeTM
	fh/tXd/+MsNa2k688jlLh1LrNqHr2ydSiG0HPysBxuT/oO8XGTc4HYFh5J+R2oEaASaZmtKnVfx
	2SRr5TTHwnTk1Py0B0Xvo2rIHB3CLBoL8m967toEoDR198mPH/5cmwrZSTodhVLcgitrPOP+rBk
	2DKJiSUBR8Gy71ow/OWo8w2w/u7xhyXiXEZ90XLdG1OY/BcVYKTK/vwMFwG1kniuyhJ8VJ5pdU+
	B4psCbQSMXTMLf8+0cUUSoQEPwHoqtfrbg9M/Bzjez0PEcrnPrzdbcIcu9ugb5vynCuyB3
X-Received: by 2002:a17:90a:e7c2:b0:366:1bab:c3d6 with SMTP id 98e67ed59e1d1-3661babc819mr5812280a91.10.1778236762673;
        Fri, 08 May 2026 03:39:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:39:22 -0700 (PDT)
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
Subject: [PATCH 6/7] ASoC: ti: omap-mcbsp-st: Use guard() for spin locks
Date: Fri,  8 May 2026 17:38:36 +0700
Message-ID: <20260508103837.138142-7-phucduc.bui@gmail.com>
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

Clean up the code using guard() for spin locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-mcbsp-st.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
index 901578896ef3..b762d5d3e33b 100644
--- a/sound/soc/ti/omap-mcbsp-st.c
+++ b/sound/soc/ti/omap-mcbsp-st.c
@@ -156,7 +156,7 @@ static int omap_mcbsp_st_set_chgain(struct omap_mcbsp *mcbsp, int channel,
 	if (!st_data)
 		return -ENOENT;
 
-	spin_lock_irq(&mcbsp->lock);
+	guard(spinlock_irq)(&mcbsp->lock);
 	if (channel == 0)
 		st_data->ch0gain = chgain;
 	else if (channel == 1)
@@ -166,7 +166,6 @@ static int omap_mcbsp_st_set_chgain(struct omap_mcbsp *mcbsp, int channel,
 
 	if (st_data->enabled)
 		omap_mcbsp_st_chgain(mcbsp);
-	spin_unlock_irq(&mcbsp->lock);
 
 	return ret;
 }
@@ -180,14 +179,13 @@ static int omap_mcbsp_st_get_chgain(struct omap_mcbsp *mcbsp, int channel,
 	if (!st_data)
 		return -ENOENT;
 
-	spin_lock_irq(&mcbsp->lock);
+	guard(spinlock_irq)(&mcbsp->lock);
 	if (channel == 0)
 		*chgain = st_data->ch0gain;
 	else if (channel == 1)
 		*chgain = st_data->ch1gain;
 	else
 		ret = -EINVAL;
-	spin_unlock_irq(&mcbsp->lock);
 
 	return ret;
 }
@@ -199,10 +197,9 @@ static int omap_mcbsp_st_enable(struct omap_mcbsp *mcbsp)
 	if (!st_data)
 		return -ENODEV;
 
-	spin_lock_irq(&mcbsp->lock);
+	guard(spinlock_irq)(&mcbsp->lock);
 	st_data->enabled = 1;
 	omap_mcbsp_st_start(mcbsp);
-	spin_unlock_irq(&mcbsp->lock);
 
 	return 0;
 }
@@ -215,10 +212,9 @@ static int omap_mcbsp_st_disable(struct omap_mcbsp *mcbsp)
 	if (!st_data)
 		return -ENODEV;
 
-	spin_lock_irq(&mcbsp->lock);
+	guard(spinlock_irq)(&mcbsp->lock);
 	omap_mcbsp_st_stop(mcbsp);
 	st_data->enabled = 0;
-	spin_unlock_irq(&mcbsp->lock);
 
 	return ret;
 }
@@ -241,13 +237,12 @@ static ssize_t st_taps_show(struct device *dev,
 	ssize_t status = 0;
 	int i;
 
-	spin_lock_irq(&mcbsp->lock);
+	guard(spinlock_irq)(&mcbsp->lock);
 	for (i = 0; i < st_data->nr_taps; i++)
 		status += sysfs_emit_at(buf, status, (i ? ", %d" : "%d"),
 					st_data->taps[i]);
 	if (i)
 		status += sysfs_emit_at(buf, status, "\n");
-	spin_unlock_irq(&mcbsp->lock);
 
 	return status;
 }
@@ -260,19 +255,17 @@ static ssize_t st_taps_store(struct device *dev,
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 	int val, tmp, status, i = 0;
 
-	spin_lock_irq(&mcbsp->lock);
+	guard(spinlock_irq)(&mcbsp->lock);
 	memset(st_data->taps, 0, sizeof(st_data->taps));
 	st_data->nr_taps = 0;
 
 	do {
 		status = sscanf(buf, "%d%n", &val, &tmp);
 		if (status < 0 || status == 0) {
-			size = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 		if (val < -32768 || val > 32767) {
-			size = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 		st_data->taps[i++] = val;
 		buf += tmp;
@@ -283,9 +276,6 @@ static ssize_t st_taps_store(struct device *dev,
 
 	st_data->nr_taps = i;
 
-out:
-	spin_unlock_irq(&mcbsp->lock);
-
 	return size;
 }
 
-- 
2.43.0

