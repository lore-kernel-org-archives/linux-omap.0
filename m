Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585143BDA0
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601642; cv=none; b=r/ufoHjJ7l1CQWw0aM6spal7tEjbwNl5fDWiyI37XWwDIVNXYt6j0z39Esmu1jcqCy3HECljgWyUV3ReNxqGhVZ4+M1HUbUrzb4BUDFV6QOd7/F8dg4IkGrred7e+THjI96ByuRN53t/D/dDCSPFnzYP6ATpHxPjUsrMBcP1c40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601642; c=relaxed/simple;
	bh=tXKjfoKiXZ7V6wID0vROu3EjAKBYvGUXtlTaR3CzeO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSJFV1QI5wdh4rkGqxTAEHmVeYuqQks0+ewy1pgmuNKWhXlAmBqxYJXr/7LZa2LraVD11GJ4BjIoYSPiqVNMwkmR+GOkxAPFYadoeSvGmS2k5S5ElgJvpF3YtLwjvHAIZgjcpMyu9ERTeOENI/977s1iYN3rGgQpZCZMwyuTwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEVPm1zf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEVPm1zf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495590dde14so26181535e9.0
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601633; x=1789206433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0boECcjjn/VFHFH6rk1vpO238PkXNlP4zHZKdanKNnE=;
        b=IEVPm1zfJ3dYP4k/o2iihvqOZUQoa934q5meWH63sSrsaeYufweygjH57c8MV9NFx+
         lkQAY6pKYddn41/9VK2PK5XddDJhNrdTbnuKAaBUqJQj/pQ1hH6uaKHFaFZpYydnqWif
         iYUdcJQ3zgkHLUpus7f+x7lrko4HImMasZiYYCKwX92AsuKXxzX4Y+PE06+v3awXu8z+
         aKzCjivlRQudT5FLIn5THmRE9Yuu+YyNddrBqUxqTa60piZAC4sp1gP0mr3F9Jdu435L
         vGAvspUcmCZfuLpNewH/64WPN2GxRDd6MstWVz0P/WNasjh8mB9Q/dxa4Btjp3Ij8KrL
         cImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601633; x=1789206433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0boECcjjn/VFHFH6rk1vpO238PkXNlP4zHZKdanKNnE=;
        b=XgWyPEtLYViWNWzjuQ3CEwFO64FgllaXr73jEUvmcaCcyDbOay/G05NtzbxFD53cPa
         50/C4+ZLCMXZGWh3QNKBfvEpa8TPmGOVV/7FVn8cKv3RzxhzW+ESdmN3IQU0VrM/b6Zh
         NN19qTcULvcVaFNLfwQnz4J6BkToAh9zejGeVm+Lj/gyrm2Tp2qDqyHujrD5W3Ns+zZJ
         RIOjAIaSx/8gFKTLhbMPNeD7ns4rngjoDedoJpweHBGFGNwf65yyT3HQ84F/5ek5RAu0
         ee7/zAzpFvvoi72lEqdK9G9RJGtoWuXhEcKRADDfqGogge2hucBKTfcB2t72KkX6pSfu
         gycg==
X-Forwarded-Encrypted: i=1; AKwUvByGGiUXYv17nfaim10JgOXaHB42lR8sJ35vWd0PcAegq7V3ZrZwTzPjpU3080SviZ5g8RNbBf0JvT+Y@vger.kernel.org
X-Gm-Message-State: AFuF++lSxTCE/Tf8kvSP8vAMg4Icc2TlmQuJYFdtmJSrLwB6Z8/9lni8
	e6hRG0lUklMOmmpXk0/LRma9hHVhjJDcIcyn9V2ADijr57GARinIPA15
X-Gm-Gg: AYBFou3dIUymGr8Lv9FoNLpOnw9LhBt5cTcQqASVRBKgIopCgl6zhxobYv6KaWw7Cxw
	TqH1XSE3IeR5m+PcU5kuHZXAEZe4dWX77p3IxRFLby2G5qbFv1HdUIfQYDankyKlO2v2oVzOQLr
	qONjcBqJyQG9qgNNfo1Tx8nbjV+DmijQxjE8dQVI765Sh1HohZzAAp/JW8LHE4i3x4ln89o2JIZ
	gI69mBgFCDjUyAyC3oFlnMIUACsIvKRfHX2fnf1GzC6K/5wMHgQmF7CXZ5BZlrRUlVtJhs4mSzI
	NI1v/od0ag8JJz+BPsmS0kSaolyWpYkTp71M66VngckuIDOQW+ESkjA0cF8w37gguBlBbXbs8yz
	Mfl96D1P+yILwsn6pgn6Cmp/qqOcgH8cYOXpGdk2iR1da57l+yTBoc5nA0LTZG9vj2RJsYR8utp
	xjHsrGd6iKMwEVFIHqGUI3ixH4BEw5yuGJ6MK5WCJeewGnYQbVoFIjZntRzqPERUh9fifzLDV/o
	ucJ0RWlMu1qgN6bGclRyls1uRKZUiLnCDsNoybQvbLX00zQH7i28mzx8nX+OpJSIpKyWbv6oXhA
	wXOYBZo9J3eUit+BdJz1xdWdqW8UNDNUjfSSFFXX1QiTr8ZhHwwhdcp2+/gIlcwSkU0=
X-Received: by 2002:a05:600c:8b11:b0:49c:edfe:d525 with SMTP id 5b1f17b1804b1-49cf82417f7mr260260105e9.10.1788601632697;
        Sat, 05 Sep 2026 02:47:12 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:12 -0700 (PDT)
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
Subject: [PATCH v2 7/9] docs: kernel-parameters: Drop the omap_mux= entry
Date: Sat,  5 Sep 2026 11:46:47 +0200
Message-Id: <20260905094649.41996-8-kmehltretter@gmail.com>
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

omap_mux= went away with commit e9f5f1e45608 ("ARM: OMAP2+: Remove
legacy mux code"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d44728a45506..48dd273eaf6c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4765,11 +4765,6 @@ Kernel parameters
 			waiting for the ACK, so if this is set too high
 			interrupts *may* be lost!
 
-	omap_mux=	[OMAP] Override bootloader pin multiplexing.
-			Format: <mux_mode0.mode_name=value>...
-			For example, to override I2C bus2:
-			omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
-
 	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
 
 			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
-- 
2.53.0

