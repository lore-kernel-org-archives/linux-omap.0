Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B643802E
	for <linux-omap@vger.kernel.org>; Thu,  9 Jul 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616428; cv=none; b=GFCdA1pbkiZnA310a3jdQS0AQmY0Wir208h0LhtCDB//iBXI+Iv9IVfg+tOtztyTXJ1/y/EgnmerL5U5s+t8LByEBg8OoriyLfRiNSlYIAFlH88FB+dvO1mGqH8nOo1En0bAmhwiza1cCTqfm759dHZ10+02zuL84w+lRKnEWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616428; c=relaxed/simple;
	bh=b6B53jc7YA9gdtC4uNceBV2qg862T7PJ6dXNZqZiQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4ZGRykLQqIpolfkr9C4IPCHwX8wFA4DjrWuIh/dVUg4i8jlyNGpeDhwiWqj0pzzIShCY+mqxCBZsBYyA0ew82vz6ccZDxGsNWdoYv3f33s8z5c51elyfpaIBkCEBDj9KrRdiV3AJJjtu3myNyaIxEjXM8CtTMnDLbgI3okrUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BOKWZlJC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BOKWZlJC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b77b150aso172155e9.2
        for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783616425; x=1784221225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+oOYpEkuNj39HQ0iyySiPwW15dmAEx9n2wnPsb0pR4=;
        b=BOKWZlJC7ld9d8p6citTbXdXidZNFEF1sIWWo0a8P8gII2aRvA9IK5yLehcUnffNtN
         baU8gHoXZZo34iOqbBVV++OBsQZTCgyVEtFD9nJBCNuiTVGmKVv64uvOImZ3zPfDDr65
         Z7MA+fEXC8VhnH8peqvAV/BgLmlYQEU3KDXzl2X9A1xeqlMh96q1HVRm9p0ze1XKBIVk
         Eoxm5NIRK9Pfr+1633kTZDJg44oPkyxFqnMEHONaP+JuIT/68ypEg2sDY5Mr3PVvmCw3
         RFcOEMCP7llxCwKWX8BQ99CDkJe1lHiL3/Zrcive8BgxPQkevUF8lsMHTlkVHZ+5iSf+
         JJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616425; x=1784221225;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+oOYpEkuNj39HQ0iyySiPwW15dmAEx9n2wnPsb0pR4=;
        b=IctDV3rW4pL9tT47SBkzPiOHecgsLQ4f0Pyta/m/8lyHRLzxE3oBMEVMA8C3a7jj9Y
         xcfo6xsDmMeBf//SEJy1IZca6/8U2JsC/LMaBu8fODt6J1kB7iWLbfrGvyYz58vaUsWV
         V0kg5PdhVCQqAVWwKBs33Uu4psS610ee+bFb815+QJ+JG4MP5ZYmlQ155gN9cixN1NNj
         E4BiPSBqAYwLaXSn54TtSMiuuYcK0IXmwOR21yta2xrZ+Vxfuxc6sYNWbyOCP7pprmbo
         4Y+jRwI6XQXBGK0V4uwFwAm+ygBq0zYCh/FbZB/u7QZgq+JckDh3F7IWst2YHK2DEkSK
         LVhw==
X-Forwarded-Encrypted: i=1; AHgh+RrHADY5t4C+ZzdccJfiJKXrnfWbJCSv/Q4thaEX7gEtKtLLEckjR+8fWUVpXcoQP7dO4Otp3DtYjTj5@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuZEmySATS49dWmXkRfW/92ZusJOHm8AeXLpDFkrYSGmOPSDm
	tcIfU5Syb9uYH2t68tZLQ/BpC9r3Rw1b+mBiIo6+nMFfYfBQM+PxX34ZTnvHa0fv2CY=
