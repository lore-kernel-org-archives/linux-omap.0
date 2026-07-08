Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9544B696
	for <linux-omap@vger.kernel.org>; Wed,  8 Jul 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509426; cv=none; b=YWePWRprL6nbDjp339QdGsu37+TbE3sbRJvrbguj2CRYuiLtsS8j/y47mKe9jFiAjX/plznau9ugwzgWl6AKMb5u3ZDFrLXivtwUnaE3QhvyEmEhekoE4fc8PqVatIhP22nu8vceSu4wQyFVZtOIYtRwVHlByQPV8lXf2Dp70YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509426; c=relaxed/simple;
	bh=b6B53jc7YA9gdtC4uNceBV2qg862T7PJ6dXNZqZiQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWVO+0RG/iBf63/kKb3hxN2JM9vXp98Gq4TUV6gBKxT4sZSywff8wYGALPxSaldjvHn82mYziBv+Q0nAYucjaqaebXCrSDS70MDuK/jIphzNPcYFkcfS5S49eW5x8MXQvPEXsn7mLjULZsb3YlRcw6J8F2lMmwraV7fldNFhhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QfstDN0u; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QfstDN0u"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493ba701891so3883935e9.3
        for <linux-omap@vger.kernel.org>; Wed, 08 Jul 2026 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783509421; x=1784114221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+oOYpEkuNj39HQ0iyySiPwW15dmAEx9n2wnPsb0pR4=;
        b=QfstDN0uo0PokFd5TCP6Ee9tY41HWffk2+BnOqmPvRY7czDHDUDwvx9qKIh0rR6pWY
         KVcutMvSzjX3+pKLON447psrHWsM2THMlJ0eMoCwgeNyW/mRrJfMXd/2yi7YdRTjPDly
         h2KeNBtgjEFFgp+WqeS9Oz+1+5eCwl35HvjXeMWXAhTJ6gIeOZx4XXlNiwGP7Y3Q8bNK
         5wi+3eebI1+3Ychzyv4Bl+q2k6Xt7AreFyemVM36OYP9G1PSsfkzdC5MXXR/+BRefgiS
         gtcKZij1KMrQmMLJOP1qv6CDtvwcHBywdKFi6r5EWR770JYN+h+bH+2eMJ1cNm5Rry+p
         X44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509421; x=1784114221;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+oOYpEkuNj39HQ0iyySiPwW15dmAEx9n2wnPsb0pR4=;
        b=KR1e2gXQ2BXn+y1pozSHVA+fsGTpnayuNZHFIuVBqeZppK0FQ/J32KEY1wBc85APd9
         QjcCQt57txL9n2XyLH1pxUB30LfAxKuVRIO1P4HtTnMa7RIPoNk0RXTZqPAEDjo44r1K
         aGxht5Uoya3F1Vr084Occgem8eD083kidFofVxgn+sH36CyhHwJwSkwkqCP/ipnfQGtG
         ATvvsnY/oP6rK1lVtf8JqLau/g33aDD+fAaJ+qNRvEPfqZmGkzzwhuXm3+gksOpQC7Pz
         Qrue14PH62qa1mjxCebK0RdSyFAfy3Wo8RAk6tcW2kJN4ZEcTeqY4KNFbNt59biFYhXf
         BcJw==
X-Forwarded-Encrypted: i=1; AHgh+RqAWvBG7PrAZXvmrbWvy4T8OFNRiA9aXDQwWnJlR5qCcjcauQycoNGFAMCVspiyc8AWPAs4qxEwlInJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgNShd2EYuGuK1CiIv7NsCHP85vxv/UubRmhkzWzKr54qm0Na
	sdoTxnR3I+KXJXkmvNDXU4g5t0Elm4MMrTkg36BDHcnV7WSc0ijwS66AsvHYLFjmY1jXmIpCVQs
	m8AVj
X-Gm-Gg: AfdE7clKjWrrk2JsCNE4Knd7qsZFWSk7pEANMxeIiAsijsqn3KBU2Gf+8BlWDiVZwjU
	wsNtMK0G6oM4J9vVXYBGgztePPIvFtxvtUCk31Jr0MQG4wGA2Xlnfu3YFSfz/HTng3ZssKksB8w
	b6yFdaxECTXkH0f3kY6OLVKYVRJrhBtN2thRO4YlTl+S4qSEKPqX6mkqgbozoBKr98i3yv2dmWA
	miLsBecp08alsJeATF7WxKKIe+TbievyDk6RiS5AtYTaHJbHHd3HSr6kaqYAY+j5u6J/YBIH3FA
	7y3J7qHDkGIiEySbHsBb/bADkQroG7hX+DmGr57r2Kv7sFeJNRlBLiS5cqw+4J7otyKzqbN6/uU
	KIQvZLyyqaWlB3uQhPDMLAgkFkfQZMVDF1CjLXTPPThmjIAdbxB0nbk/lS6qv74+MuJChrFwccC
	UPrEa+5gyZ8jPnZZvNXcnYzAlZHNV/1cSmylR2/tAPiUzWfxy0v4/AIhKVJ48CvJNBZOJsiG72d
	f2V
X-Received: by 2002:a05:600c:608e:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-493e68bef22mr20762255e9.22.1783509421383;
        Wed, 08 Jul 2026 04:17:01 -0700 (PDT)
Received: from localhost (p200300f65f47db04930dc5bd4534e1e5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:930d:c5bd:4534:e1e5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0f44b3bsm115190245e9.9.2026.07.08.04.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:17:00 -0700 (PDT)
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
Subject: [PATCH v2 14/23] mfd: twl6030: Use named initializers for of_device_id
Date: Wed,  8 Jul 2026 13:15:21 +0200
Message-ID:  <3286c57c088c69d4c9296f66bb8e17bae8824b93.1783507945.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783507945.git.u.kleine-koenig@baylibre.com>
References: <cover.1783507945.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=b6B53jc7YA9gdtC4uNceBV2qg862T7PJ6dXNZqZiQ7Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqTjFr6hRIEruLKX7fBoHPIwG9Bu6y/MTHavwPy CpA4ivztgKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCak4xawAKCRCPgPtYfRL+ Tu5kB/92DLjdtq7rVy/GvjeKslnqEQ7G+FDBh9wBrCIX/7XUwzkqd5qJyp24EZRH3N/xVgvMQWy Klmkr4o7eNOsVgQXA4qGQJHGyAnQDPBhQl7NWWWxrappgSQIpGnlB6RQqGrzn82zomNI3FgHPtO D1M2UoDKcJRozfn+Y1ZtEiZt7+YiwNa97+wmQ+U+cGRexwIv49pIk6B84KQj7KvqWiNqxWpNAFl lswTaq8PGpJYCC+QcQm4W4YQvWzBpF+vSP9g4g46rX/hiak3oAQ1ruKgJF0K1630UDZDaYjq/TK uiTDxgvw2/sfr5V7B46WwC3OfGZj3EP/yA+ByrAVYB7IPsN6
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

