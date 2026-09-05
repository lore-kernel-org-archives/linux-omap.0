Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EE3E315F
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591860; cv=none; b=O5Bt4HR/9cHqzKzQ0D83mK7guQVAYNy69scLeFrPxLyJkQxXWkDdjBtjQ1fRqOuyP6tKLw1bee0m5kgQSevwRquCv48Y9xWm53oTLEvLj3kS5ML/fEZrCLVHgeHx3pijlE4RVaRmIOUQdG46a//dqdiSNwoXs9inqqe26eAI3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591860; c=relaxed/simple;
	bh=ItZT5GNunHVnueIdaFQjAOk/BPjP1n6HkFAdihTWgYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ab01KqKGanGq7pDnZvbHS/2f+6OqYbzIETRDFwbJhfb6gWPRyliyqan8pqmmEqBkPCPeio3GCJxGhcr4/9DEUrUfuTEBbotaBCY+ZUiaDyYhyli+GSAM2YQBwya33ULCdQjqMGzj+WCjpcurgtd8YgwesqkVJGFokik4wxQczs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ot2TgaTS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot2TgaTS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482dd6ee390so1912763f8f.3
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591848; x=1789196648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFzQQFmCjPVcuR+l7FGQ0u8MffPmow8qd7a6fWjai5g=;
        b=ot2TgaTSFyf0JGzHOS0qVEAf6ZxzDDZ9GbwaoviLSwiAMvTFLOKcRxlwvGcTuqHzw5
         EkRs1xP7nf03aZMrJAMt2A4vqFH6X5rfGTK0/Vyri5Ijk2c4UffB1TcG58IRkXtYgSV1
         Lqiczg4F7DVsT/bfD8Dx4iw+ZCRZ0G+oAO5ESiQxUiSEN3HFL52rQVd2QFAYy01WVJvc
         AuwmYB7H4ehU2TRk4SWu99reuV00ExXtZkNHcXcIzps/tOjkWE+FX3P8hYqnEYJ1/MCI
         dpBI0NJG8Rj8bLcFMvzVpenCY3Q55LPB62VZMu36usLLEDEOOWtHzGUhvARquerAn5BG
         Sbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591848; x=1789196648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kFzQQFmCjPVcuR+l7FGQ0u8MffPmow8qd7a6fWjai5g=;
        b=dcFtK1P5GJDpOkbpOV8630XLXGQu4kB267ocoQ/oTtyFj6/41kbhVaacqaN/t9bSZS
         kmG90SG+HL1AS23s5C4w3rp6lvv8UT1aQzQm/equUPugVK2hr5acp+zubcQ6wQGl6elE
         vBA0I+gjsA8E1paCM0FfTGJP/rleIpyNLy2lPj0DhjV/TpLCwl4KpCnwi56uemIhPrue
         BIFKKEf7rykWidO6bTacjTHsnJtmLaeF7nSx0AKo4CYYORLqCgk39DhbD4gnESG9TpyD
         072Teyj4FsDCy5LP+UZqZX9PlkHvd96EKsB1l2FrJ0VJOtfGKHUKx0gWltmnQP7Gjcu9
         oW+A==
X-Forwarded-Encrypted: i=1; AKwUvBwIxQjCNshUuYe327CZszm3aj/9tbI7o3gLDS1Pzg8iOk2rO1x3/HtvoeLKwSKE1wgPlt1kljqKpQrk@vger.kernel.org
X-Gm-Message-State: AFuF++nN/VVu3CrkihudyC/H8ys9HYRFgcZh6t1dlRaSnSWOB2a7azdj
	uuq0gvxoheO09sMiuA9mH4JHad5BfLX1ClV3qTXJl/GYr1lfVg90UUA4
X-Gm-Gg: AYBFou33AQQbW5USh0pw5oxmtEqO5QsgfrfygXVGNhmSvEdJDQD6uaP05xwnIbKF6xE
	CiMlWkKh2CXiyP5tC7sHFW/lolMPf+TTyQikQRxHpz11wmJQBcupYTm8yVaIjjXk28bUzy10XIs
	mvcKvh18Y09F7QooYioC2e6JENSGyNHj/maWNLs8JU6jBPN/hQpA7u4pZgekHV0K4sxENLt6s6G
	XWjYWAlau8BIAI47Ar1vl++Hi/NcScNPTI7vcuMk14gq4DeyFTwRG4lFg6c/q5jUlOAVdtkCNyo
	Wz5HjYl1KUWjwWz9Ol6THMM6jn/FQBNdrsU68Zgk1tMv0cIAIP+n9jAskBspbUIgPj2HFMEgZsC
	2m2aTCftcByHBKjjnNeMTdNBaqkfOkn9Yv5fgYXwjRURSHt5s3J7x0vEcjwXr5AhdHaVogItRYs
	UYqWjQSCOM5RNy1c8Nt15R9BDkl2O+6b1w6eRstSwftxWFE25VgZwcgd6xfbAMciQVbGo39sbeo
	drRFthxLj2bEvRPCDR02fkFY39X7ETGDSXpj4yEw7+/gpwrUkLu44LbJW3NlpdkZ0EZCPSjKu+J
	w+WOMQ5nPNtBcgH92Z2y+lwCt5ki/MWUk3MfjXioBY4bln6ENClP8fnJ3daLXcFRNPqmPGeLNHM
	f0TfhbGE=
X-Received: by 2002:a5d:5f55:0:b0:481:503b:b663 with SMTP id ffacd0b85a97d-48587091856mr13328658f8f.18.1788591847580;
        Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
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
Subject: [PATCH 7/9] docs: kernel-parameters: Drop the omap_mux= entry
Date: Sat,  5 Sep 2026 09:03:45 +0200
Message-Id: <20260905070347.25902-8-kmehltretter@gmail.com>
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

omap_mux= went away with commit e9f5f1e45608 ("ARM: OMAP2+: Remove
legacy mux code"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
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

