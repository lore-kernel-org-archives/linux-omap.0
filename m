Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736DA480326
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198293; cv=none; b=YRgCkP1rbo01ZVQXkdVJCwLewgLpPPFu2o2lV5RmM+5TDR4fItjQpmGdRpeTZIfTshOH6uFyIC7pWqWXOADG19m2n2P/uP1M+aQsQ1gV8vExvauBCqDWVbOC2vWuck5OkfawwYXZL8md0c1rbF47S8EqkxnTVjEILcTPwLk1jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198293; c=relaxed/simple;
	bh=OJz59BymLPH2X07/HNaEsZOAqsWDBphkuaZ4veb3x5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WyfsTSnI9PJGxCwlQ25WIJny5b7whuLrX9QmP5hS59rROC2vKgievUBwZpKRJjoZEpeFqxEoySScag+s7++jLwnhInylzDCzklEbgRGYlhVdYZCzoHJMt/5VWyvsYlhPMaDTShdQAdIbVyS7xKFJqj8XeQsuflzi0mvr7Q76k4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d8f265cbe6so21101245ad.0
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 10:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198289; x=1788803089;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iOcXlRKPdGaWyLXZRmYh2gsjN3nZXYDCKL0Pm8ihJIM=;
        b=aU/2o1krP2/757h8i+NxIPoV8dEnKcsSD+fHfoy8X6zsirdaC3vZIREuMbN1h2TMTr
         J42aEQ+2PnVG46QJsz0b4kqiOrPzzCpSgD148t55lABI95OkxMWStm2cFrrmC5RvbWhJ
         01T9b+31ou+vgmD9kCoqpUIt/NvhGW7UphXPSrqvnZHdQOiYXcPc55/91t5K1i+o5a//
         m02hngwBmInVdpKNK+m6lnbDoim3JAmUsKZAo/Qji1hMH87dzvUifBEqe3aPYB9ULvLT
         AD7BToU1RhHfMc0YapSuP5RD1wVja3mOoNbNPrY7u3a8nk9Yx63J7iOOjr+D1W4N14Vi
         c8nw==
X-Forwarded-Encrypted: i=1; AKwUvBzwC0+GGu+wm/KzFlj5GNYBoHiZRKhKycT5bNETnAQEU/GluJXQO2tcJxtO/xaS7+ZRoaPI7b2/dAJ5@vger.kernel.org
X-Gm-Message-State: AFuF++lYS3lzcH+6lPZKTibCXAvgFODTeFNlWtKxB0PC9+mavTPy9VeU
	NL+/oFacTyBypVOEoQceXiny0tPBicmNNUlG0sylfEFa0Iz1SNMC+1Cd1lZqPsbtrO8=
X-Gm-Gg: AYBFou3DIDuoX0g9Q5mol67+JAnmJ2RFAW2rp+w9rKxzHfScLq4OFrL1jpHOGz72P0p
	HuiOz42awrBMTZH4oiOhdCuqGpB6X9ShJCEjtys71SIjRuwNQSVMKAqqeZfBY45tYS3G7Ylj57f
	HogtIKDidUJmienSip2nSU+fQPQKGlXHq+yMAQrLk7YOQ69wrvrX1kaBBLR59EGYO/ajHEOXdwu
	BMpt/4u6H5cSl/HK3lEGrOc0tUuTLtkP6v/akABnyTPrQbWzy4tOoA5zXSOqsOK53TlVutraX2j
	0E6h+E7oL1ab4oUPtJvGAmv5ZfuqbYFWlCnmD1oikAKYJ2KUiofmOpEUrz5oJMiJoWnLOLrtzxq
	MZ2iP42QPtwUPaf2nJAVuy2GRD27iMM3kBvUdtpvhqD7iGQmmKC5khe6vou4Ajndy4bZfIlNHDh
	tCDEm1e3W+DyC+MlKv9fcEyT4iGd92J21TXPTuB/xUnAheU2n5mpp0+C0lmA==
X-Received: by 2002:a17:90b:1d83:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-396d1023217mr36121504a91.14.1788198289340;
        Mon, 31 Aug 2026 10:44:49 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990d7bb7c5sm664546a91.14.2026.08.31.10.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:44:48 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Register
 clocksource/event only for am654
In-Reply-To: <E27F05E3-DE4F-4C77-95E3-1701B3410E93@goldelico.com>
References: <20260828-v7-3-next-topic-ti-timer-dm-clocksource-omap-fix-v1-1-85f0e4dc6f9f@baylibre.com>
 <20260828230445.3c2510b9@kemnade.info>
 <E27F05E3-DE4F-4C77-95E3-1701B3410E93@goldelico.com>
Date: Mon, 31 Aug 2026 10:44:48 -0700
Message-ID: <7hzey26v73.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"H. Nikolaus Schaller" <hns@goldelico.com> writes:

>> Am 28.08.2026 um 23:04 schrieb Andreas Kemnade <andreas@kemnade.info>:
>> 
>> On Fri, 28 Aug 2026 20:47:45 +0200
>> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>> 
>>> Registering clocksource/clockevent for the older platforms breaks
>>> booting them. The older platforms have their own implementation in early
>>> boot that is used to register clocksource/clockevent in
>>> timer-ti-dm-systimer.c.
>>> 
>>> With am654, the timer is much more complex with more dependencies so
>>> doing this in early boot with the other driver is very difficult and
>>> gets ugly. Instead it is implemented in the platform driver for am654.
>>> However the old platforms may not register clocksource/clockevent in
>>> this driver as that would break the boot.
>>> 
>>> Add a system_timer_capable flag that is only set for am654-timer that
>>> gates the clocksource/clockevent registration.
>>> 
>>> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> Closes: https://lore.kernel.org/r/2013A99A-0502-4128-ACFA-B04886224393@goldelico.com
>>> Fixes: b8eeeca55456 ("clocksource/drivers/timer-ti-dm: Add clocksource support")
>>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> 
>> Tested-by: Andreas Kemnade <andreas@kemnade.info> # OMAP3 GTA04
>
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # OMAP3 OpenPandora
>

Tested-by: Kevin Hilman <khilman@baylibre.com> # OMAP3 Beagle XM

