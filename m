Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889703EB0E1
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601640; cv=none; b=VuMf4Rpvd3YDoHC3TX4ncWl7FaeuWGWLIYtT/FjGPY5yHTZK1fKFB3HDMmafbaYvK0xLE8zhpLyCoNjVk2T2KNbhksOOScZv3mOrZn6QkcafaADWLabHrUA8tbqCDMO24hNUXa07QZFMa5Wc5JknxRxvJ3AEK+Cp/9+b5f7v+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601640; c=relaxed/simple;
	bh=8GOJ1bBhkXnXFQ/xtc+4fZdZejRnue5u+K5BgJsvQus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcrDScfxit09J12HHSOU2Soc7arpZhnxtazQmVNcQinegXU2l/CAbWpw3txwtNJFgROc6tlOeo4LVWW7LWW1YbwyNNgH+3pjIK4AfBFV08VQyvfyOxI7kE4hNoW91B8ti0PHF4dUAFR9tpj7Lb040RAVupfhhGbQ/A7YLXOif0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucx/KA64; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucx/KA64"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48436216a98so1221191f8f.0
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601631; x=1789206431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=Ucx/KA64UP7YYy5FQQDaPv4iVpJGN9cu4a6gtRoYPN/MlsoWrBgL9kqhFiscfmpZzL
         r3p6A7rGwpSo6U00Cb10wjtr+mD6z0RLWlLAGmEE8eyqONRmuXoNkL/FV689kTIzZBWP
         gqEKeCMO2k4MN8VMPu92HuDd0AlqnTh1jQBi+ZvkLa0A7mZOm9Tkn1+mZhoGemzlxztQ
         YEtV2aJBvuK1aZt1EKWgo7D5sSEqC36gCblrWzvmQX3yyNe04+mJSOI0JWRmrg1dVZ71
         oylWSAJmkL2qP7fdvg4GTZMjKK5y7eqyXLGgH/+rq8Ob1Xept9jfj6uuti0/qYNUcrlG
         e3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601631; x=1789206431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=ZosZ8XbTcE5wAE01t9Daigqy1jvGZH7EkihO5N8EGEkqqmlgaaH6ffMnDqYmRHGnPu
         PNz7scNjiVi1m6tBKjzroAPl9/K7dVBJ+Z9ZC2d5rjy5NYMHsxs5YSYX/t+YOfezgELt
         Qyt5V0T5+roxscPEhwD/GPG23amNjnIHMc5HIFZQtXjGUQlNC/f/Hy4h7mkOcVAzMQF5
         zX7J4Clhm7HNPWeVgisXiilr4fyR/SlRljuWRfnJf8C6My3YHWQngk/5FOso/pmnwgDD
         Y0V8HsJJG9u/d5qxbqv1cyf/9GK1w/3rtAIFId9UDaLE7CTzMbo+JvPDLSuWax21+1Zm
         Miow==
X-Forwarded-Encrypted: i=1; AKwUvBz2QxERonhVo0AWo1lcih2vh0OBvTFBQVW3oyiRLgV8oqtiyirkPTxZcw5YX1TW46WFWfx+tzl5lXlp@vger.kernel.org
X-Gm-Message-State: AFuF++nngMqsysw1c0DtPOIfjNIoHE4qA0TW4QpO+5dHgUWjT2Z/wpGf
	Y3QxmS14xviPLHePssfF0iB1QntKvYUUgp0+Fzuei8fdm7qRCykzqn4R
X-Gm-Gg: AYBFou3M6g3zTs9aYGnCOl0YyScv8zjYEMwSYfgieixGR63wIiP3fEdJsYkFBWJbEj4
	mFNTOsSRkDBTx/Va+yYGuI+N6rSNwQbIDS3g63sZ12Mbv2YVFChrKUzH1RfcF92rRY41aqFBWh6
	XfPZTxTwkCp8YZ8CjL3QVduoIsOf9THZFsmkOPvXfoav7BXkB4lwYt+iXpUX9kV7Y2cgMCjJw5L
	BcZAtSPtbJBACGVrtcHMjOv+Sb1CJtAduIrUqVzidJYMFpOgdTrvUNC/2yWFg/5xfZZQ4vmDk8j
	/ysRYTJyuvMggNCsC8vHWEeEVc6EkIaCiy/NajRRJkaPL6CT/Mi5xsD3Du1iJbaQIOQ360idAXH
	PvaNqAXWox8Qy0lDAcVr/EJz26Jrj6Hi+0aVD2bZVgixZDx3v8QCxxAU94zV0DNb3jxOXOm24XH
	0WvtfDNrQAqhFe35KTf3pRfUAml/Uz4LZ9yAfKFPEkXLTiy0rJ1fRXZrZMan4RmQa9b5I27ROKS
	7rvHgE1tzcpZQZHS1szazah5w8lHJja9VWF+KSvRljncMw7F8obXk0xodTgC2udR6hAkr12yIWo
	MjW77XX4hDOxa8yfjaT7S7SF4TmR11ZOyouDHFPYmvwnj6jXlx8P+QN+3GhAWmOLwUaH
X-Received: by 2002:a05:6000:2584:b0:482:b813:8315 with SMTP id ffacd0b85a97d-485872ac3b1mr14547032f8f.21.1788601630963;
        Sat, 05 Sep 2026 02:47:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:10 -0700 (PDT)
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
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 6/9] docs: kernel-parameters: Drop the nomfgpt entry
Date: Sat,  5 Sep 2026 11:46:46 +0200
Message-Id: <20260905094649.41996-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905094649.41996-1-kmehltretter@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
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

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
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

