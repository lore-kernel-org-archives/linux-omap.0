Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC336728D
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003991; cv=none; b=LW8UISU04rAggUZ5es3BN9dmhrQV0bxW6Ir5gHJ/AXQsj2BXpewoE11BPtL4Iy4w3oEFtlu9qu+Uhkrq+RZpu2yGIF71g2QqaRYxs0vfBpBwfyeu9dqNT7DYY5whGp3HQnpxTyyihp19Nu4wAzGQ94J1CyeWqT3VDQvBROHG0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003991; c=relaxed/simple;
	bh=qYH6DW3OX6UAw4/JqAXW8T1nZ5UkGcJ820hwItfbiXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALjiZ9c/5pwBSBuY0IqfP560g/lCO6fR0rgvO0pp6JYlKzuwMSgapj45k1RKUvKSIIOYGQR3lUplh3hmBPVdpbvXm+CeaTQc1phBrL0LvOUa6aLRVg7CW2Mhj/XV1yzU7VfstUsb9d+Hz2M0kbWZfB7v1v0wKN/rTvH8DrTD70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHGsoflG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHGsoflG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so51846465e9.1
        for <linux-omap@vger.kernel.org>; Wed, 09 Sep 2026 18:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003985; x=1789608785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+FNgBRdn5SuYqzApc8cKDhkrkv42DWP10C8olavTwg=;
        b=VHGsoflGoH1EMEKYJ8WhYHFs2hx5YMvsRMtvZFqrxZi4gkkOTIlcRiLxqiKZ89PTpi
         pPJg2JioLNUf8/KeChzI/4Jg6CPTtZddUBlXpkgLJF/VEjiFoMJ36ZNrDBRdJLNljXa2
         KkBgTiMG2f5CkluzgDlEM0njkRz0k4vG/QnS9a6Na8V10UEYtJi2WacXbzkveN3eZC4I
         M2WXHAaWSJD5oLXngZ0Flv6g91kXWJdwiZdX4ygCGSwfEnQeTE0em0Z5N6IAAOG1U2xx
         LWCnckAWNuInTAQJ1HB4kmcbcn9x0P2m8QYpTl88z9zf+tpd3Ur/ngcSu6QeFKvibUJF
         +Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003985; x=1789608785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+FNgBRdn5SuYqzApc8cKDhkrkv42DWP10C8olavTwg=;
        b=hzopWVS5vUR6hhwhgUKIaloevnC6oQplhE/h/V0pbdSN72T9V4KDddnqFGlCOoAQT/
         6do17ri8fj0Gbb//dlu/hfaaUJRB1odo2u4RSaJHSEDZqCq8eAgpmnRAPF5f7i+5sF7T
         o3nYg2vI9hCJZ56awgfJ4te5GzMLh9tDZr6W0O2K+m3TTqT6sb1GZ2Dm+RABgP39oAi8
         lg/supUGAEWw+gv+wx7M96X1xBb1qbAJNCpdaJXGmFD7/C/ZrUmQZdTuzIetLtzj3Tjr
         VBjSNHLxejfrrvBX9aYdppe5RfK0DZZtBvgXKHTT6NbFX21kRw0Bfr+QvrHG4IR/Ftbb
         w4Vw==
X-Forwarded-Encrypted: i=1; AKwUvBwB2QsaTDO7gW46IyrgxAF0zZzh5qUlLVV3gMCY177ET7iDdtg+egHZRYeMmnD1F2Pene0cYduYC3eo@vger.kernel.org
X-Gm-Message-State: AFuF++lrftSQwt6oOiRajZSI5blm+66Co0VhTsN75Ob14PM6WyV/u5MQ
	uK+4onS3NjXUaXiPQYv6pnnfc/xPaUMAX8UDLFFOHT9As2XD8dvF4Xkc68pJ7J6j
X-Gm-Gg: AYBFou2Nmci6LvzO8NDE7z03T+7RnYo6xOjQzyy8yBvtTQ0K5jxYMG2LLW82K1rK+dr
	VJn5TQPS1hzp6CmdLUFIf5NYVgrCTkJaQtBJ+99hxLres1kQ8Y+j97bNW9KzfJSrtY7mnZTTVcb
	MZEcjaTvqfs8ej5HT3PROHVxS2tUgfmzLiGv1p0NSoihNuuFt2MyMxErHbjdNQD9zGJYMD1Sc/t
	wlI5IyetOq7/dluiE9/jXnywjgiv/TiOmu9X0gcuVNGm/TmLYFc9JH1M26NkGp197HLytjzB2lh
	0pDeuKOvxPBVqdmQmL0AIxFPVZly7OPXgWi5bbeNe1I0wCuqHHGJ/dbDrTU8wGnG55CszunMNy4
	9iYXDfivNrPYbnHGLQAUJcYcqoHnbcqXA8fE3PlC2sRk8JNjoj+7D+xbIFjWm7BsMg/oKnboiY+
	9vwd/zWDUkFYd0/RlqTOTTxAe/pP4eg+efiPcjE7hxtkTDrculvY6vX91cNx2y24mpxUbjxkJqa
	Awy33iJmq69hSUlpUp7ElFCnhkqnbazNt5WkERus0DKTwQNGGpMhovjLJrdRZnhB4CPG+wv0j5G
	DkbDi29ivJWkY0TLfWwiCPk0NWcFCoeSyTai8PJCb4iKBzx8Np2KxePPKofDWOkCDB89L5BdM8l
	FaA==
X-Received: by 2002:a05:600c:628b:b0:49d:2856:fcf6 with SMTP id 5b1f17b1804b1-49d2856fe91mr11506445e9.15.1789003985034;
        Wed, 09 Sep 2026 18:33:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.33.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:33:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 6/8] docs: kernel-parameters: Drop the nomfgpt entry
Date: Thu, 10 Sep 2026 03:32:43 +0200
Message-Id: <20260910013245.8619-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260910013245.8619-1-kmehltretter@gmail.com>
References: <20260910013245.8619-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nomfgpt went away with commit c95d1e53ed89 ("cs5535: drop the
Geode-specific MFGPT/GPIO code"); nothing parses it any more.

Drop the entry.

Fixes: c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2ed1e2c03c61..d44728a45506 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4553,9 +4553,6 @@ Kernel parameters
 
 	nomce		[X86-32] Disable Machine Check Exception
 
-	nomfgpt		[X86-32] Disable Multi-Function General Purpose
-			Timer usage (for AMD Geode machines).
-
 	nomodeset	Disable kernel modesetting. Most systems' firmware
 			sets up a display mode and provides framebuffer memory
 			for output. With nomodeset, DRM and fbdev drivers will
-- 
2.53.0
