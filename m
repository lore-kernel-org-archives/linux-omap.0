Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC033D1CA2
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236761; cv=none; b=US5RZYyK/ZD8twfDKuxaw+imxFzUA2bPE+YkrLTKWzbL5zXtJx2dHwqUojiYx3r7RiTBfIeQiGvummzf4g3jMVgUWDCfUUh5Ho3LT1uCH/RrRaGbW52NBSnB3p9+u+50RNjge2iJc4Cmt4L7FXTGMvGj0z3FD+CkyHGH5xdcUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236761; c=relaxed/simple;
	bh=hgD0CGh4ly4OvpPUJGHRau/Dkr3Aayaonu/8yfXXpu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSXhT4dPnlPime5+5UdxW6d9YcY6A7Pq+6Y3JsK2KMHI9m12o5Yjl5rPuB+W146tEsIPiiv8CpYNBuDrgYsKx7OTJVQ7H4rudGulKo+S+pRYHLakyfFyTcB/Ba+dfx+aPifbGTfaUF5UGglQVGN7uJRhx9vp88TBFBKHMsa1tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUn7Xotu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUn7Xotu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so749883a12.3
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236759; x=1778841559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLQoiR5rrh3hqy6OvnSB4BV7IM1W5VVe7Onht99maeg=;
        b=FUn7XotuHqFNnpQ9zw0pzeSC83ZT3HShmDlCmAxYj9GRlpB9iqhYD0BvIjv0eO7i0X
         XNt9rz/yBdcijOTmjsZz8oX41xRcHQVwbmu+c8LT/KWUPZVa7eo5arxo2TBqEKxAT92H
         NScPQ0OmpP7G2MOGQCa6eeVbh7c1u9xWMcy4PXfPhAD5/JxGqmpEtLpiCaFFnCol+KyU
         qumjrUbtZO5bXkD5CQSYLvFq/f3RBX/GoeP47wO5LR8zA4i2fbgWSfUGhRTxu1kQVv02
         Pal5CW0NPB2cyWsQg8YK45mzd8QDqaT2f/+YXqXrnz54otA/L7sC/J2aezs1cbIpPAFt
         3zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236759; x=1778841559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLQoiR5rrh3hqy6OvnSB4BV7IM1W5VVe7Onht99maeg=;
        b=JxWdzifg8T310NOw6wfBYfTiSubFfh7ANMANSknPIY4gNjaohV0SeYadOVQ7NpzrnX
         1DK1azFPKdVA1GIgwYybeiWQOQb1T2ie1T5R75D+hQ28DsNzxPpRSYXvrJW0pz8bFnN+
         3RaVzjrcFmaGUk8+WaVB5Eaffo/mbybhA/zJNJR14AOmTE3FWgyz2TxEbvm/RIaLm0Co
         3NSPCIj+k5Vqjee6lHEV4NcNniQFdvkPt0u/H7mEqzLyLDpR9CtDEFprfXWbmaerANoo
         44bNcoz88Z709zzo3RcPWL6senzN163rxZQeL/083iW2K1RRhayiskrvbicrz9vaY5H3
         l9wA==
X-Forwarded-Encrypted: i=1; AFNElJ/wtTd7cs8QM+vi8eqKhJtMvVVDADtlH2uK7ep7j07cpGZ745iprX/Q5YyDFyIxdRjOg554XrelS0LZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8EVlSB2fJhPGBUbqx0bntW3c/kIGhBsqOCdq7E+ohIqGBZLO
	dUYPJq9zqFKoUw1shZNzEfFV27enJ5Ay4YXzx8pKyVaBz+nSN+YObQym
X-Gm-Gg: Acq92OFhb1IJR34yNeaI9/e2SKfUhFP7obhXcaHM63nwtZHQWysKVCnE/8sp2OjbLuh
	AZeElWsA+9b4j/IbktY/JXRaWURYBHAEn3HfBciGZdv7Ux32A76Fcwnqz6gkto5SMVpWYEfeapa
	w++YYgkju7cGEfaC3yrapmtY3xGO62iPsJHF7U8lf9qsvvEofID7+NoK1wazvVJ6mFkfDbZaFS3
	SfUibiNW4hyr1hC6Ucf063C3DSrSPlSmZnjhm27ACEX4gHfrNKd8qYsqELbrBrRlU6Gm6j/QSi/
	fNt9CN4He809+SyfmBINW3CmjVr+aHPOh01nFojiEcytc82zYvvlElVkR+RG+8UT3KjUA5xiVsZ
	zZ1sRNwv1wghmagD0ROzglVs/aMfX/NNd6cEtEmya/J1XZU51ljuVvY0EzTdKUuqxYvVb3uZnd4
	p0DdwSU9Er3pjM0369Dgw+O6UMwbX12f0lOgZlwZF5PfOx3FoWTNGh8cPjt8+tf6vxa05UpjUrf
	QOeBmw=
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr124730905ad.13.1778236758762;
        Fri, 08 May 2026 03:39:18 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:39:18 -0700 (PDT)
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
Subject: [PATCH 5/7] ASoC: ti: ams-delta: Use guard() for spin locks
Date: Fri,  8 May 2026 17:38:35 +0700
Message-ID: <20260508103837.138142-6-phucduc.bui@gmail.com>
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
 sound/soc/ti/ams-delta.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index ba173d9fcba9..6dd0d051a757 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -264,10 +264,10 @@ static void cx81801_timeout(struct timer_list *unused)
 {
 	int muted;
 
-	spin_lock(&ams_delta_lock);
-	cx81801_cmd_pending = 0;
-	muted = ams_delta_muted;
-	spin_unlock(&ams_delta_lock);
+	scoped_guard(spinlock, &ams_delta_lock) {
+		cx81801_cmd_pending = 0;
+		muted = ams_delta_muted;
+	}
 
 	/* Reconnect the codec DAI back from the modem to the CPU DAI
 	 * only if digital mute still off */
@@ -373,11 +373,11 @@ static void cx81801_receive(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 			continue;
 		/* Complete modem response received, apply config to codec */
 
-		spin_lock_bh(&ams_delta_lock);
-		mod_timer(&cx81801_timer, jiffies + msecs_to_jiffies(150));
-		apply = !ams_delta_muted && !cx81801_cmd_pending;
-		cx81801_cmd_pending = 1;
-		spin_unlock_bh(&ams_delta_lock);
+		scoped_guard(spinlock_bh, &ams_delta_lock) {
+			mod_timer(&cx81801_timer, jiffies + msecs_to_jiffies(150));
+			apply = !ams_delta_muted && !cx81801_cmd_pending;
+			cx81801_cmd_pending = 1;
+		}
 
 		/* Apply config pulse by connecting the codec to the modem
 		 * if not already done */
@@ -426,10 +426,10 @@ static int ams_delta_mute(struct snd_soc_dai *dai, int mute, int direction)
 	if (ams_delta_muted == mute)
 		return 0;
 
-	spin_lock_bh(&ams_delta_lock);
-	ams_delta_muted = mute;
-	apply = !cx81801_cmd_pending;
-	spin_unlock_bh(&ams_delta_lock);
+	scoped_guard(spinlock_bh, &ams_delta_lock) {
+		ams_delta_muted = mute;
+		apply = !cx81801_cmd_pending;
+	}
 
 	if (apply)
 		gpiod_set_value(gpiod_modem_codec, !!mute);
-- 
2.43.0

