Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238AB364E89
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003997; cv=none; b=BfgKL6LixgeH1G5jC7N7N5S+7nzg16SJfTSAG+UxfgPLvy0cCITUeGFATrhAStGyRkpQ8Fs+3JVFefPAd+uRF5nwTPpvdY9XjzRZ98lT+br2yzvWyINIZ2Lnb1j8M9igA8fRZY5zjL6suAzePe4bhYYuyZjFymAYXo9kb0WAIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003997; c=relaxed/simple;
	bh=ZYFLiiSEbPgU0+ZjsS1KNzdvmrfyUGct38CSb+7KC10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVG5PKRwMB1iLn1Epz40+OrrROks2aKpGv7zK4m2YDPSpGTrGOEjWIccjgA2hMaL6tDA06ExnXZP/x/4UE/IBOG5M7GmIlmiayhE7GyYxC4b1tJyECLV+bS8SXGDk2tivYuj7s/FpjVCC8w+6ulfP3z9UsdjltBtrIQYWYJKuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKOsMtbD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKOsMtbD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso68935055e9.1
        for <linux-omap@vger.kernel.org>; Wed, 09 Sep 2026 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003988; x=1789608788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gFP28iKq1M/HJk3t4X9byGhtWcmOOGCTOZxmuDlWN0=;
        b=CKOsMtbDLmlvqC8UoICufqDEvkMqZRt2CNhavbyp+Wp4tgCcZvOZel11M4HI5DDmnO
         ZAzzXbIWC1dy0RP9A1G0s94vYDEvR/IfMcm4AokLVmIzvRZGmoJXnyFEHsVQ4ZhfxFxN
         vS/7t5ODxV7m+iWr7weuwS67oq8/8AgHKnG6MsC5+hdHRbHkqRbr462hkCSppYgvs5tg
         /gfLDyDd7IjuI/rLVfo/8ltTx9CDAaHReuOyntpOAHsz2jFwB9GUDKnNR/G/rBJeqiSi
         BSURrWL3KxAM2vuO0xHeT4gJRhUNeK1sSMjJIFbAvI+BweQVtCZaYJhYMQLknpfNySl4
         phNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003988; x=1789608788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gFP28iKq1M/HJk3t4X9byGhtWcmOOGCTOZxmuDlWN0=;
        b=K0Ubt+c+S9w3MKNYafhVnNKkkdx9Q6Q7gq5qTcdzZI+tLJXUfGJDPU/8N+06/qSzKR
         chRoI25yJw1+ZmQEbJIKKYdfGXzs+mJCYXDiPymh7HA9CWFJvBSinMF41CN6x5fMUKpe
         W/cYmb6dHdf0NWzBNWcIeoX5mBoK4KuMQqh6lJCvOtvB3RPmcNdkKcKhZp+U+5nhaMIE
         tmKUEtWCN5pY8IcqWN27qLxIJpbS8W+99dh6PApx3A1bYGNn01Ha56PSUnci/29gVQYf
         /HpMjvqiFPZLMPRRNmvayDUUeyNAml8UGofwpa31COhwO+WVsAeBbJsbxOwrCu8JGDsl
         TjlA==
X-Forwarded-Encrypted: i=1; AKwUvBxjaT+ynaCeyFzBzftuVAJVi8kCwjoxnFoCttGYMFsDFTdDUKgZ/yx8z1TWWrmopzw51YQQX6KurOu5@vger.kernel.org
X-Gm-Message-State: AFuF++mSCHoU7Bf+f5DLEjlsVJ5sHkj9lyNHm2AytqiWFwaCYA6mSIoX
	ezEKfEO4CYh33YSxXvj0QJFSolrRw+rIZmgl8IyqNTBYbgkN0o4IOY6x
X-Gm-Gg: AYBFou0BHzcKad9Q1YpyKkSuKsrHgPszo1cqC5dCkrXUpzjtiyDVv9MpcBkbcK4cqeX
	2IlQUs9AaNQBD7iaHwwBxkWGKP47b2vZ3P+p1TfUeEN9js/Nxu1mvAQNqawfHuPdCWdd4u2cH6J
	tUktVNbkoAky1Z08QlK0D8aMEVRm1Vll/lOkofsDJffhbfWociWWgS13zTlYsTRy22ibAhevMV5
	PyxahwTupphmISA9k5fv/+LLV9xQyXbYmew8KGqhFMKZNQfVxZwmI52hRnPqlWC/zMKNgdRrAtQ
	4T+mRuul8zazalb0ZIqPWbukESaxFkXZntKKYDzs+Lx8lwFLSMp/NDjJ54AOCzIaDhZBxxfaoux
	vqRulX4fxuuE/rWfVp8E3x+hu4FkLeXEXRSSUsqslQy8njx8YTADR+3x1uySGBmmu1UCz83lcMI
	Epo1NRo+7oWA/HkYwqEaHPSFK8Q9uMh2dBLLS/2JRcO8asT27lij5xpeMbIHiZc9iLpv/tQgXpp
	XdfaKA6wzU+N/JSlI/5CUj7y/JnPwgdt7ERu9rZBYkV2HcHCU4/W9AXimyxNfo2/db0T4Z43Yfp
	w6ruZTNrzfpCACEvW0lpSr8Yj1K0Xmgl7np6+VshG6HhQA6e8AsCeEHN8HmDkb8gKARYsGAh8rt
	S4A9gv3JYDDuA
X-Received: by 2002:a05:600c:6305:b0:49d:2803:22fe with SMTP id 5b1f17b1804b1-49d28032d49mr11185475e9.32.1789003988252;
        Wed, 09 Sep 2026 18:33:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.33.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:33:07 -0700 (PDT)
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
Subject: [PATCH v3 8/8] docs: kernel-parameters: Drop the pcmv= entry
Date: Thu, 10 Sep 2026 03:32:45 +0200
Message-Id: <20260910013245.8619-9-kmehltretter@gmail.com>
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

pcmv= went away with commit 7aeffbf2ddec ("pcmcia: remove unused
pxa/sa1100 drivers"); nothing parses it any more.

Drop the entry.

Fixes: 7aeffbf2ddec ("pcmcia: remove unused pxa/sa1100 drivers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 48dd273eaf6c..4864e37005be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5311,8 +5311,6 @@ Kernel parameters
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
-	pcmv=		[HW,PCMCIA] BadgePAD 4
-
 	pd_ignore_unused
 			[PM]
 			Keep all power-domains already enabled by bootloader on,
-- 
2.53.0
