Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8D3655DD
	for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003984; cv=none; b=RLgYG5v+NhsfaEx3VbwepTMmX5vStVmexlunCVFGeTBRhhJl7o7qaeguBM2CuSL5sM/GoG4niJGWMeVp9f/geKrI38bGPKS/91J80T1vn3QI/zpwburOgSIZHxKBrjL6mrl2icnFcgRw+L4F1QjMVVDEn0gRs6IArFUFd0TFQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003984; c=relaxed/simple;
	bh=GhxAkOxBMRZ6zZ0dFT8xEiFSpjQVEMyU/AlCAWxV42c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJqsd7W0u8vw8OXiOUnAATOMbbE/3dht9PaD3LUyvjtNtAnywuK/zzVHTfwH/xAto5Nz0bhkIVBJ269hqxVVADyDjiD1DJGf2iOpkDDJ1PWJr492Uz03/BqVbWjDCuMeWvqshrnz/eSHmOuuf5ib1jqHyd3ZZW9sAuhJMRuHn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRweCLTm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRweCLTm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so64364575e9.2
        for <linux-omap@vger.kernel.org>; Wed, 09 Sep 2026 18:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003978; x=1789608778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjlutxGiX8pDK8sYanBqVVvMMg/4+no/0Rn14LPE0yU=;
        b=FRweCLTm6hE3ScM5rUKdIWX5D7IO1QOebFr3bYP+SSYn9YSUEJHgyo5FvyiH9fcwWW
         VFae+jdUNq6ZO6o8BpPSdywlUJajJnyod/kMpE+ToJY8Kx3bMwhqTO1MqUQtvVa0/Q4F
         wmZzOapWlNvP9mwiH1l3LoiMAIJ5iIcCxAxWx36PcOth7Ggz9K+SawijHILWpafUrJ+b
         Lk/KRZBmoeYSzAz7fF1VQiQ/y2O06+Ne68fCggfjJmtoBIxkkzBotfjm9RmCGc4cdspI
         YpCuMc2khwnt9wHBpJ98PJ0FGUY+BcFJyrhiJxuny3GHQpD2livSiQnzowuzp9aFOx4E
         TSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003978; x=1789608778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjlutxGiX8pDK8sYanBqVVvMMg/4+no/0Rn14LPE0yU=;
        b=tH9s3pdTBj61jOGRPq/dfBvOm9J5goxaONRAnqUreacdjFjGQFH5foVe6n3p/T93LT
         MuDR0MgXfvlwERgDyVMlwvtO0S0lF2pRucON+xenvaL6UoGvjbtWxcyVyXt623P/VDeK
         l4GecgdQum5bEVfiwgengLlxhOU5b6ZTdUqu54GbCqBoiFrCZMLHklBWdvK0N/s9UMN8
         SMDB1r8xxrEl8v7HbdFLi8QFOI6o51ODncuxDkB/l29VJs1uuQdAgteN8QQ77HOIPSAq
         S/k3oJk1mnB3wnXAv7lAUUHUpKcrUZjtHFu8RNaipcval07afZHIXg+jIm9aoLG6sjZU
         QsKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzM/E1CeF1KbQFFG7jxvz1pP+y7M1rmpgjPAyLk++lfCDXxPDHQqDommvKLtTbmC04yJd4qkmJP5nF0@vger.kernel.org
X-Gm-Message-State: AFuF++lP0ZHpgzdWhTrEUgNMC4gnesVWi523ji/h0qMKYeIQwVjhyYvf
	4dLAp0DoMOIZs5tWXiL52PeuaCMJHd57lLrKIK9m7e6Mo7TLKErlnxFk
X-Gm-Gg: AYBFou3n1QDBDK6EQUPKvd/YXH/aPF1y5ed1/n/vch13xHH5PaIA22G+0TAdmWkah3h
	3tLwY51fZ6uTTjjJUFMxV7I0//zoARLB3iQpNHCCKADkg06Bk7NNAW5QmvAabwPLGCi+U8koAsf
	Qwm+5tD8iMsknwxpdUMO1WLwsA1wnNiRcZnxGrte6sxTwFDET5t6gl0wSbjcDqUfYxXNZrcsDgN
	/PsNJcfyxhU/vJ0Br3TpdkGmlTm9e4Z7mHVaY+RKQZRRtivB4fH64l5azam23uXR6/WG/9CquEY
	blnWzm5ZHvrjTvv+Vb6BJdNUGRPsCaSjhWMIwmQYaGjcQAGN5NeTxLqf4JvqhWos+DV0P5JhM35
	hE74fHOywlVktz8XGUZXAIjCctxSTCr8rL+2NR2jAqdrcdExAcWkZ7HMeqlca8sHrDk4aXYf9K/
	Xv5Z6jRpckhFZhHMzS6zIiVkYuAIyGd0mHVs9mfzqtF+5M7hkFGY7q1jY94X7EUdPo2Zsge5g5x
	nfMzKBuwYYyf3YwQuLQlVgVuAOngavKSvvdFwV8n2EaxnneajkQuGDPjRXRBVM6UgHTRGiyNuE7
	1i1vGBV9HUTfsAwb6IeVrmozaC3cSrWyQrvByyDMT4AbxZWSHLZN5bQb0wq7fQNEe9NURu6u/Pq
	53w==
X-Received: by 2002:a05:600c:1c29:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49cfc6cc06cmr366891825e9.26.1789003977900;
        Wed, 09 Sep 2026 18:32:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:32:57 -0700 (PDT)
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
Subject: [PATCH v3 3/8] docs: kernel-parameters: Drop the edac_report= entry
Date: Thu, 10 Sep 2026 03:32:40 +0200
Message-Id: <20260910013245.8619-4-kmehltretter@gmail.com>
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

edac_report= became the edac_core.edac_report module parameter with
commit fee27d7d9788 ("EDAC: Delete edac_stub.c") and went away with
commit 7fc0b9b995f2 ("EDAC: Drop the EDAC report status checks");
nothing parses it any more.

Drop the entry.

Fixes: 7fc0b9b995f2 ("EDAC: Drop the EDAC report status checks")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v3: name the right commits, Fixes: tag moved to 7fc0b9b995f2 (Boris)

 Documentation/admin-guide/kernel-parameters.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 99d5bb68968a..2a8d862ef30f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1578,14 +1578,6 @@ Kernel parameters
 			PCI device even when its classcode is not of the
 			UART class.
 
-	edac_report=	[HW,EDAC] Control how to report EDAC event
-			Format: {"on" | "off" | "force"}
-			on: enable EDAC to report H/W event. May be overridden
-			by other higher priority error reporting module.
-			off: disable H/W event reporting through EDAC.
-			force: enforce the use of EDAC to report H/W event.
-			default: on.
-
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
-- 
2.53.0
