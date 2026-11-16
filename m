Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845800;
	b=T5fcIxnkSXK0nKTp/z583o5u2vmPMXKAk2Akv+qNZ1LaQFOnzfh6QiWZ7XuqkTZ2o0QF
	 NUyDpEFZhHRgwyAiIBpnQNNgqVUrda22omxe7RAUNb4x6Q/XWKcDWnWzSoa6NqGRloGS0
	 i9udQ2+XuFghEJWgL7Me3HNBwKgyvHY+9aQOO4iZRIbKf0Ljo8MbAUAVEFMOlGgjeOzb6
	 Prfl/qWM9PXXuHzfaplkJXyHbieyrlI7i26nsfhwJhZdDZFDtmpUiDTky9imkN1e5/o/L
	 xJuoQ/N8c4DW0ftLGX+BChg33ovk/+fwDdkOJCUoSzp5LcIV0khwG/UwV1tn8jR45Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I6OtxI7WL+2TeS//8ueyKGWGZTxNUmrgjEOWm9wxKMc=;
	b=yA/a1yDnAONuZGWLWChKCZTYsJhOX1ACRnG+afR4ipXP0dmfs1gIfrWPitifnaBhiZqK
	 l8R8T7eD9QXJCgXpPDHaiCzX/2oIgAJclW0Qogbnv55bEFd3bMTCjT9zLRWkb7Lmqa6P1
	 VHI0H35j8PKyzf6dcyNk2kpk/7PTxzfMrCoITDybJg2/Qju+LswFGnghF08unTZVxeYmv
	 Zg8cDAYSQ+9vBH5/xFfxEU0K1sA51iGGbpKhR44q9oAd8RC220QiTQFxjY6sIxe5VXwRS
	 XRVhhUQe5jMmqI4fcuWzSqateFqJnC7GNOf4gmuQ97ethyko+d91gg25eSkFRsGgZ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bCPN8iax;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BB606A889
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 16:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397BB606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bCPN8iax
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so4565376a91.3
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794845799; x=1795450599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I6OtxI7WL+2TeS//8ueyKGWGZTxNUmrgjEOWm9wxKMc=;
        b=bCPN8iaxZwxHkeEEoV2flXhQKVyLU1UeaElJkMXSPsUxm8Y09Pxc394i4sfvTvWSJQ
         3hkt5GRgypBSrp+C9bprEBrdUPtFqTrjE1k9qioeZHrlAEbkVg4cLCSR854RAtdytrny
         +gDIrJB3FxWM4s6WKH8Rj7lWkwHpx12jik/EQ/N8ffs/cNpZtyvOQWf2QG23TbuaDrHC
         3oRiT1FqJ7mHR47jbGRTCZMxYremJcffxjPaCSrgxjNvH00JOMep4c8EGOkxy1+UCAhl
         AsGY6jYJw7lInTlOD6SlHY2a/37NV/cvYhtOOvgu4sUJbwAvf0C+y0zyII8yW9XUBqpz
         UyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845799; x=1795450599;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6OtxI7WL+2TeS//8ueyKGWGZTxNUmrgjEOWm9wxKMc=;
        b=xKN3FL59hP7J1r/KT1I7IhpUbAubpB7tH5vgbwX12g6SHWomr/DMk5snMwcCVdTp7o
         4c3aDmY7wdAYKNgCHKXi5AaG1aCWNQFETOYd5MKvdQmOzHpf+wmi2GOOG9yBtEs2MQIa
         /WsClYsyWCsKrqG2ScC/qogU4FCkpyMb3W4Q09OI+2JXRgZDfAtcGZ563Jo3dZH+82RX
         HyJCQoraRDEsaCFHILKnjg1m15vPE/Sl5wzUzAdamLry14pZb9vqNVZs6bWjsjH5qtvG
         9t2V8Az3qd/MHoWaV6v8+JH/Uu7LwARb6noiPoe83uXjlaJZOJqeUE22HGj+ZCO6Ptmu
         ndjQ==
X-Forwarded-Encrypted: i=1; AL+hErFzJ9Brx1x9y/tbplf24FQf1KrCJxfhnw1E2z6pddcFUn3DVoCKyqrz8nm7GBxhLcNFUy7rdCLbkNaa@vger.kernel.org
X-Gm-Message-State: APuU4Z+gvrYMGe7G1HAJwrBGoudc8Gbepk1ynbU2WnPB8tRGRWM1Xn4i
	HrLxyT2BY6s6kkHH1FzETmZ4m6izSONOJDnFLnTTk+5AqheTjiQQwax+obrHGYzihjk=
X-Gm-Gg: AZFdTZdv3VHd7VqLWDufbJFnRTh2S4j1ZwUeBc2L1GuRQnWwSQQcONZkTfYzhdBMa//
	alxErs0o/VcH8Z4+WKKZM/cQhe6uqSvzyrqIo1untYYA45/JpRQ3n1NKvFviHYdxfSHit6gyStU
	PHe5MnWxtlExHWOElJqk5ESFUVatYn36F24jquTXM/MtQFTHe7+63Wl48SyDpW0Q8/JrW/OF4+b
	h93pKLMw1AAUNg3Y+vT+J/wTtuyAK2ArjcQzW4U/fjy8wkljVb1NkvnBUN3AfT60ItFmW1ki+2t
	1s88H7a6T10tJDeJT88NhuPPkYcpjuubSyZChzY95dGB4vZBQI9HNUfItqYGjAG68fw/C8Sy38u
	S9wZ5hmnJ2va+91Ti0WMPj3/jsu+guwwIYH04PJY7xIc9ta8qL5cA3H0VADLRAfMFRrAbFx1w3J
	0oNWExj8ckeEgmXAjqMQixzdfMZ/O7VVLk9X6f2nrKVk5suzJf4CW/qkPnqUsOHEk+LEXz1+oX7
	mAneTz62EWnKSnuJHL6tI+zhEeQU3VujPORNSsUeUmG/qGKW/rSGTv5CFRvrmbGFBSw8OTQDTWC
	3sRnVdb0oxhEh/235cF515TF
X-Received: by 2002:a17:90b:5112:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3b1b0cf4395mr11537025a91.48.1794845799382;
        Mon, 16 Nov 2026 08:16:39 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b1aeb17042sm17307491a91.6.2026.11.16.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:16:38 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>,
	linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: OMAP2+: pm34xx: add NEON wakeup dependency before clockdomain idle
Date: Mon, 16 Nov 2026 08:16:31 -0800
Message-ID: <179484576799.84649.9190527737165313514.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113-wip-omap3-vfp-neon-mismatch-v1-1-3f6f67b25251@baylibre.com>
References: <20261113-wip-omap3-vfp-neon-mismatch-v1-1-3f6f67b25251@baylibre.com>
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


On Fri, 13 Nov 2026 10:11:05 -0800, Kevin Hilman (TI) wrote:
> On OMAP3630 (BeagleBoard-xM), about one boot in three dies early when
> a context switch touches the VFP, which traps as undefined.
> 
> The VFP is unreachable because NEON is powered off while the MPU runs.
> omap3_pm_init() sets NEON's next state to OFF/RET and lets all
> clockdomains idle before it adds the NEON -> MPU wakeup dependency, so
> NEON can power down immediately and stay off until the MPU next idles.
> This was visible in pm_debug, which showed neon_pwrdm OFF:1 while
> mpu_pwrdm OFF:0.
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: pm34xx: add NEON wakeup dependency before clockdomain idle
      commit: 604ef0e4d9d1e3b9717cb83174817af58966d30f

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>