X-Gm-Gg: AfdE7cmnlJSX5FpQx9D6zBrtnW2++GoBkC7BLREX+Ol/haHg9RIHXfuaD5KYpsWlA6c
	Ndp563bZOh1SrEXV6aaiA2x4cprgmNo4+MxCXY1TuK8PQwm5UAlTcK9x8r1c8eABXkXXoaTgblc
	Wv6+ZxxD/m6dBfk2poRfU/19uQWDgdztVOsBZXMj2LhYddEucA4KWlo8c9PlmjEqfDr4BEYOUeM
	xOkAebyLDVPbDIU8bgAdJxB8jNN6LjlKFyziKeb3cVg0ceNOcedKqNX0OgapfjQqo4SQm3ZBdUV
	+GV8GfnFW3GhI8Mpzq7ZBNQUZjJdHn8p9IMprmXS+yViJztxCOX4CKMQ4bAQHG2210QgzNUi9e1
	2xKPoME0B8D685QwC9GzIj9DEsGHifzeey6Ii+151RAGnqe/TwxBugRnNzV/cUUjUTTCywucvuv
	o/ef6p+OVVRz3rovBpxjF4T7trZFomDwZyJiF9Qp9dcGHO/Ua33ZeqeARFripEAtcV90WU3ax+B
	uSG
X-Received: by 2002:a05:600c:821a:b0:493:a570:df7d with SMTP id 5b1f17b1804b1-493e68bef51mr80037745e9.20.1783616424870;
        Thu, 09 Jul 2026 10:00:24 -0700 (PDT)
Received: from localhost (p200300f65f47db043de98c19b374aa68.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3de9:8c19:b374:aa68])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb742a49sm72194545e9.12.2026.07.09.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:00:24 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/23] mfd: twl6030: Use named initializers for of_device_id
Date: Thu,  9 Jul 2026 18:58:33 +0200
Message-ID:  <7be6ef143f760ef6ccec4d6427a471d3b4c0a71e.1783615311.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783615311.git.u.kleine-koenig@baylibre.com>
References: <cover.1783615311.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=b6B53jc7YA9gdtC4uNceBV2qg862T7PJ6dXNZqZiQ7Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqT9NUXXFt7kNP/Ka9xwvfVI5vWW7Ph8xMeYy0D Nh4z75h9CiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCak/TVAAKCRCPgPtYfRL+ TvRFCACY0Bh6dbr7AxGv7usuJR5sr+Ba7cI30T6W4+nb+ATVf3CjNtRMr9u5mQDg6OsI58LTUZX jbCWEVFIpxpnSTBG4RH2cK+w/rvkBhuZEXrGzwCoNKAgYtqUJsiO5lWSqBzhIAJMJ6rj9y4Pyac HKrKqb0Svrjf6r8/Bu/3n5PsLvLc2FVfoZlxagp4aKvZbPiZ/CybtNV4oKdjyhIrqpBcvvMK5Bh xyismTMp4zbh4to+klYZ93UXtlU+0ZMrb8Lseg6kBmBe5n5h7eww60Qagx7FC3c9lgqFUQqCYBd JqFy3Ej4lR+j1YGoUFJcS2sp9L6K55K5VPNktu5FfKrp39Dm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For .compatible a named initializer was already used, unify by also
doing that for the .data member.

This is easier readable for a human and more robust against changes to
the struct definition. This robustness is relevant for a planned change
to struct of_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled array, only its representation
in source form benefits.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/mfd/twl6030-irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 0ca00f618d4d..4303fb288dd5 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -283,8 +283,8 @@ static const struct irq_domain_ops twl6030_irq_domain_ops = {
 };
 
 static const struct of_device_id twl6030_of_match[] __maybe_unused = {
-	{.compatible = "ti,twl6030", &twl6030_interrupt_mapping},
-	{.compatible = "ti,twl6032", &twl6032_interrupt_mapping},
+	{ .compatible = "ti,twl6030", .data = &twl6030_interrupt_mapping },
+	{ .compatible = "ti,twl6032", .data = &twl6032_interrupt_mapping },
 	{ },
 };
 
-- 
2.55.0.11.g153666a7d9bb

