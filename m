Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D0364EB6
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003976; cv=none; b=jSuzUzWcC2LMkjv96aPZqLHVJEaeF+fqsvNISAhJl+MygQHbf9n3KyiWglQQBUnK57FBNfWmm9E9JHreC1pnMOCb36r2x3zJnXixqVKeZhBaCv+cvjyGgMGzUS4NuqgoJeNuLcbIhaf3iQcwP9gJIs9O0Sj9/p9a9OMPjS0TwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003976; c=relaxed/simple;
	bh=Wrt5BREBuyuGcYt2aWXWslgff0dcwvsUynDfCbIh+Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pf4YEw5AdqmK0k5R6yFahUPAj18bLtjyx73g4HxomF9HwZjsEt8CdGZtbb3Hw+YJdWn/TxHHmr46rc1kcVy1lBZOh6xE5YqBIZ9cQW9SDSWUNf97QwypQkw6rAnS+4mF5kOWGaZFxFSMr+9X1R0FcGw3E7KRFLbL9VsnRJFPGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLT3dHgC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLT3dHgC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4957eefd361so51355185e9.1
        for <linux-omap@vger.kernel.org>; Wed, 09 Sep 2026 18:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003972; x=1789608772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0noSNcNvP/+I+rxnaf4LKhy/qChedg87Os3I3Fnbpw=;
        b=eLT3dHgC7yMLi6m1347n09ROs3vSYpE3Z6WyNi9WBErck4EuuWeauqwJmkKbS8Jddu
         6qK0q4ehhAXZKenmNiYf3ob//zR50xGqFTgEmT8ONXJOlw/Lo2ocn3k++4zHV48AiTUj
         zs3emWmobC0Nv0/m0/k9qfYexRAOQH24/D2N3zHF70mRogXpH6FKD0b1FbZe1Ll6DjVt
         iUiQNxWlTM/gP2irbowpAQbvFc1RkJA0QvT5Z3UZkO/ZS6zNg16tBZkjiPZycW7x6HhJ
         LrLhvd2zvkAFqoHchCXt3xQxta+aUSvlvUUD9pvOdMVGc7zQ/9br7uZ9d+6fQZNIUcwh
         E4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003972; x=1789608772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G0noSNcNvP/+I+rxnaf4LKhy/qChedg87Os3I3Fnbpw=;
        b=TgFW7hsJ4GlLV3ZPMwmuzccb5qrLIDdGqEX+AujXTBsuIXB5KsFFPZgZKiuyFL5Do+
         FCTNe8kDzFOXkAKS5MA9mOCnZRvduBnWDvoNtfUg3f/Myb9ArikDmaUjuPcyoAUSEKJx
         EmmI+Wewfys0LZaquEge8vfTyEBX+d3+8gGhTVi5N4L0j8gawTOeU1PZEnCGzOVUg8Hx
         gLO5g63X1BK/UcaNGuWeX2kt3i6WkB3Ca6QGBU+NO+0G7QzbdhhX7IpwTyQFPitMUfYg
         xJlOc7omi206YBFqxsFqPoh7IXDMO0b04rmcxKuo22cS8xrcsFFbF8/O/2dryle7QVzt
         sHvg==
X-Forwarded-Encrypted: i=1; AKwUvBxAN5y4PInY4vM5K0biOePw14593e+ln4aCHHxX18hLUHYkxn13LjBueoRiQQP25WKS2m9askZfXzIZ@vger.kernel.org
X-Gm-Message-State: AFuF++k/zzXUE/1QgIswAPvMWkaThQk1OQwhCqZKXO9Vr9n0dKn46bQS
	YjS2rCvVP4RqWDv9wt232zp6mncYXhs4gKhqflQg4w/uWlV57glY7EhX
X-Gm-Gg: AYBFou3a1pO86mjGwB1XKrF2CdJYZlTLCu2tcHV/mEitPuQ2Gx/QFEauNC4iDFt+pex
	nZjNf4jdLkJJ287vVXjrLLFA506GZ7U+ZXvCp3ElwM8jhWbrlyJwaPJcdyGciWuA0xmsIxpPNX0
	MkUvYALnUqBHq4DoPb1SsBnqBiWpfwpzHnJQB+Dk37rowy0WU7y3PxB99p19NyAvC5+bA6R/xhl
	fr2Rn1L+ux1bOLLZRtzUePPiXNI8heLejKIAYhurCnOTOY4tGxRvhiJuySiiAmuatNc5PehWlKc
	EM62H3gIRCcd78M+0QSHQN4MJ/ctUrYySHHWeRIQvSXacECN12e5Tb3+8JEHk3AXYHnAcWamhvr
	m4Na9W1pNfApgrgWKgQ00+SBrHRL68a2f2W12doqQyL4rDsxs+b3PsgahZkfkcnPotSahPOvQMw
	hZcVVIzOxrJo7IbrYNoq5BSBvAFVhG6aeHO2/UwVWR7A9skmzbHDg0J+hORHad/ioQeT/3JjZ8i
	iOxQs3Uu+7wdMjFURxH1XAYEWGO06DaeqFnEbqPbPO9YIzQXy8GIrcPAvtXrnTPhngkSuvqMv15
	pnGE3YLy5hoVGckMPH5T8WCxxofry51w559pLhqZW/SZFxyN1QBcI+VfX0FBIjA33jfnySVrGSn
	nJQ==
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id 5b1f17b1804b1-49d0e79635amr237510065e9.26.1789003972418;
        Wed, 09 Sep 2026 18:32:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:32:52 -0700 (PDT)
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
Subject: [PATCH v3 1/8] docs: kernel-parameters: Drop the atarimouse= entry
Date: Thu, 10 Sep 2026 03:32:38 +0200
Message-Id: <20260910013245.8619-2-kmehltretter@gmail.com>
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

Nothing in the tree parses atarimouse=. drivers/input/mouse/atarimouse.c
only takes a module parameter, and git log -S finds no __setup() for the
boot parameter anywhere in the git history, so the entry has been stale
since before it.

Drop the entry.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..c8d96de4c00d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -591,8 +591,6 @@ Kernel parameters
 
 	ataflop=	[HW,M68k]
 
-	atarimouse=	[HW,MOUSE] Atari Mouse
-
 	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
 			EzKey and similar keyboards
 
-- 
2.53.0
