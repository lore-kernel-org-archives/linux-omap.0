Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1D3815EB
	for <linux-omap@vger.kernel.org>; Thu,  4 Jun 2026 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551815; cv=none; b=sMi2qrNvSKRWnFrzeVg+mdhn6gWj0vwOcBRXSVMzaLPyx2BYq9Q1lml6xV5AYNp0YWPP7PkzIERyDdASXhbaDiXvRna0FKz8RFH1uZSHcA5wVMyBf6ajrk99j6RNedNP3MoWa8sIKcYLZHAEyHgHOcZUaU8Q7uQbR1izqoyrWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551815; c=relaxed/simple;
	bh=AEhMerSE061sddegxts/S9Yhziuy8j0ynoTHFqr9dPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFIkzal7mr6c8qTZK9vT+LOx5Fw6/RFeZGtzdkq65SBkoKZjVQ0/qY65bdxueqX/CXKLMedqzvFJ8wN9FTP18oKWa3m3evyySCN498EBus4gabWkJ/tJFSEChvtXb9Z7jDNgeoaK3TwER+ETcdhP7TpYSj17LQ1kb4i6+g0YRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZT65k/a; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZT65k/a"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-485ecc0f2dfso257724b6e.3
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2026 22:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780551812; x=1781156612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd5qbt0svs5X9PyH4+Z4KjGVOSti+IcuLa2FFG2ZmDM=;
        b=IZT65k/ah3HlYSvxju1ztD2wR9iBVa+q72laGmb+7NlM5QpjvGXaJUhyJKSt8Ed/kP
         rvR2APlqYLddPgrCwCID2laqNCx8y1ujRKO1zDk/I74tW2LTMWJjMxDaAlqROLo9qA14
         z+doCq/xwRbpnL8YmsecXRdwWAh6gtjsQESJ7Z4/ujsQxu45/zYRfA7RhYr8brJSFVex
         j33fvS0yLBG9Rcuv8Xv515zxHinKPvIZ3bv1y+DzOmdQf0FGbHT6eWQnLhIBCUSiY3YF
         i2moiYQb4+qBTcclmrG4ViAgJ6qjd6YbgrPpkqqs1EX9PsncYnsZr2lfiOoPx6s2Yxsg
         0mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780551812; x=1781156612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dd5qbt0svs5X9PyH4+Z4KjGVOSti+IcuLa2FFG2ZmDM=;
        b=fEFmTZJYq020D+j6T/402r3bYqXrOcaTc9B5xVqz8Rk15jLEJ90WikAH+VbcJQl2p1
         vtBZ07EsmD5/pfsLzlS1FMzL/yMxiDAerDu44tofnQvDNrI7R/BSI3Fb0ufNCFgGzBIO
         zg3vcAmUpCBs1QP3n3GQhj7ROhb41JZGSP7q1tmlWvxl2B8Taws7smR0nDRt2376bXn/
         l1OiZCanBGzrCQMT+aUUrcNmrld0MEUauWiN96eJ6hSCMaEFPG7KAUFrh+70snntdJXw
         GI3RSItkCru/OhjSt46Z/Unk3EBnrik8rQs5MF48ZYRWcD5IHzOiZmgoHRwJLDiEITvu
         xBhA==
X-Forwarded-Encrypted: i=1; AFNElJ8vbsH+5BgzoX7jsApkLM/irFdAplKxJHRd45YAI2gwihQEbyrufhuzn7eep3ZleOmP2YwIIzpCB1U7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3W0yzrLV9lY7jQd3cJ9cQhC2+bsrE/C7OpPdls0zal0Jt/5U8
	mE18SYU+dAE+47rLY5k7ItkBg0DtLf9YPOWTLa3RH4BIb1StOJWUlqQv
X-Gm-Gg: Acq92OEuaea3lO4o4nk2oBmlLGBsjUy4nJcDeCad/iZDd0UztlXFSM0wscX8RJAawOp
	eBdsLUf86Z0Oei7Dh3GzNW1fq25e4lkw1tuVluE5yeXmOPE6FRK1lKBAOhvcukQaAz9RlyoAYgc
	q8Ya655uqwCLfmFPlGj2UvITudifAIFAbKQjuxIle+p4MwP916QB1I1yRZaitn9cFZt8ggzMZvV
	pjzja7XA67ClLvp9MhgRqKtNYUdRfnsY3tbiscit3NXF/lwfFSEC2s5BgfAN7epZIpI42uE39WV
	h++vc+6Sgt/YkxnGHq8BQUC8L3rC92+SnaKnzivtGihilhi7b87Zx5ZLPQ1lmYq5+O8Zr4bzTQH
	I7RBEaZb/G4GbPVqy61hjr3eN5wmCITaB+CqQyd1QAhrfmwCJ+xnPgkj9shlSRpcMzQN8saKcKM
	CciyBhTfPQ+oxXyzExycQQFi0bly7Wi6FScZ6RY1gnQXoa8UYmivVOBTdPKur+7LNLMv7nBn4jv
	e1BzC+0MY2DDBiI6zhvH0kTtRKip6seYTGxZL3bQHigrAC09IrbtqWJpDu5kEeYfDR8SA==
X-Received: by 2002:a05:6808:d48:b0:486:4892:d562 with SMTP id 5614622812f47-4865a9a50b5mr3872126b6e.1.1780551812279;
        Wed, 03 Jun 2026 22:43:32 -0700 (PDT)
Received: from localhost.localdomain (99-61-165-33.lightspeed.sntcca.sbcglobal.net. [99.61.165.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e75c5495sm3197548a34.10.2026.06.03.22.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:43:31 -0700 (PDT)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: nathan@kernel.org
Cc: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	bavishimithil@gmail.com,
	kees@kernel.org,
	khilman@baylibre.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux@armlinux.org.uk,
	lkp@intel.com,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	rogerq@kernel.org,
	samitolvanen@google.com,
	tony@atomide.com
Subject: Re: [PATCH v2] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
Date: Wed,  3 Jun 2026 22:43:29 -0700
Message-ID: <20260604054329.19450-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525165527.GA18457@ax162>
References: <20260525165527.GA18457@ax162>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> are both pointing out that cfi_types.h needs to be included in
> arch/arm/mach-omap2/sleep44xx.S for SYM_TYPED_FUNC_START to always be
> expanded properly. I tested adding
>
>   #include <linux/cfi_types.h>
>
> as the first include line and both issues were resolved.

My apologies, I was switching systems and seem to have lost this somewhere
in the process. Sent a v3 with the include, thanks a lot!

Best,
Mithil Bavishi
