Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA6481AA4
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513990; cv=none; b=NyZvB+t7Maf8+e70ULked9tGLwIrk2N9Y5B9KgSpYMrE5v/C207ywHckefBCkEdKiOYn4Prf+pfqvXILhBZx+9WXZyT7eL51SiamHoFZS7wujTQAc/P3SxsnZYL+OFtNxehoxAS7KJhrF5KSrhn74Buan+8IE4FtqzGlCi+TXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513990; c=relaxed/simple;
	bh=K+CFi/DTebo+LkQ73pkkCHTbdYn9wwIkwVAsUAWatNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akn0G6sBvFS5RtU8V3zCaZWWjX0P8QaE6JdvMmujKrxDK5gU+Ar4VOOpSpauCFQ5MoyY8FzMe7GlOLwsK/SNpm3Wtfx4C3x9vzQA87L1tEDyktCCdKzd/+FBu7edxOhS2+gyJaKEi/pv22FtmdLH7LtoNxMlTHSt13hxevmoEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=kfSn9uo5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="kfSn9uo5"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d634956fso149399171cf.2
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2026 12:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1780513986; x=1781118786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMQDZzkAceKmbVlgeR/OkIgBvcbZzdRHEXYWUVGu3Zk=;
        b=kfSn9uo5G9Qdl7V1LgIBgoLWt1Txlp6LfP4FBQEQOiaq4wUjmmozipnqQEGgvFLlHR
         /MJCiGc8wpq2W68DvLu6muSU8KfPW1lbPw3I8foh7QN99ZboA3NbgGaHybCjSut3I4Mm
         FKfcZd9KMPRNH65yNg7gN8g4NzNn3GrDB1ufBsWIydpBwiP4eA3LzgNQcuxwNLTAr3rj
         3Oudru2NIBwYXUATvHSYW+GlgPj2xzRVrOdwRVhEz3t2uvoIEeH2BSnaSfpPkDA+4I+K
         z2uceMI2RZZszx/WfyTk/PNz9DdYW7fxtVuefT3I9qqTW38a71gSafT3Ahq+o1VhyqXy
         5tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513986; x=1781118786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZMQDZzkAceKmbVlgeR/OkIgBvcbZzdRHEXYWUVGu3Zk=;
        b=JU2hOEx5Iz0QPP75jGGpgzrjjX+80kzoaifQkjegg92glkjfYK/KILhYGir8x1tj4v
         S13iFcRjoNHx8BKB/KgBefDHXE9z9L67k9vuX3mIYCCcI4PNGjOs49h6bx/IjbIglzi2
         fyUQXCJkmwIr/Y2Lst7rVKzUYpPUDrFhDAZNV4CNthOsdBj80WNpfWAgnMTboQSPUH45
         y9IYbX/pc4FCqdRRUvwOiNN9GtlA825Lkyal2hT4upsJYWLq7VMV3wxo+vR4mfwVebdZ
         orOzeY1kLFU3zFXAv8+BrE8DbrQlcLvB+jp2C50ODNYhW0mqC2xrbutIWWv2QNaJ24m1
         n6DA==
X-Forwarded-Encrypted: i=1; AFNElJ+hZEG6tN34wJbPgFz+bDrTNAjq4GEdejDEiJIK7DZwzs1kV6mdSwe4Zs2OFcIBmxR1XhQIw08xfvNZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwzgaIDJDDpd7qWoLjLinEgNsgIqMtkRGMel6yaM5MYHnNNe1tu
	sB6G9mQtWHj11OpjDcNsom+BfEAI33ogtC/fEW01Pen4vv4ZNN3bIo0X4/SwtPSyiQ==
X-Gm-Gg: Acq92OHbocBW+Zu/uLp9LEuGX334XIaxbuSN8l3+zc6uOJCH/TQGr/1XjOl7y5ahFqi
	PzuIAZTGunfvekph4UDKSBuOqUMhXyY8a5gllQ4rwuq5gnPRz63uiGLiDCgVDWcE4PmR6Tarzmq
	dopI/ocsxyqtmucM9EbDMdD2nbvI8/SD4P8ORWwa050SX55gPWZVInoAb08NS/3Ob6zVYiGZJhF
	IxNpD05wO4rVsI7iLjDAI8u2N0MyXNLc3BcIjsMEztztKQUEWtBMC189Cg4JDLwLNXx9NtLdAMg
	cOjdSjuTQSZRgJ319wJ1GDNocDao7/f+MkgEUnm9WmxbAacS6+EXDZP2QI17DjxHfo822knfqjR
	8prMyJaRUZX2t9EohzxGWlFHpklaIuTqYazsxqY5KEFO+p5aACkoPoYnQQOBAQ7WeWpqR0ZW4TS
	9vq69L5Yjv+JiH9Exerub66YuIgag3eEtfB2GyeU2kG02rW3v7/CL0Y3rmyYv2oai1/qaRQgAH5
	Lyo3zZ3VcxsFK3ba3PrWLWF6m3cZT7UBbmOW3i1wmm429ctqiE=
X-Received: by 2002:a05:622a:4206:b0:516:e109:b65d with SMTP id d75a77b69052e-5177878238dmr73610561cf.58.1780513986246;
        Wed, 03 Jun 2026 12:13:06 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-110.syrcny.fios.verizon.net. [72.90.70.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dffb14sm32083891cf.28.2026.06.03.12.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:13:05 -0700 (PDT)
From: Jonathan Cormier <jcormier@criticallink.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: Jonathan Cormier <jcormier@criticallink.com>,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	u-kumar1@ti.com,
	vigneshr@ti.com,
	sinthu.raja@ti.com
Subject: Re: [PATCH v2 0/2] AM57 timer fixes
Date: Wed,  3 Jun 2026 15:12:57 -0400
Message-ID: <20260603191259.3723777-1-jcormier@criticallink.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901101525.1090334-1-a-dutta@ti.com>
References: <20250901101525.1090334-1-a-dutta@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tested this series on a Critical Link MitySOM-AM57x board (AM572x /=0D
DRA752-GP, 20 MHz SYS_CLK1).  With counter_32k disabled and DMTimer 12=0D
registered as the system clocksource via these patches, system clock=0D
drift dropped from +553 ppm (counter_32k 32,787Hz instead of 32,768Hz)=0D
to +2 ppm over a 50.8 h measurement window=0D
=0D
  /sys/devices/system/clocksource/clocksource0/available_clocksource:=0D
  dmtimer=0D
=0D
Note: to make the fix apply to non-beagle-x15 DRA7/AM57 boards, I moved=0D
the &timer12_target and &counter32k overrides from am57xx-beagle-x15.dts=0D
into dra7.dtsi.  Worth considering for v3 so other boards (MitySOM,=0D
am57xx-idk, AM572x-EVM, etc.) pick up the fix automatically rather than=0D
each needing the same per-board override.=0D
=0D
Tested-by: Jonathan Cormier <jcormier@criticallink.com>=0D
=0D
Thanks,=0D
Jonathan=0D
