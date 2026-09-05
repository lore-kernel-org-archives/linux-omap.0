Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DD3E1CFB
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591853; cv=none; b=NuuXmGayLjC0IQrSD+ueB4Yrdpitr4B/pyzsuxN8VnfEC4jGeJ7CKfMTkEucm1ULRBBimmo+T+GlXJ6W8xtFrs98nYIsHm0nX3qyKedy/gmBsCBCW3mxHN81jJLjez9yghzBPdnPQ6K4ofkkJzmXCtiv9h6Cvv/O8Q7PrMl9GNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591853; c=relaxed/simple;
	bh=snUd49mCf7brp4BBjf0T9QYSF39uzje6kt3MIufRgeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaFzf2nkrwpeaw3zrBWCqlVBx7VoK60wi5wfXffh0HHfHTfROfhxEQt2DQJbJJNndqHMaGc0DgYcCsHJeOD9tEAEzAzItuS1r843uEoOkevkf6Fc4f8Az+FhpMGeIWgwSZhIlpYCAGUJawSqKk122OtgeFPQU2LaT86LYuCPfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APjuR2bm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APjuR2bm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so1208119f8f.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591844; x=1789196644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j5lgSAOpNjAXzpb467QfOiibQnaDkCl6BQceKsplpJE=;
        b=APjuR2bm2EoJb+WyneRnBa4v+b+0gb7YJpOkRd6NJwnZfsB5vS28r8J4Eu9t63azgL
         eq1CmU4amK7XdRzOAQlxkAuAZTSC27/A4oLk0uA6XvH6OpHGBkiqfyDmlBSyMDg7pFzz
         Ps2j2ajeoziQtI9nOrzA6jMUTzw4gkc3gRvl0XAP6u1m7tyoB07kFREGWR2H1636O1s0
         KvzsfVr8h4dOwetmGw9Uw4DbByCFxt6VHHAZCt+ff1H5vEEta/f4wz0ji2+cuE5X4kiG
         CGZpsXGGxqk8/FCEZEPeDQgj9tFcHWk3YpxuyyIviRghmT/2GkWgIisDHXQWhRNvwB3p
         F2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591844; x=1789196644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5lgSAOpNjAXzpb467QfOiibQnaDkCl6BQceKsplpJE=;
        b=fbHot+oX5m/yO6XLnBCIl9YATK9iVCJlv2l4ySdMSt/SojgmgpDz0JIty5JHQJJl4Z
         iOTcJee0ti/qFGbRkKTakqBPtVaVA++V8GTWAO8ooJp5pjt9bwNyuiHHO+fZXKa8nl07
         ZJJ3+p+T6D+OqYMumGxgMNz5afpaHfrAjZdOQ4xNjpMwag4Ydtd3FBOH/inu2Lciv8KJ
         If8I6HRfrdS64wGSY530mRHbJcIT77U499DK1PCXhTl5Y7Ud6U1j9Qc9ZG3q4UIazG2o
         klew1hMgjPF4lFqEQdAJMxu3bqz43k/BTnfa1kzlvpDcsjMCz9qcsIYxCIzw+h7eWyR7
         xglA==
X-Forwarded-Encrypted: i=1; AKwUvBx0DMF40d/vkH3scJF+njg46wbF8IpXvw7pEal+6hIoXrEh2nxR2AWRk70SijroRN9kou7VxR9QUJCo@vger.kernel.org
X-Gm-Message-State: AFuF++nmggUf1yIYAlyESln0jK3EqJkx/3urPiezdYhaSfeyc+wQxPNn
	aYnuxzZxyvxbO8TszSIQ1h11uxJg3SAilJHEBPxMrCI8hRQu+FgMJieG
X-Gm-Gg: AYBFou0D+r1orSw4ypMwypSwjsVnbDvl3OG/fWjiDpMdiZ4MkaiE3AV4pk8Nv9gXEU0
	z52xZ1Ckj3jMyMXiXxvWVXORtdroDunYIbmsmqb7FZ0vM56GEyFAbXFUOxN2sQ3vIlGylrUFCqL
	lj9U5h8fLDcxJd0bcjRfrIilsyo8fXw11HdFnJk3M+/F/OVtvctjg7HZsjrNtr3gPnA+JaPSiKe
	hBzkg/soYxNiHRKstYKBX5k0zDbRoXk5iHkuzzIOvisL6lsldiwU6Xobx/2UolG7vCNZRxbSIw/
	VpnrHdsYO6ielMwtpxYEHjrLO3iHMdatPMX+FnyKOyze+1bkt5sPPmgNrWdH8zpF8LPa3+d2r5b
	+ogm98ELSmW5lYZVJsD+UR3K8VM1FyfEjLoO8cInwjlNnrnvR8V7FuRgaBsN0F7G3YNz5eHDahp
	Ze5tJKPJDtcjg7BVFcQl1uOnP+3e1FL+CSg7Xi2XGc2ms06e9vnasmlE03Il3oATJwOMqM0YEy4
	oUcxVsNJsngkNGzSF0gHZRpt1XdAeRtyRGzUNkKFwvqjnWK95a5Ik47LuqMSU0f2vm4uC9RJk57
	Zu9+fB+X9mUguQn5q2QGPw1UUARTTAvKQj9H6QzVuo5z7s4GP06EiQeYstJ+9Y00S9zCcEed
X-Received: by 2002:a05:6000:1843:b0:485:8c17:9767 with SMTP id ffacd0b85a97d-4858c179a7emr8752866f8f.41.1788591844264;
        Sat, 05 Sep 2026 00:04:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
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
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 5/9] docs: kernel-parameters: Drop the mini2440= entry
Date: Sat,  5 Sep 2026 09:03:43 +0200
Message-Id: <20260905070347.25902-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
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

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
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

