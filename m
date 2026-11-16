Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845799;
	b=uGlBPzHAIYZb9IRacHbBpQBzlAztSrUO7ZlfQU/5Wc03bdbjF8WHKQvmC07VAdMuRPdp
	 u5tEYFfX3F6FMbVINQ9KzuQendCI87CSaNBYQohz5zw2zxwj/p1q12jn763exNKpTRu91
	 faD2ydM+m5eBW2SdxpQUbAx7Xi8EQ7Z3PPEPtwGt0RhEAQLU1kMNMKTT7ICKh7nB8lNYS
	 Rvpca/FHD/vknWjUx5jIlcOvwnNMFhokk3Y7LDN9P7OQRRpNGZgksif2CRSWWxMdGXJZm
	 EW+AEXM7LmkYznvd9An1M7E5/l5IRitvjuiMO6GhBrwQB2Wbw6QhPqmKYW9cTvAbl9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x0v9e+wZHiAwxkDeqQfkfA5SYCnl901hHKw7lpsX06g=;
	b=G487bUmg5OMBzM8B3AAKl2Wf6Voj729y6wlK9I+MftcEf1MIauceap0PmD/mlIN+lTBM
	 6OtIvhpLvwTtGydzofbeiPOuID9LwmG/sDY0p3JWK/Di6MpjS0vmUe15n+o8HY1mU4JMs
	 l7kgvwHnd85hyk/8BiX7nUTWRlOsVXpafYWNciugrBjwU6/UluTQ5345ibLc8TqvlPP6N
	 dhJbl/k7wHulev4KDxhfGYXUL6uHvX7pLCXy5LhonS9AF/4Bhhy3THtdprQgXIaDapuc2
	 CSR8OhlZi+jS3PKRvciduZ5vkCxNwGWnXtJ1ADYM//pCdnQFnhwz4MMbfJI+7NizHow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HyAVpQgu;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97B606A33A
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 16:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC97B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HyAVpQgu
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd69954c755so3089606a12.3
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794845798; x=1795450598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0v9e+wZHiAwxkDeqQfkfA5SYCnl901hHKw7lpsX06g=;
        b=HyAVpQguoF/re4y1dBicLWQ52JiDRweNeuO6DSXlmN3DR063h67/8SJm4gQGce8Jf0
         NL/56kojhiaml7BZLbgn6AOPSR5W6qKQeHYYyNjn9U3Usejh1bT7eRGQlVs/bxCjl3y8
         J6RpSAH6230fwUn+FAcrjiVyqTglTEhfApjt5rIWMNzp4bmPaKy/jIBAwt9fKSmNdxXb
         9Nb10PjhyCuVx/XIuXirJ/oUJnlnRZu4sOSP+RjPDZQMl8TS4g6Mt5W0kwRHAjfAD1XE
         7v0uPt3sbpJx5Wy4IJHrfbSKBcuzNBWaAIhw6OfYJesf3un5HvAoDmFUsF+iHu/kOkzk
         64Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845798; x=1795450598;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0v9e+wZHiAwxkDeqQfkfA5SYCnl901hHKw7lpsX06g=;
        b=afB9fTOLdOpHzzVFFw8wvmd1g8haFECy9/ssIlwgn0RTjpZ2Dj6wK0TgfCUXyN0MyM
         GfCyBOFj2PdKfoEiD7Yb46OSPj/V8i4QVNoYuaNF2ib7d2qLdugNLoM90KFxQHjp7Wd/
         XJ/lIBNBdb8ZsFbYTZXzLsvzVJPZ9MEoyklKJhXAUTbid7GSt/y426SbdVrwT3ptHJsB
         GgPyvvLHOtq4+Quhh5tamUnNySEpUHTnmyM74+mUCaz7EHoO7OsiDA+UA+sYv2CUr7lQ
         2Tpo0lJnRJiKqlMXYekUmhM8kzjMjhClDN+CTHYv4e9hZi6GZ5VagslV0aG5AiJA94XB
         rlsQ==
X-Forwarded-Encrypted: i=1; AL+hErFBpZzsOz6SrG6ZUQMx1FPK2xeT3RPj4Of8tmHwK7wiCRx3pRakjJVe2o+uTmg8kZiPD5BZ7XCnGcXI@vger.kernel.org
X-Gm-Message-State: APuU4Z+KN+SydrKJePFdrIU9Y0HQQksF0+pojc6De0isDN116xRlnJfk
	w1ImCvfrXdANRc9iNs38lC761O8rgu8L8SBg9sWQnjFohOTAh0Mxsh8SIzEcvyzZgVc=
X-Gm-Gg: AZFdTZcvD1DmhDqGBJSLmoEsNMhF7wtbY2Jr7yUBcwIOWrcUprFozWtSIaNfMFJP6/z
	6IL9g1rwXzRw+cXuPDaEFuuiyn5MRzYUEXZy0erM20XyK8JbwpVsLXEvsRX0evIATKUG6VS/jDN
	5elG/L4DIVyaRZMOQe6ge/o7TVEnxORia0c81ZjMV+vfCpmddkcNSa5+6FSKURW2Y1eC//yo5GX
	79O/HLP4Q4ijS+Ov+z3djZskr+/UQj0ArVd/NUU+vHjsehokPRFs4iJf47O/j7zCCyI5wojX2gU
	pRXXc3Pyqgj4emkLghdpNOLAox7ZeHT4XM/k5seSU8ArNLHYcAJQfXBCq0cdx4pwYpQj1jaImc7
	TR9SdmZ4m+Tv+fO9nf022j7P2d4ycX6gn8nlvws5HreegB0RecMpxZXbJH5geyXnn0FaplOUT6E
	TpjzOEKAkcgZjgmiTwufA2OkMRG8YeevS3Q4PqCCG8mkiWPMk56SIsYSvmzLDN+z5a5QX08V2q5
	pWuhs03J13/k3a0MY3IjMa6ylWKQWfLVjG/XououiShMon+Q//ovRBGtivpjB/HYm/IN6hXupCv
	iDoUzgQ5+m7mbDwHLWwAfuxqUwOiQ/eCDFD9mO2FwfPJpiM=
X-Received: by 2002:a17:90b:2ec3:b0:3b0:9781:ee8b with SMTP id 98e67ed59e1d1-3b1b09fcbc5mr10847659a91.26.1794845798086;
        Mon, 16 Nov 2026 08:16:38 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b1aec3af2dsm17201419a91.9.2026.11.16.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:16:37 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
To: aaro.koskinen@iki.fi,
	rogerq@kernel.org,
	tony@atomide.com,
	linux@armlinux.org.uk,
	andi.shyti@kernel.org,
	thomas.richard@bootlin.com,
	wsa+renesas@sang-engineering.com,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH] ARM: OMAP2+: fix omap_device with noirq_suspend
Date: Mon, 16 Nov 2026 08:16:30 -0800
Message-ID: <179484576805.84649.11200810551954641620.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110211531.679943-1-andreas@kemnade.info>
References: <20261110211531.679943-1-andreas@kemnade.info>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 10 Nov 2026 22:15:31 +0100, Andreas Kemnade wrote:
> Fixes cases where device runtime gets resumed in _suspend but then
> pm_runtime_force_suspend is used.  So the device is disabled, but runtime
> active in _noirq_suspend leading to duplicate runtime_suspend calls. So
> rather check for the device state directly to indicate if changes are
> needed.
> This relies on pm_runtime_force_resume being used in a balanced way.
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: fix omap_device with noirq_suspend
      commit: 20ae98b360710da7db17b0d8edbf84c88ff4658d

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>
