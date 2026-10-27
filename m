Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114693;
	b=qTZkWJp4xy3doPTqD6NjzQOcvr1B01FYCheihfdwvOxfwCljycrLz8qa4ylk8CqAJ+5l
	 /I5T7aebWdUlCVmGBhL4tsd/oMM9HxEJjKZxr7ib2L3b0GYsncpUUh+2Bnsk/9mWbIrLP
	 DjzVjhvXet6+K9lOYVAvWHEGVb8y3/QhIecSHJzWfKXjv4G9GHSq4AhRi+o19XGevLFQg
	 Cj5oUgC7xyfYVNHzWykhVfhH4+fpacj6gi1CSVp+/8ZYMKU6Hb7ecGOf9UiVID9Gj1oxh
	 wLjDeQmIUIblLUwGHry9QPFCD7TcdPIxxnQKbCtg+k+732X9X27gv/WtdskqPSaM3Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BstRdR26uz2xpntyFZiBdMeXA3JFymkoz+BLyzJwrsM=;
	b=eUS/79AzwkL9W6ZxWGDDrF+i1JPaWrsT6P8zvNDqzPlcHtjLy7JC6z/zOEYjLohJ76G6
	 JCA1/cmHtKXOJL576pMZbtAF6QF10QoQ6jdQKUZBJ0Ov5B15cqrIN5LbqCr5cK0Bcuae2
	 OZmJBynpxsm3DWoxD9rRNoucLOVAqGcMD+5dLXk8rj8d8qiCUMWLrQ5LGNFtagHjWw83C
	 el8gomEPaXnBlJaSr8mZFfMOd2OScLBtH+Jx0dSo6Bh5de4ECh4qkGoBlT1a+NiMkwUbt
	 Y58NlYKoR9TMDGgopqbHwN/0bmFiu0AyHR+uHuMn58Arw+rFq/PDCQQtYJxTvfXiP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkxHbJuy;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B3606A323
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 15:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 610B3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkxHbJuy
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so6107a12.3
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114691; x=1793719491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BstRdR26uz2xpntyFZiBdMeXA3JFymkoz+BLyzJwrsM=;
        b=QkxHbJuy/qM/LhrbSPp2Kj7QYkqCAm8T1bDGfc7EsnVOJUWM5VcPkVLeRaEl2aJ1Kz
         YFC14qrLFM1/Kmzj9nG4tiqM2MZsTCb+tez5x8jl1QdiWjV1bwsxkHtOmvgf7TDElcix
         zoqx+OrTlpirSx44iD6L71T3XY5jgbJWXOcq645P70GZoiA/OpFasTlZE2sGdgK1r2IE
         /VFG4b6IVhfh6hF1ocLk6C5m4y3lmScpJ3yhsIM1VTgwIazm5LS7GI59vE/xgd5wVNU7
         jcTZsHYkYW2aaDuwweSDHcnqT2DiRPxKAoL8vDF+4B/wxa4YSwOV/KuGcud4zHzVcXTk
         06eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114691; x=1793719491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BstRdR26uz2xpntyFZiBdMeXA3JFymkoz+BLyzJwrsM=;
        b=NiZ968ACf6D/T15Fpi6vB8NbanwTxiuKGbBtIIFfP4jLIaT/XQYA+4fEyYXikq0zST
         bHpbDeJd+SFYU+Dflcd6ljP2YNUUb66ahJ8bGNHZjZLq1CC3Oq1UPbU8N5JEquBptAtW
         j3uIT9CsR7SDtowqU93u3A2cSUb8/XeZjwpXmP9MiwjKQbyKGo6DpurlawE3SuUdMvWe
         rrLW3QzYh/Temh5hAIZE1fcOrHsRQOECbmyIlxClssxPvjx9ydrJakmrfNgGJ6Tqo/Lj
         t6Ui/+/UlyQDbIJTY/5wSmyCIk0/NApBn37Ocga+npllpLAxGOnC+rR+/E+1atks92Dn
         WlAA==
X-Gm-Message-State: AFq9FYJpgFR7CNN2vKrvvh7pzquOlom5kb5GZlFpbWKQWJTHNxFfAheI
	/7YN635BJidT2JFgwznC0pNIzaSeUR6VlF/M9aJR5rN8aOXEmHYXwWRA
X-Gm-Gg: AYBFou1v19fUgAvaQxWWXbRN9tbZoFUu/KDfL6wB326tCyKMvEvZadLMXN/X97JkhAY
	4WBiULp32c3AprxESg+yU4BmOoujcOwcn/2v7J8GOE1v6ewseauaoLc4x1ReRhSIo15Y97o+ngv
	OWP2NNU5HpAXfodfOAbHn0tPCrRIKRke7saN3vmSNqGcSEgBL5hEooc2PXu7Yo1AuHfEnmE9VR0
	ZIiCo45JZ4AALglfj3yBgBdhHPlklvjm/zIp1RGlB62UHdV65x0FoIlDBtfCmzOtzYNadX36OTY
	rX5vu7RM+VD5CTSGRZUP2sbX5P6n8NUt4BqdPjI2fZz/NNJqDVtgme3IPZqgLadgfxFfWrO3gjn
	kseMN5570qmpNIjhziVsaVYl2JkzhKfBSSctE03hXSyTm2A/JoSHJYRXkjWuJoAxWNWXsoCPbEi
	euSut6QTodnatWsQWB82jsEF3jqeYIollxpivpueod+c8BnMDffWH6G8dGnyGup5iBdN1/Kx6Yy
	4k4HskPF29iR3lcln2LCTHTd+K+E2BS42NDZlMPrGFneC9dL/DBsxiEDiBkNEAWN2+WuOfa6LDQ
X-Received: by 2002:a17:907:9619:b0:c26:1649:47ad with SMTP id a640c23a62f3a-c46bde828afmr1015997566b.35.1793114690459;
        Tue, 27 Oct 2026 08:24:50 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd529b3csm467303866b.37.2026.10.27.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:24:49 -0700 (PDT)
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
Subject: [PATCH v2 0/2] mfd: tps65910: Use modern API for poweroff and restart
Date: Tue, 27 Oct 2026 17:24:20 +0200
Message-ID: <20261027152423.194794-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Switch to modern way of registering poweroff call and add restart call.

---
Changes in v2:
- swapped to use dev_err_probe
- ddata is passed directly into handler
---

Dmitry Osipenko (2):
  mfd: tps65910: Use devm_register_power_off_handler()
  mfd: tps65910: Add restart handler

 drivers/mfd/tps65910.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

-- 
2.53.0

