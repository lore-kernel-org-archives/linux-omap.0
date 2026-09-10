Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2358F368D52
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003988; cv=none; b=RadYVuDHKhnY18LIxwYZriY/o4IyRJ/ijZjrP9W/bncCtyuqi9qobiijie3Jol4ApB7DYu8i5lD3Cc+Zgq7WgvfNuXEZEGQdOWF9EqJQq0T0NtsmIFJ2qFIzzqUwMzjfCRUJjciLnYENyLzWz3nSYMFWvM3F7SmGIYcsaRUuosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003988; c=relaxed/simple;
	bh=wMHs/iq23jFT//QzJfBpBUbxOI7qz5njBBA7AJ564ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVBPVA2xoVLiPOTByXRBa0hk96vbWlbX1MYu0IJhiFeVXPiuC3ab0IdT2qL07nwdateRlkBdL0wXOZFcL1bT3EnnZSJ6Lyk43W9Dm2cegNnbBh1n/lUcf//oOZnYzZiIs+jP6hvqlAFiFTvE9IU8oFIgtuZD0ZLU1h9H49/XMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9NFaXMT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9NFaXMT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso9500375e9.0
        for <linux-omap@vger.kernel.org>; Wed, 09 Sep 2026 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003983; x=1789608783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNvpcd2n4jxJTfGRiEyXYuLqoJRCII7SmcuheJPc0Qo=;
        b=Z9NFaXMT/DvEIlT798YF+KykZ8nhZjIh+BwG7MctxmS7Evw1UXiFDXLYBMkSCR7O/S
         +iQhkueaBvWlKYUrMqPjxiTSJmb5n6N20m/psh1p2SSFWkN+I8hy/ieK0vIjfJiSGHBe
         J87QnIw9mVVT6/sBMhqsR1ozgTkgcPsHCcP0IPw6QaAYRny/UdRB5hWK4JYif+9eBBFH
         5kGNfl6215Px9v5F1L0fOGI/8N9Wf9IadYFvkwSBMfYgWJa9swe3wuhrmQ8Rbu+ud2Bi
         /3MYyCONBMLpDWqfR4T/+jkcfkKENoPzYBeZ8eGVEDhQvCP4mR3WSyrJ4CkzrUmaxREu
         I+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003983; x=1789608783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mNvpcd2n4jxJTfGRiEyXYuLqoJRCII7SmcuheJPc0Qo=;
        b=J0ZCsCKZSaMG/dOKImwq13KdeGDXEnwgIsRtk1Ow5Te0rIR1vCDIHQP5ptAAjWuAe4
         R+bKDfVeK73GhzwsnYRV71IJK5GwzkTLG6tp6WDeo4aV/12GhEX0yXMTsjPZX3zEl6DJ
         6FoDsjudKrCdRAUH3q2t0DWeIqnMbq20KbIbGyNi3DkKi8mMfG9neiAMgRdPD02ggWa1
         PfwLwB/Bf5/O+7wfDcQ/JUl63nmSNz+Ac31za8Dwi+6Pt3c2JbBvyW400rn4748tbEkg
         yX46mHXHnQZDGCyDcyKvKy0q6rM/xsOUtMu4elPQPuWkICTCrUoKIMzSmJrUEARIoSr3
         +pmw==
X-Forwarded-Encrypted: i=1; AKwUvBwdXT6XmaYV3FL4ykLUbgWJHqq/o7xbzK/2o4AQF6hmkNWm1lIEz5jhVpRzKt5nXv48vtxjp83lpX4q@vger.kernel.org
X-Gm-Message-State: AFuF++nwQeQWqW7vLG7vqZkHjE6OVaJmOwej3+BwEfLdBNrxfcXsEnZB
	DV4fp7frdO2xatqry3MibZ3Lg/9s4D7Dw8HzfNvjRx2QUfLl9ap76WIq
X-Gm-Gg: AYBFou1q/uslsNb+AkJZ2Mg0He/YpmGyyl2j7Pj91KY41Toq//0gFs5/Ch/0IH1dfTJ
	VHcgQoQ8ClAdUWbseDQKe8tYTmhuAWcO1TjGuGpDvtuabFLBY5LsDSVhpaBOfH56vF4x8MaHl5f
	ctS53pbxJnBKY+/UnZ7nLdsSbeCYlELrm6k5ebwp0x0mB1qTtDtJzkG/K4DOY1Jm711k2rSpnEy
	2f1dd++RmtLve1zN8f7ChmSFf1Z4Slwge7aj1sEDhITKEDNBjOHPaVSJTfcUQOp2IevbphXbwvs
	amU3Otm946rnrGUeHbAI2f7JTJBrVNZOEtQ5HRE5hi38vT/6iIatVZbUcC1v3E5j6h13FLjFsYp
	IYCutcUwvRBdZ7WwS9MMXSkRM2YS+Zd6Z+uKgkyfacMiaJ/vovE+QvVwPcgCpQDbWkEMUjZ8K3m
	yMaHh4iEoZi7cPSf8n190c17GvZ1k05syu8VOnZlgvyTIwyi2GNrQvtqQhLpkuw5Z7GNu1AXW2l
	T9P0jN6lqSE3HfISh6Br8XRZG0pkBFHKH6Kf8h3E2tmCyjZHXusjyen2H0UPNYMnZSgPdxdzZ2v
	+dD5JiFArkWt5OEOV4Sxc9Fu61NltYjAQfg76OCh7fjfSsHRCSaArUbgr9ExvDYZ4izs/nMU5hr
	22g==
X-Received: by 2002:a05:600c:3786:b0:49c:f13e:e50 with SMTP id 5b1f17b1804b1-49d26dc1012mr14683375e9.13.1789003982600;
        Wed, 09 Sep 2026 18:33:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:33:01 -0700 (PDT)
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
	Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 5/8] docs: kernel-parameters: Drop the mini2440= entry
Date: Thu, 10 Sep 2026 03:32:42 +0200
Message-Id: <20260910013245.8619-6-kmehltretter@gmail.com>
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

mini2440= went away with commit 61b7f8920b17 ("ARM: s3c: remove all
s3c24xx support"); nothing parses it any more.

Drop the entry.

Fixes: 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 .../admin-guide/kernel-parameters.txt         | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f4314492953d..2ed1e2c03c61 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4052,27 +4052,6 @@ Kernel parameters
 			Enable or disable the microcode minimal revision
 			enforcement for the runtime microcode loader.
 
-	mini2440=	[ARM,HW,KNL]
-			Format:[0..2][b][c][t]
-			Default: "0tb"
-			MINI2440 configuration specification:
-			0 - The attached screen is the 3.5" TFT
-			1 - The attached screen is the 7" TFT
-			2 - The VGA Shield is attached (1024x768)
-			Leaving out the screen size parameter will not load
-			the TFT driver, and the framebuffer will be left
-			unconfigured.
-			b - Enable backlight. The TFT backlight pin will be
-			linked to the kernel VESA blanking code and a GPIO
-			LED. This parameter is not necessary when using the
-			VGA shield.
-			c - Enable the s3c camera interface.
-			t - Reserved for enabling touchscreen support. The
-			touchscreen support is not enabled in the mainstream
-			kernel as of 2.6.30, a preliminary port can be found
-			in the "bleeding edge" mini2440 support kernel at
-			https://repo.or.cz/w/linux-2.6/mini2440.git
-
 	mitigations=
 			[X86,PPC,S390,ARM64,EARLY] Control optional mitigations for
 			CPU vulnerabilities.  This is a set of curated,
-- 
2.53.0
